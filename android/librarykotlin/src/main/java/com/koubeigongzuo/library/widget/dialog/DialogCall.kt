package com.koubeigongzuo.library.widget.dialog

import android.app.Dialog
import android.content.Context
import android.view.Gravity
import android.view.View
import android.view.ViewGroup
import com.koubeigongzuo.library.R
import kotlinx.android.synthetic.main.dialog_call_phone.*


/**
 * @author wyman
 * @date  2018/9/7
 * description :
 */
class DialogCall(context: Context) : Dialog(context, R.style.DialogStyle) {
    private var instance: DialogCall = this

    init {
        show()
        setContentView(R.layout.dialog_call_phone)
        setCanceledOnTouchOutside(false)
        val attr = window.attributes
        if (attr != null) {
            attr.height = ViewGroup.LayoutParams.WRAP_CONTENT
            attr.width = ViewGroup.LayoutParams.WRAP_CONTENT
            attr.gravity = Gravity.CENTER
        }

    }


    fun setOnClickListener(onClickListener: View.OnClickListener) {
        tv_cancel.setOnClickListener(onClickListener)
        tv_sure.setOnClickListener(onClickListener)
    }

    fun setNum(num: String): DialogCall {

        dialog_call_num.text = num
        return instance
    }

    fun setTitle(title: String?): DialogCall {
        dialog_call_title.text = title
        return instance

    }
}


