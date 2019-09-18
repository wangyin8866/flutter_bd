package com.koubeigongzuo.library.utils

import android.app.Activity
import android.net.Uri
import android.os.Parcelable
import com.alibaba.android.arouter.facade.Postcard
import com.alibaba.android.arouter.launcher.ARouter
import com.koubeigongzuo.library.config.BaseConstant
import com.koubeigongzuo.library.config.BaseNetValueConfig
import java.io.Serializable

/**
 * Auth：yujunyao
 * Since: 2018/12/13 上午9:52
 * Email：yujunyao@aiwending.com
 * 路由跳转扩展
 */

/**
 * 不带参数
 */
fun <T> goto(path: T) {
    when (path) {
        is Uri -> ARouter.getInstance().build(path).navigation()
        is String -> ARouter.getInstance().build(path).navigation()
    }
}

fun <T> Activity.goto(path: T, requestCode: Int) {
    when (path) {
        is Uri -> ARouter.getInstance().build(path).navigation(this, requestCode)
        is String -> ARouter.getInstance().build(path).navigation(this, requestCode)
    }
}

/**
 * 带参数
 */
fun <T> goto(path: T, map: HashMap<String, Any?>) {
    var postCard: Postcard? = when (path) {
        is Uri -> ARouter.getInstance().build(path)
        is String -> ARouter.getInstance().build(path)
        else -> null
    }

    postCard?.let {
        var iterator = map.iterator()
        while (iterator.hasNext()) {
            var item = iterator.next()
            when (item.value) {
                is String -> it.withString(item.key, item.value.toString())
                is Int -> it.withInt(item.key, item.value.toString().toInt())
                is Float -> it.withFloat(item.key, item.value.toString().toFloat())
                is Double -> it.withDouble(item.key, item.value.toString().toDouble())
                is Boolean -> it.withBoolean(item.key, item.value.toString().toBoolean())
                is Byte -> it.withByte(item.key, item.value.toString().toByte())
                is CharArray -> it.withCharArray(item.key, item.value.toString().toCharArray())
                is Serializable -> it.withSerializable(item.key, item.value as Serializable)
                is Parcelable -> it.withParcelable(item.key, item.value as Parcelable)
                is Any -> it.withObject(item.key, item.value)
            }
        }

        it.navigation()
    }


}

/**
 * 内链
 */

fun gotoWebView(tagActivity: String, router: String, url: String = BaseNetValueConfig.H5_URL) {
    ARouter.getInstance().build(tagActivity)
        .withString(BaseConstant.CONTENT_H5_URL_KEY, url + router).navigation()
}

/**
 * 外链
 */
fun gotoOutWebView(tagActivity: String, url: String) {
    ARouter.getInstance().build(tagActivity)
        .withString(BaseConstant.CONTENT_H5_URL_KEY, url ).navigation()
}