package com.koubeigongzuo.library.widget.dialog

import android.app.Dialog
import android.content.Context
import android.view.Gravity
import android.view.ViewGroup
import com.koubeigongzuo.library.R
import com.koubeigongzuo.library.utils.PreferenceData
import kotlinx.android.synthetic.main.dialog_logout.*

/**
 * @author wyman
 * @date  2018/9/7
 * description :
 */
class DialogLogout(context: Context) : Dialog(context, R.style.DialogStyle) {
    private var instance: DialogLogout = this

    init {
        setContentView(R.layout.dialog_logout)
        setCanceledOnTouchOutside(false)

        // 设置显示动画
//        window.setWindowAnimations(R.style.main_animstyle)
        val attr = window.attributes
        if (attr != null) {
            attr.height = ViewGroup.LayoutParams.WRAP_CONTENT
            attr.width = ViewGroup.LayoutParams.WRAP_CONTENT
            attr.gravity = Gravity.CENTER
        }
//        window.setGravity(Gravity.CENTER)
//        window.setLayout(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT)
    }


    fun setContent(content: String): DialogLogout {

        dialog_logout_content.text = content
        return instance
    }


    fun setOnClickListener(): DialogLogout {

        dialog_logout_but.setOnClickListener {
            PreferenceData.clearPreference()
            dismiss()

        }
        return instance
    }
}


