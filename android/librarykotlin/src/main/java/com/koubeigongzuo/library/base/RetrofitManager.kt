package com.koubeigongzuo.library.base

import com.blankj.utilcode.util.LogUtils
import com.blankj.utilcode.util.NetworkUtils
import com.google.gson.Gson
import com.koubeigongzuo.library.app.App
import com.koubeigongzuo.library.config.BaseNetValueConfig
import okhttp3.*
import retrofit2.Retrofit
import retrofit2.adapter.rxjava2.RxJava2CallAdapterFactory
import retrofit2.converter.gson.GsonConverterFactory
import java.io.File
import java.io.UnsupportedEncodingException
import java.net.URLDecoder
import java.util.*
import java.util.concurrent.TimeUnit

/**
 * @author wyman
 * @date  2018/5/7
 * description :
 */

@Deprecated("请使用retrofitHelper")
class RetrofitManager {


    companion object {

        private const val CONNECT_TIMEOUT = 60L
        private const val READ_TIMEOUT = 10L
        private const val WRITE_TIMEOUT = 10L
        //设缓存有效期为1天
        private const val CACHE_STALE_SEC = (60 * 60 * 24).toLong()
        //查询缓存的Cache-Control设置，为if-only-cache时只查询缓存而不会请求服务器，max-stale可以配合设置缓存失效时间
        private const val CACHE_CONTROL_CACHE = "only-if-cached, max-stale=$CACHE_STALE_SEC"
        //查询网络的Cache-Control设置
        //(假如请求了服务器并在a时刻返回响应结果，则在max-age规定的秒数内，浏览器将不会发送对应的请求到服务器，数据由缓存直接返回)
        const val CACHE_CONTROL_NETWORK = "Cache-Control: public, max-age=10"
        // 避免出现 HTTP 403 Forbidden，参考：http://stackoverflow.com/questions/13670692/403-forbidden-with-java-but-not-web-browser
        private const val AVOID_HTTP403_FORBIDDEN = "User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.95 Safari/537.11"
        @Volatile
        private var mOkHttpClient: OkHttpClient? = null
        /**
         * 云端响应头拦截器，用来配置缓存策略
         * Dangerous interceptor that rewrites the server's cache-control header.
         */
        private val mRewriteCacheControlInterceptor = Interceptor { chain ->
            var request = chain.request()
            if (!NetworkUtils.isConnected()) {
                request = request.newBuilder()
                        .cacheControl(CacheControl.FORCE_CACHE)
                        .build()
            }
            val originalResponse = chain.proceed(request)
            if (NetworkUtils.isConnected()) {
                //有网的时候读接口上的@Headers里的配置，可以在这里进行统一的设置
                val cacheControl = request.cacheControl().toString()
                originalResponse.newBuilder()
                        .header("Cache-Control", cacheControl)
                        .removeHeader("Pragma")
                        .build()
            } else {
                originalResponse.newBuilder()
                        .header("Cache-Control", "public, only-if-cached, max-stale=$CACHE_CONTROL_CACHE")
                        .removeHeader("Pragma")
                        .build()
            }
        }

        /**
         * 日志
         */

        class LogInterceptor : Interceptor {
            private val tag = "LoggerInterceptor"
            private var content: String = ""

            override fun intercept(chain: Interceptor.Chain?): Response {
                val request = chain!!.request()
                LogUtils.e(tag, "request:" + request.url())
                val headers = request.headers()
                for (i in 0 until headers.size()) {
                    val headerName = headers.name(i)
                    val headerValue = headers.get(headerName)
                    LogUtils.e(tag, "Header----------->Name:$headerName------------>Value:$headerValue\n")
                }
                val requestBody = request.body()
                if (requestBody is FormBody) {
                    val rootMap = HashMap<String, Any>()
                    for (i in 0 until requestBody.size()) {
                        rootMap[requestBody.encodedName(i)] = getValueDecode(requestBody.encodedValue(i))
                    }
                    LogUtils.e(tag, "params : " + Gson().toJson(rootMap))
                }
                val t1 = System.nanoTime()
                val response = chain.proceed(chain.request())
                val mediaType = response.body()!!.contentType()
                val originalBody = response.body()
                if (null != originalBody) {
                    content = originalBody.string()
                }
                LogUtils.e(tag, "response body:$content")

                val tookMs = TimeUnit.NANOSECONDS.toMillis(System.nanoTime() - t1)
                LogUtils.e(tag, "time : " + " (" + tookMs + "ms" + ')'.toString())


                return response.newBuilder().body(ResponseBody.create(mediaType, content)).build()
            }

            /**
             * 解决中文乱码结果集
             *
             * @param value
             * @return
             */
            private fun getValueDecode(value: String): String {
                try {
                    return URLDecoder.decode(value, "UTF-8")
                } catch (e: UnsupportedEncodingException) {
                    e.printStackTrace()
                }

                return value
            }
        }

        /**
         * 获取OkHttpClient实例
         *
         * @return
         */
        private fun getOkHttpClient(): OkHttpClient {
            if (mOkHttpClient == null) {
                synchronized(RetrofitManager::class.java) {
                    val cache = Cache(File(App.instance.applicationContext.cacheDir, "HttpCache"), (1024 * 1024 * 100).toLong())
                    if (mOkHttpClient == null) {
                        mOkHttpClient = OkHttpClient.Builder().cache(cache)
                                .connectTimeout(CONNECT_TIMEOUT, TimeUnit.SECONDS)
                                .readTimeout(READ_TIMEOUT, TimeUnit.SECONDS)
                                .writeTimeout(WRITE_TIMEOUT, TimeUnit.SECONDS)
                                .addInterceptor(mRewriteCacheControlInterceptor)
                                .addInterceptor(LogInterceptor())
                                .build()
                    }
                }
            }
            return mOkHttpClient!!
        }

        /**
         * 获取Service
         *
         * @param clazz
         * @param <T>
         * @return
        </T> */
        fun <T> create(clazz: Class<T>): T {
            val retrofit = Retrofit.Builder()
                    .client(getOkHttpClient())
                    .addConverterFactory(GsonConverterFactory.create())
                    .addCallAdapterFactory(RxJava2CallAdapterFactory.create())
                    .baseUrl(BaseNetValueConfig.SERVER_URL)
                    .build()
            return retrofit.create(clazz)
        }
    }


}