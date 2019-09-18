package com.koubeigongzuo.library.widget.views;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.drawable.Drawable;
import android.util.AttributeSet;
import androidx.appcompat.widget.AppCompatTextView;

/**
 * Auth：yujunyao
 * Since: 2019/4/24 下午5:25
 * Email：yujunyao@aiwending.com
 */

public class CustomTextView extends AppCompatTextView {
    public CustomTextView(Context context) {
        super(context);
    }

    public CustomTextView(Context context, AttributeSet attrs) {
        super(context, attrs);
    }

    public CustomTextView(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
    }

    @Override
    protected void onDraw(Canvas canvas) {
        // getCompoundDrawables() : Returns drawables for the left, top, right, and bottom borders.
        Drawable[] drawable = getCompoundDrawables();
        //得到drawableLeft设置的drawable对象
        Drawable leftDrawable = drawable[0];
        if (leftDrawable != null) {
            //得到leftdrawable 的宽度
            int leftDrawableWidth = leftDrawable.getIntrinsicWidth();
            //得到drawable与text之间的间距
            int drawablePadding = getCompoundDrawablePadding();
            //得到文本的宽度
            int textWidth = (int) getPaint().measureText(getText().toString().trim());

            int bodyWidth = leftDrawableWidth + drawablePadding + textWidth;
            canvas.save();
            //将内容在X轴方向平移
            canvas.translate((getWidth() - bodyWidth) / 2, 0);
        }
        super.onDraw(canvas);

    }
}
