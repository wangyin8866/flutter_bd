package com.koubeigongzuo.library.service

import android.app.IntentService
import android.content.Context
import android.content.Intent
import android.text.TextUtils
import com.koubeigongzuo.library.BuildConfig
import com.koubeigongzuo.library.app.App
import com.tencent.bugly.crashreport.CrashReport
import com.tencent.bugly.crashreport.CrashReport.UserStrategy
import java.io.BufferedReader
import java.io.FileReader
import java.io.IOException


/**
 * @author wyman
 * @date  2018/10/22
 * description :
 */
open class InitializeService : IntentService("InitializeService") {


    companion object {
        private const val ACTION_INIT_WHEN_APP_CREATE = "service.action.INIT"
        fun start(context: Context) {
            val intent = Intent(context, InitializeService::class.java)
            intent.action = ACTION_INIT_WHEN_APP_CREATE
            context.startService(intent)
        }
    }

    override fun onHandleIntent(intent: Intent?) {
        if (intent != null) {
            val action = intent.action
            if (ACTION_INIT_WHEN_APP_CREATE == action) {
                performInit()
            }
        }
    }

    private fun performInit() {

        initBugly()
    }



    private fun initBugly() {

        val packageName = App.appContext.packageName
        // 获取当前进程名
        val processName = getProcessName(android.os.Process.myPid())
        // 设置是否为上报进程
        val strategy = UserStrategy(App.appContext)
        strategy.isUploadProcess = processName == null || processName == packageName
        CrashReport.initCrashReport(App.appContext, "28f000ed22", BuildConfig.DEBUG, strategy)
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
}