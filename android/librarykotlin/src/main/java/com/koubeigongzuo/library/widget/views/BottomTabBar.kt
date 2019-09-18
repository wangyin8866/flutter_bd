package com.koubeigongzuo.library.widget.views

import android.content.Context
import android.graphics.Color
import android.util.AttributeSet
import android.view.LayoutInflater
import android.view.View
import android.widget.ImageView
import android.widget.LinearLayout
import android.widget.RelativeLayout
import android.widget.TextView
import com.koubeigongzuo.library.R
import com.koubeigongzuo.library.utils.dp2px
import com.koubeigongzuo.library.utils.screenSize
import com.koubeigongzuo.library.utils.tabbarAnimation

/**
 * Auth：yujunyao
 * Since: 2019/1/16 上午9:58
 * Email：yujunyao@aiwending.com
 */

class BottomTabBar : LinearLayout, View.OnClickListener {

    interface SelectedCallBack {
        fun selectOther(tag: Int): Boolean
        fun selectRepeat(tag: Int)
    }

    private var count = 4
    private var selectTag: Int = 0
    private val diff = 500L//300毫秒
    private var lastClickTime: Long = 0L
    private val duration = 100L
    private var imagesOff = arrayOf(R.drawable.tab_map_unselect, R.drawable.tab_work_unselect, R.drawable.tab_news_unselect, R.drawable.tab_me_unselect)
    private var imagesOn = arrayOf(R.drawable.tab_map_select, R.drawable.tab_work_select, R.drawable.tab_news_select, R.drawable.tab_me_select)
    private var titles = arrayOf("找工作", "岗位", "消息", "我的")
    private val items: MutableList<RelativeLayout> = ArrayList()
    private val images: MutableList<ImageView> = ArrayList()
    private val labels: MutableList<TextView> = ArrayList()
    private var callBack: SelectedCallBack? = null

    constructor(ctx: Context) : this(ctx, null)

    constructor(ctx: Context, attrs: AttributeSet?) : this(ctx, attrs, 0)

    constructor(ctx: Context, attrs: AttributeSet?, defStyleAttr: Int) : super(ctx, attrs, defStyleAttr) {
        initView(ctx)
    }

    private fun initView(ctx: Context) {
        orientation = LinearLayout.HORIZONTAL

        count = titles.size

        var params = RelativeLayout.LayoutParams(RelativeLayout.LayoutParams.MATCH_PARENT, ctx.dp2px(44.toFloat()))
        params.width = ctx.screenSize()[0] / count

        for (i in 0 until count) {
            var item = LayoutInflater.from(ctx).inflate(R.layout.item_tabbar, this, false)
            item?.layoutParams = params
            items.add(item as RelativeLayout)

            var image = item.findViewById<ImageView>(R.id.image)
            var title = item.findViewById<TextView>(R.id.title)
            if (i == 0) {
                image.setImageResource(imagesOn[i])
                title.setTextColor(Color.parseColor("#EA4C56"))

            } else {
                image.setImageResource(imagesOff[i])
                title.setTextColor(Color.parseColor("#5D5D5D"))
            }
            images.add(image)
            title.text = titles[i]
//            title.setTextColor(ctx.resources.getColor())
            labels.add(title)

            item.tag = i
            item.setOnClickListener(this)
            addView(item)
        }

    }

    fun setData(callBack: SelectedCallBack?) {
        this.callBack = callBack
    }

    fun tempClick(index: Int) {
        getChildAt(index).performClick()
    }

    fun getView(index: Int): View {
        return getChildAt(index)
    }

    override fun onClick(v: View?) {
        var tag = v?.tag as Int
        if (isFastDoubleClick(tag, diff)) {
            return
        }
        if (tag == selectTag) {
            // 做一些回到顶部，下拉刷新的效果
            callBack?.selectRepeat(tag)
        } else {
            if (callBack?.selectOther(tag)!!) {
                // 可以替换gif,以及播放gif方式（一次还是循环）
                images[selectTag].setImageResource(imagesOff[selectTag])
                images[tag].setImageResource(imagesOn[tag])
                labels[selectTag].setTextColor(Color.parseColor("#5D5D5D"))
                labels[tag].setTextColor(Color.parseColor("#D61A1A"))

                selectTag = tag
                images[tag].tabbarAnimation(duration)
            }
        }
    }

    private fun isFastDoubleClick(tag: Int, diff: Long): Boolean {
        val currTime = System.currentTimeMillis()
        val diffTime = currTime - lastClickTime
        var isFast = tag == selectTag && lastClickTime > 0 && diffTime < diff
        if (isFast) return true
        lastClickTime = currTime
        return false
    }

}