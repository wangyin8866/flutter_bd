package com.koubeigongzuo.library.utils

import android.content.Context
import android.graphics.drawable.Drawable
import androidx.core.content.ContextCompat
import android.util.DisplayMetrics
import android.util.TypedValue
import android.view.WindowManager

/**
 * Auth：yujunyao
 * Since: 2018/11/21 下午1:38
 * Email：yujunyao@aiwending.com
 */

/**
 * 请求阿里云图片等比缩放，并限定在矩形框内的
 */
fun Context.getPhotoUrl(url: String?): String? {
    url?.let {
        var size = dp2px(36, this)
        return "$url?x-oss-process=image/resize,m_lfit,h_$size,w_$size/circle,r_${size/2}"
    }
    return null
}

/**
 * 请求阿里云图片等比缩放，并限定在矩形框内的
 */
fun Context.getWrapperPhotoUrl(url: String?, width: Int, height: Int): String? {
    url?.let {
        var tempWidth = dp2px(width, this)
        var tempHeight = dp2px(height, this)
        return "$url?x-oss-process=image/resize,m_lfit,h_$tempHeight,w_$tempWidth"
    }
    return null
}

/**
 * 点R的id值转为drawable
 */
fun Context.getConvertDrawable(drawableId: Int): Drawable? {
    return ContextCompat.getDrawable(this, drawableId)
}

/**
 * 点R的id值转为颜色值
 */
fun Context.getConvertColor(colorId: Int): Int {
    return ContextCompat.getColor(this, colorId)
}

fun Context.screenSize(): IntArray {
    val wm = this.getSystemService(Context.WINDOW_SERVICE) as WindowManager
    val outMetrics = DisplayMetrics()
    wm.defaultDisplay.getMetrics(outMetrics)
    val screen = IntArray(2)
    screen[0] = outMetrics.widthPixels
    screen[1] = outMetrics.heightPixels
    return screen
}

/**
 * 根据手机的分辨率从 px(像素) 的单位 转成为 dp
 */
fun Context.px2dip(value: Int): Int {
    val scale = resources.displayMetrics.density
    return (value / scale + 0.5f).toInt()
}

fun Context.px2sp(value: Int): Int {
    val scale = resources.displayMetrics.density
    return (value / scale + 0.5f).toInt()
}

/**
 * dp转px
 */
fun Context.dp2px(value: Float): Int {
    return TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_DIP, value, resources.displayMetrics).toInt()
}

fun Context.dp2px_f(value: Float): Float {
    return TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_DIP, value, resources.displayMetrics)
}
