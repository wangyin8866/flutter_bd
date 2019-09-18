package com.koubeigongzuo.library.net

import android.app.Activity
import android.app.Dialog
import android.content.Context
import android.view.Gravity
import com.koubeigongzuo.library.R

@Suppress("RECEIVER_NULLABILITY_MISMATCH_BASED_ON_JAVA_ANNOTATIONS")
/**
 * @author wyman
 * @date  2018/9/3
 * description :
 */
class CustomProgressDialog(context: Context) : Dialog(context, R.style.CustomProgressDialog) {
    //    private var mAnimationDrawable: AnimationDrawable? = null
    private var mContext: Context? = context


    init {
        setContentView(R.layout.layout_custom_loading)
        window.attributes.gravity = Gravity.CENTER
        setCanceledOnTouchOutside(false)
    }

    override fun onWindowFocusChanged(hasFocus: Boolean) {
        super.onWindowFocusChanged(hasFocus)
//        iv_progress.setImageDrawable(mContext?.resources?.getDrawable(R.drawable.anim_loading))
//        iv_progress.setImageResource(R.drawable.anim_loading)
//        iv_progress.setImageDrawable(mContext!!.resources.getDrawable(R.drawable.anim_loading,null))
//        mAnimationDrawable = iv_progress.drawable as AnimationDrawable?
//        mAnimationDrawable?.start()

    }

    override fun dismiss() {
        super.dismiss()
//        mAnimationDrawable?.stop()
//        mAnimationDrawable = null
    }

    override fun onDetachedFromWindow() {
        super.onDetachedFromWindow()
        if (mContext != null && mContext is Activity) {
            if (!(mContext as Activity).isFinishing) {
                dismiss()
            }
        }
    }
}