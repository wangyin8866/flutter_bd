package com.koubeigongzuo.library.net

import android.content.Context
import android.os.Handler
import android.os.Message

/**
 * @author wyman
 * @date  2018/9/3
 * description :
 */
class ProgressDialogHandler(val context: Context, private val cancelable: Boolean, private val mProgressCancelListener: ProgressCancelListener) : Handler() {

    companion object {

        const val SHOW_PROGRESS_DIALOG = 1
        const val DISMISS_PROGRESS_DIALOG = 2
    }

    private var pd: CustomProgressDialog? = null


    override fun handleMessage(msg: Message?) {
        super.handleMessage(msg)
        when (msg?.what) {
            SHOW_PROGRESS_DIALOG -> {
                initProgressDialog()
            }
            DISMISS_PROGRESS_DIALOG -> {
                dismissProgressDialog()
            }
        }

    }

    private fun dismissProgressDialog() {
        pd?.dismiss()
        pd = null
        removeCallbacksAndMessages(null)
    }

    private fun initProgressDialog() {
        if (pd == null) {
            pd = CustomProgressDialog(context)
            pd!!.setCancelable(cancelable)
            if (cancelable) {
                pd!!.setOnCancelListener { mProgressCancelListener.onCancelProgress() }
            }
            if (!pd!!.isShowing) {
                pd!!.show()
            }
        }
    }
}