package com.koubeigongzuo.library.widget.views

import android.content.Context
import android.util.AttributeSet
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.LinearLayout
import android.widget.RelativeLayout
import android.widget.TextView
import com.koubeigongzuo.library.R
import com.koubeigongzuo.library.enums.TextDrawableDirection
import com.koubeigongzuo.library.utils.dp2px
import com.koubeigongzuo.library.utils.getConvertColor
import com.koubeigongzuo.library.utils.setDrawable
import kotlinx.android.synthetic.main.title_bar.view.*

/**
 * Auth：yujunyao
 * Since: 2019/2/25 下午1:49
 * Email：yujunyao@aiwending.com
 */

class TitleBar(context: Context, attrs: AttributeSet) : LinearLayout(context, attrs) {

    init {
        gravity = VERTICAL
        setBackgroundColor(context.getConvertColor(R.color.white))
        LayoutInflater.from(context).inflate(R.layout.title_bar, this)
        fitsSystemWindows = true
    }

    fun hideTitleBar() {
        visibility = View.GONE
        fitsSystemWindows = false
    }

    fun hideBack() {
        titleBack.visibility = View.GONE
    }

    fun setBkgColor(colorId: Int) {
        setBackgroundColor(context.getConvertColor(colorId))
    }

    fun setBkgResource(resID: Int) {
        setBackgroundResource(resID)
    }

    fun resetChildView() {
        titleName.setTextColor(context.getConvertColor(R.color.white))
        titleRight1.setTextColor(context.getConvertColor(R.color.white))
        titleBack.setDrawable(R.drawable.back_w, TextDrawableDirection.LEFT)
    }

    fun showBack(visible:Boolean){
        titleBack.visibility = if(visible) View.VISIBLE else View.GONE
    }

    fun getBack(): TextView {
        return titleBack
    }

    fun showRightTv(right1: String?) {
        right1?.let {
            titleRight1.text = it
            titleRight1.visibility = View.VISIBLE
        }
    }

    fun showRightTv(resID: Int) {
        titleRight1.setDrawable(resID, TextDrawableDirection.LEFT)
        titleRight1.visibility = View.VISIBLE
    }

    fun getRightTv(): TextView {
        titleRight1.visibility = View.VISIBLE
        return titleRight1
    }

    fun hideRigthTv() {
        titleRight1.visibility = View.GONE
    }

    fun showRightIv(resID: Int) {
        imageRight2.setImageResource(resID)
        imageRight2.visibility = View.VISIBLE
    }

    fun getRightIv(): ImageView {
        imageRight2.visibility = View.VISIBLE
        return imageRight2
    }

    fun showTitle(title: String?) {
        title?.let {
            titleName.text = it
            titleName.visibility = View.VISIBLE
        }
    }

    fun hideTitle() {
        titleName.visibility = View.GONE
    }

    /**
     * 左右距离unit dp,自定义title中间部分，替换默认title布局
     */
    fun customCenterLayout(view: View?, distanceLeft: Int, distanceRight: Int) {
        view?.let {
            titleRoot.removeView(titleName)
            var params = RelativeLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT)
            params.leftMargin = context.dp2px(distanceLeft.toFloat())
            params.rightMargin = context.dp2px(distanceRight.toFloat())
            it.layoutParams = params
            titleRoot.addView(it)
        }
    }
}