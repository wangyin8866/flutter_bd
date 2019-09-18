package com.koubeigongzuo.library.base

import android.content.Context
import com.blankj.utilcode.util.*
import com.google.gson.Gson
import com.koubeigongzuo.library.app.App
import com.koubeigongzuo.library.config.BaseConstant
import com.koubeigongzuo.library.config.BaseNetValueConfig
import com.koubeigongzuo.library.net.SSLSocketClient
import com.koubeigongzuo.library.utils.PreferenceData
import com.koubeigongzuo.library.utils.PreferenceLocal
import com.koubeigongzuo.library.utils.getAppMetaData
import okhttp3.*
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.adapter.rxjava2.RxJava2CallAdapterFactory
import java.io.File
import java.io.UnsupportedEncodingException
import java.net.URLDecoder
import java.util.*
import java.util.concurrent.TimeUnit

/**
 * @author wyman
 * @date  2018/9/3
 * description :
 */
object RetrofitHelper {
    /**
     * 登录，验证码
     */
    private var retrofit1: Retrofit? = null
    /**
     * 其他
     */
    private var retrofit: Retrofit? = null
    /**
     * token
     */
    private var token: String by PreferenceData(BaseConstant.KEY_TOKEN, "")
    private var registration_id: String by PreferenceLocal(BaseConstant.KEY_REGISTRATION_ID, "")
    private var device_id: String by PreferenceLocal(BaseConstant.KEY_DEVICE_ID, "")


    /**
     * 获取Service
     *
     * @param clazz
     * @param <T>
     * @return
    </T> */
    fun <T> create(clazz: Class<T>): T {

        return getRetrofit()!!.create(clazz)
    }

    fun <T> create(url: String, clazz: Class<T>): T {
        return getRetrofit(url)!!.create(clazz)
    }

    private fun getRetrofit(): Retrofit? {
        if (retrofit == null) {

            synchronized(RetrofitHelper::class.java) {
                if (retrofit == null) {
                    retrofit = Retrofit.Builder()
                        .baseUrl(BaseNetValueConfig.SERVER_URL)
                        .client(getOkHttpClient())
                        .addConverterFactory(ResponseConverterFactory.create())
                        .addCallAdapterFactory(RxJava2CallAdapterFactory.create())
                        .build()
                }
            }
        }

        return retrofit

    }

    private fun getRetrofit(url: String): Retrofit? {

        retrofit1 = Retrofit.Builder()
            .baseUrl(url)
            .client(getOkHttpClient())
            .addConverterFactory(ResponseConverterFactory.create())
            .addCallAdapterFactory(RxJava2CallAdapterFactory.create())
            .build()




        return retrofit1

    }

    private const val CONNECT_TIMEOUT = 2 * 60L
    private const val READ_TIMEOUT = 2 * 60L
    private const val WRITE_TIMEOUT = 2 * 60L
    //设缓存有效期为1天
    private const val CACHE_STALE_SEC = (60 * 60 * 24).toLong()
    //查询缓存的Cache-Control设置，为if-only-cache时只查询缓存而不会请求服务器，max-stale可以配合设置缓存失效时间
    private const val CACHE_CONTROL_CACHE = "only-if-cached, max-stale=$CACHE_STALE_SEC"
    //查询网络的Cache-Control设置
    //(假如请求了服务器并在a时刻返回响应结果，则在max-age规定的秒数内，浏览器将不会发送对应的请求到服务器，数据由缓存直接返回)
    const val CACHE_CONTROL_NETWORK = "Cache-Control: public, max-age=10"
    // 避免出现 HTTP 403 Forbidden，参考：http://stackoverflow.com/questions/13670692/403-forbidden-with-java-but-not-web-browser
    private const val AVOID_HTTP403_FORBIDDEN =
        "User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.95 Safari/537.11"
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
                .header("Cache-Control", "public, only-if-cached, max-stale=$CACHE_STALE_SEC")
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
                LogUtils.e(tag, "Header---->Name:$headerName---->Value:$headerValue\n")
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
                LogUtils.eTag(tag, "content:$content")

            }
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
            synchronized(RetrofitHelper::class.java) {
                val cache =
                    Cache(File(App.instance.applicationContext.cacheDir, "HttpCache"), (1024 * 1024 * 100).toLong())
                val loggingInterceptor = HttpLoggingInterceptor()
                loggingInterceptor.level = HttpLoggingInterceptor.Level.BODY

                if (BaseConstant.KEY_IS_HD == 1) {
                    mOkHttpClient = OkHttpClient.Builder().cache(cache)
                        .connectTimeout(CONNECT_TIMEOUT, TimeUnit.SECONDS)
                        .readTimeout(READ_TIMEOUT, TimeUnit.SECONDS)
                        .writeTimeout(WRITE_TIMEOUT, TimeUnit.SECONDS)
                        .addInterceptor(addHeaderInterceptor())
                        .addInterceptor(mRewriteCacheControlInterceptor)
                        .addInterceptor(loggingInterceptor)
                        .addInterceptor(AddCookiesInterceptor())
                        .addInterceptor(ReceivedCookiesInterceptor())
                        .sslSocketFactory(SSLSocketClient.getSSLSocketFactory(), SSLSocketClient.getTrustManager())
                        .hostnameVerifier(SSLSocketClient.getHostnameVerifier())
                        .build()
                } else {
                    mOkHttpClient = OkHttpClient.Builder().cache(cache)
                        .connectTimeout(CONNECT_TIMEOUT, TimeUnit.SECONDS)
                        .readTimeout(READ_TIMEOUT, TimeUnit.SECONDS)
                        .writeTimeout(WRITE_TIMEOUT, TimeUnit.SECONDS)
                        .addInterceptor(addHeaderInterceptor())
                        .addInterceptor(mRewriteCacheControlInterceptor)
                        .addInterceptor(loggingInterceptor)
                        .sslSocketFactory(SSLSocketClient.getSSLSocketFactory(), SSLSocketClient.getTrustManager())
                        .hostnameVerifier(SSLSocketClient.getHostnameVerifier())
                        .build()
                }
            }
        }
        return mOkHttpClient!!
    }

    /**
     * 设置公共参数
     */
    private fun addQueryParameterInterceptor(): Interceptor {
        return Interceptor { chain ->
            val originalRequest = chain.request()
            val request: Request
            val modifiedUrl = originalRequest.url().newBuilder()
                .addQueryParameter("client", "")
                .build()
            request = originalRequest.newBuilder().url(modifiedUrl).build()
            chain.proceed(request)
        }
    }

    /**
     * 设置头
     */
    private fun addHeaderInterceptor(): Interceptor {
        return Interceptor { chain ->
            val originalRequest = chain.request()
            val requestBuilder = originalRequest.newBuilder()
                .header("Authorization", token)
                .header("Content-type", "application/json; charset=utf-8")
                .header("register-id", registration_id)
                .header("device-id", device_id)
                .header("app-platform", "Android")
                .header("app-version", AppUtils.getAppVersionName())
                .header("channel-no", getAppMetaData(App.instance.applicationContext, "UMENG_CHANNEL"))
                .removeHeader("User-Agent")
                .addHeader("User-Agent", getUserAgent())
                .method(originalRequest.method(), originalRequest.body())
            chain.proceed(requestBuilder.build())
        }
    }

    /**
     * 首次请求cookie为空，需要从响应报文中获取，并保存到客户端的首选项中。
     */
    private class ReceivedCookiesInterceptor : Interceptor {
        override fun intercept(chain: Interceptor.Chain): Response {
            val originalResponse = chain.proceed(chain.request())
            if (!originalResponse.headers("Set-Cookie").isEmpty()) {
                val cookies = HashSet<String>()
                for (header in originalResponse.headers("Set-Cookie")) {
                    cookies.add(header)
                    cookies.add("ga=1")
                }
                val config = App.appContext.getSharedPreferences("config", Context.MODE_PRIVATE).edit()
                config.putStringSet("cookie", cookies)
                config.apply()

                LogUtils.eTag("cookie", cookies.toString())
            }

            return originalResponse
        }

    }

    private class AddCookiesInterceptor : Interceptor {
        override fun intercept(chain: Interceptor.Chain): Response {

            val builder = chain.request().newBuilder()
            val preferences =
                App.appContext.getSharedPreferences("config", Context.MODE_PRIVATE).getStringSet("cookie", null)

            if (preferences != null) {
                for (cookie: String in preferences) {
                    builder.addHeader("Cookie", cookie)
                    LogUtils.eTag("cookie", cookie)

                }
            }

            return chain.proceed(builder.build())
        }

    }

    private fun getUserAgent(): String {

        return "Android/" + AppUtils.getAppVersionName() + "/" + AppUtils.getAppPackageName() + "/" + DeviceUtils.getManufacturer() + "/" + DeviceUtils.getModel() + "/" + DeviceUtils.getSDKVersionName() + "/" + ScreenUtils.getScreenWidth() + "*" + ScreenUtils.getScreenHeight()

    }
}