package com.koubeigongzuo.library.app

import android.annotation.SuppressLint
import android.app.Application
import android.content.Context
import android.text.TextUtils
import androidx.multidex.MultiDex
import androidx.multidex.MultiDexApplication
import com.alibaba.android.arouter.launcher.ARouter
import com.blankj.utilcode.util.LogUtils
import com.blankj.utilcode.util.Utils
import com.koubeigongzuo.library.BuildConfig
import com.koubeigongzuo.library.R
import com.scwang.smartrefresh.header.WaterDropHeader
import com.scwang.smartrefresh.layout.SmartRefreshLayout
import com.scwang.smartrefresh.layout.footer.BallPulseFooter
import com.tencent.bugly.crashreport.CrashReport
import com.umeng.analytics.MobclickAgent
import com.umeng.commonsdk.UMConfigure
import com.umeng.socialize.PlatformConfig
import io.sentry.Sentry
import io.sentry.android.AndroidSentryClientFactory
import me.yokeyword.fragmentation.Fragmentation
import java.io.BufferedReader
import java.io.FileReader
import java.io.IOException
import kotlin.properties.Delegates


/**
 * @author wyman
 * @date  2018/9/3
 * description : base application
 */
open class App : MultiDexApplication() {

    companion object {
        var appContext: Context by Delegates.notNull()
            private set
        lateinit var instance: Application

        init {
            //设置全局的Header构建器
            SmartRefreshLayout.setDefaultRefreshHeaderCreator { context, layout ->
                layout.setPrimaryColorsId(R.color.colorPrimary, android.R.color.white)//全局设置主题颜色
                layout.setEnableOverScrollBounce(true)//是否启用越界回弹
                layout.setEnableOverScrollDrag(true)//是否启用越界拖动（仿苹果效果）

                WaterDropHeader(context)//.setTimeFormat(new DynamicTimeFormat("更新于 %s"));//指定为经典Header，默认是 贝塞尔雷达Header
            }
            //设置全局的Footer构建器
            SmartRefreshLayout.setDefaultRefreshFooterCreator { context, layout ->
                layout.setEnableFooterTranslationContent(false)//是否上拉Footer的时候向上平移列表或者内容
                //指定为经典Footer，默认是 BallPulseFooter
                BallPulseFooter(context)
            }
        }
    }


    @SuppressLint("MissingSuperCall")
    override fun onCreate() {
        super.onCreate()
        instance = this
        appContext = applicationContext
        initConfig()
        initFragmentation()
        initARouter()
        initUmeng()
        initShare()
        initJPush()
//        initBugly()
//        initSentry()
    }

    private fun initSentry() {
        if (!BuildConfig.DEBUG) {
            Sentry.init(
                "http://27e210b060ad4f5689199a3789b94ea1@sentry.lanxinka.com/24",
                AndroidSentryClientFactory(this)
            )
        }
    }

    private fun initJPush() {
//        JPushInterface.setDebugMode(BuildConfig.DEBUG)
//        JPushInterface.init(appContext)


    }

    private fun initUmeng() {
        MobclickAgent.setDebugMode(BuildConfig.DEBUG)
        MobclickAgent.startWithConfigure(MobclickAgent.UMAnalyticsConfig(this, "5c4ea131b465f5fa440008b7", "UMENG"))
    }

    private fun initShare() {
        UMConfigure.init(
            this, "5c4ea131b465f5fa440008b7"
            , "umeng", UMConfigure.DEVICE_TYPE_PHONE, ""
        )
        PlatformConfig.setWeixin("wx292ef7d34afa0cc6", "05c1470fa5fa3cd3be58e8fd481d8e90")
        // PlatformConfig.setQQZone("1103450099", "x2V4mgHbVgz0gnvp");
        PlatformConfig.setQQZone("101550610", "bfe55b01b12a1d195b24207f1dec4799")
    }

    private fun initBugly() {

        val packageName = appContext.packageName
        // 获取当前进程名
        val processName = getProcessName(android.os.Process.myPid())
        // 设置是否为上报进程
        val strategy = CrashReport.UserStrategy(appContext)
        strategy.isUploadProcess = processName == null || processName == packageName
        CrashReport.initCrashReport(appContext, "28f000ed22", BuildConfig.DEBUG, strategy)
    }

    private fun getProcessName(pid: Int): String? {
        var reader: BufferedReader? = null
        try {
            reader = BufferedReader(FileReader("/proc/$pid/cmdline"))
            var processName = reader.readLine()
            if (!TextUtils.isEmpty(processName)) {
                processName = processName.trim { it <= ' ' }
            }
            return processName
        } catch (throwable: Throwable) {
            throwable.printStackTrace()
        } finally {
            try {
                if (reader != null) {
                    reader.close()
                }
            } catch (exception: IOException) {
                exception.printStackTrace()
            }

        }
        return null
    }

    private fun initFragmentation() {
        Fragmentation.builder().stackViewMode(Fragmentation.BUBBLE).debug(BuildConfig.DEBUG).install()
    }

    private fun initARouter() {
        if (BuildConfig.DEBUG) {
            ARouter.openLog()
            ARouter.openDebug()
        }
        ARouter.init(this)
    }

    private fun initConfig() {
        Utils.init(this)
        LogUtils.getConfig().setLogSwitch(BuildConfig.DEBUG)
    }


    override fun attachBaseContext(base: Context?) {
        super.attachBaseContext(base)
        MultiDex.install(this)
    }
}