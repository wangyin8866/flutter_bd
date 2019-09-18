package com.koubeigongzuo.library.utils

import android.content.Context
import android.graphics.Bitmap
import android.widget.ImageView
import com.bumptech.glide.Glide
import com.bumptech.glide.Priority
import com.bumptech.glide.request.RequestOptions

/**
 * Auth：yujunyao
 * Since: 2018/12/12 下午4:06
 * Email：yujunyao@aiwending.com
 */

object GlideHelper {

    fun <T> showImage(context: Context?, url: T, defaultRes: Int, imageView: ImageView) {
        var requestOption = RequestOptions()
            .placeholder(defaultRes)
            .error(defaultRes)
            .priority(Priority.HIGH)
        context?.let {
            Glide.with(it).load(url).apply(requestOption).into(imageView)
        }
    }

    fun <T> showImage(context: Context?, url: T, imageView: ImageView) {
        var requestOption = RequestOptions()
            .priority(Priority.HIGH)
        context?.let {
            Glide.with(it).load(url).apply(requestOption).into(imageView)
        }
    }

    fun <T> showImageHome(context: Context?, url: T, defaultRes: Int, imageView: ImageView, width: Int, height: Int) {
        var requestOption = RequestOptions()
            .priority(Priority.HIGH)
            .placeholder(defaultRes)
            .error(defaultRes)
            .override(width, height)
        context?.let {
            Glide.with(it).load(url).apply(requestOption).into(imageView)
        }
    }

    /**
     * 获取网络加载图片的bitmap
     */
    fun <T> getBitmap(context: Context?, url: T, defaultRes: Int, width: Int, height: Int): Bitmap? {
        var requestOption = RequestOptions()
            .placeholder(defaultRes)
            .error(defaultRes)
            .priority(Priority.HIGH)

        return context?.let {
            Glide.with(it).asBitmap()
                .load(url)
                .apply(requestOption)
                .submit(width, height)
                .get()
        }

    }

    fun <T> showGif(context: Context?, url: T, defaultRes: Int, imageView: ImageView) {
        var requestOption = RequestOptions()
            .placeholder(defaultRes)
            .error(defaultRes)
            .priority(Priority.HIGH)
        context?.let {
            Glide.with(it).asGif().apply(requestOption).load(url).into(imageView)
        }
    }
}