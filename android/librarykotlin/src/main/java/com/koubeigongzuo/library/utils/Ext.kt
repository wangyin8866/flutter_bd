package com.koubeigongzuo.library.utils

import android.animation.AnimatorSet
import android.animation.ObjectAnimator
import android.annotation.SuppressLint
import android.app.Activity
import android.content.ClipData
import android.content.ClipboardManager
import android.content.Context
import android.content.pm.PackageManager
import android.graphics.Color
import android.graphics.drawable.Drawable
import android.text.*
import android.text.method.LinkMovementMethod
import android.text.style.ClickableSpan
import android.text.style.ForegroundColorSpan
import android.text.style.ImageSpan
import android.text.style.UnderlineSpan
import android.util.TypedValue
import android.view.View
import android.view.ViewGroup
import android.view.animation.AccelerateDecelerateInterpolator
import android.webkit.WebChromeClient
import android.webkit.WebViewClient
import android.widget.EditText
import android.widget.TextView
import androidx.annotation.LayoutRes
import androidx.annotation.StyleRes
import androidx.core.content.ContextCompat
import com.blankj.utilcode.util.ScreenUtils
import com.blankj.utilcode.util.ToastUtils
import com.just.agentweb.AgentWeb
import com.just.agentweb.DefaultWebClient
import com.koubeigongzuo.library.config.BaseConstant
import com.koubeigongzuo.library.enums.TextDrawableDirection
import com.koubeigongzuo.library.impl.TextClickInvoke
import com.zyyoona7.lib.EasyPopup
import io.reactivex.Observable
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.disposables.CompositeDisposable
import io.reactivex.schedulers.Schedulers
import java.util.concurrent.TimeUnit


/**
 * @author wyman
 * @date  2018/9/7
 * description :
 */
/**
 * getAgentWeb
 */
fun String.getAgentWeb(
    activity: Activity, webContent: ViewGroup,
    layoutParams: ViewGroup.LayoutParams,
    webChromeClient: WebChromeClient?,
    webViewClient: WebViewClient
) = AgentWeb.with(activity)//传入Activity or Fragment
    .setAgentWebParent(webContent, layoutParams)//传入AgentWeb 的父控件
    .useDefaultIndicator()// 使用默认进度条
    .setWebChromeClient(webChromeClient)
    .setWebViewClient(webViewClient)
//        .setMainFrameErrorView(R.layout.activity_agentweb_error_page, R.id.tv_error)
    .setOpenOtherPageWays(DefaultWebClient.OpenOtherPageWays.ASK)//打开其他应用时，弹窗咨询用户是否前往其他应用
    .createAgentWeb()//
    .ready()
    .go(this)!!


fun countDown(tv: TextView, rest: String) {
    var currentTime = BaseConstant.SMS_TIME - 1
    val mCompositeDisposable = CompositeDisposable()
    tv.isEnabled = false
    tv.text = (BaseConstant.SMS_TIME - 1).toString() + "s"

    mCompositeDisposable.add(Observable.interval(1, TimeUnit.SECONDS, AndroidSchedulers.mainThread())
        .subscribeOn(Schedulers.io())
        .observeOn(AndroidSchedulers.mainThread())
        .subscribe {
            currentTime -= 1
            if (currentTime <= 0) {
                tv.text = rest
                tv.isEnabled = true
                mCompositeDisposable.clear()

            } else {
                tv.text = currentTime.toString() + "s"
            }
        })

}

fun countDownAdv(tv: TextView, rest: String) {
    var currentTime = BaseConstant.SMS_TIME - 1
    val mCompositeDisposable = CompositeDisposable()
    tv.text = (BaseConstant.SMS_TIME - 1).toString() + "s"

    mCompositeDisposable.add(Observable.interval(1, TimeUnit.SECONDS, AndroidSchedulers.mainThread())
        .subscribeOn(Schedulers.io())
        .observeOn(AndroidSchedulers.mainThread())
        .subscribe {
            currentTime -= 1
            if (currentTime <= 0) {
                tv.text = rest
                mCompositeDisposable.clear()

            } else {
                tv.text = currentTime.toString() + "s"
            }
        })

}

fun countDownWithdraw(tv: TextView, rest: String) {
    var currentTime = BaseConstant.SMS_TIME - 1
    val mCompositeDisposable = CompositeDisposable()
    tv.isEnabled = false
    tv.text = (BaseConstant.SMS_TIME - 1).toString() + "s后可重新发送"

    mCompositeDisposable.add(Observable.interval(1, TimeUnit.SECONDS, AndroidSchedulers.mainThread())
        .subscribeOn(Schedulers.io())
        .observeOn(AndroidSchedulers.mainThread())
        .subscribe {
            currentTime -= 1
            if (currentTime <= 0) {
                tv.text = rest
                tv.isEnabled = true
                mCompositeDisposable.clear()

            } else {
                tv.text = currentTime.toString() + "s后可重新发送"
            }
        })

}

fun EditText.trimAll() = this.text.toString().trim().replace(" ", "")
fun String.trimAll() = this.trim().replace(" ", "")
//尺寸转化
fun dp2px(dp: Int, context: Context): Int {
    return TypedValue.applyDimension(
        TypedValue.COMPLEX_UNIT_DIP,
        dp.toFloat(),
        context.resources.displayMetrics
    ).toInt()
}

fun sp2px(sp: Int, context: Context): Int {
    return TypedValue.applyDimension(
        TypedValue.COMPLEX_UNIT_SP,
        sp.toFloat(),
        context.resources.displayMetrics
    ).toInt()
}

//辅助
fun clipText(context: Context, content: String) {
    val cm = context.getSystemService(Context.CLIPBOARD_SERVICE) as ClipboardManager
    val clip = ClipData.newPlainText("copy", content)
    cm.primaryClip = clip
    ToastUtils.showShort("复制成功")
}

fun clipShareText(context: Context, content: String) {
    val cm = context.getSystemService(Context.CLIPBOARD_SERVICE) as ClipboardManager
    val clip = ClipData.newPlainText("copy", content)
    cm.primaryClip = clip
    ToastUtils.showShort("复制成功,请去分享")
}

fun textEllipsis(textView: TextView, oldContent: String?, minLength: Int) {
    if (oldContent == null) {
        return
    } else {
        if (oldContent.length > minLength) {
            val newContent = oldContent.replace(oldContent.substring(minLength, oldContent.length), "...")
            textView.text = newContent
        } else {
            textView.text = oldContent
        }
    }
}

//设置下划线
fun TextView.setLine(): TextView {
    //设置下划线
    val str = this.text.toString()
    val spannableString = SpannableString(str)
    spannableString.setSpan(UnderlineSpan(), 0, str.length, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE)
    this.text = spannableString

    //下面这种方法在某些机型会显示两条下划线 eg:HUAWEI BKL-AL20机型
//    this.paint.flags = Paint.UNDERLINE_TEXT_FLAG //下划线
//    this.paint.isAntiAlias = true//抗锯齿

    return this
}

fun createPopupWindow(context: Context, @LayoutRes layoutId: Int, @StyleRes animationStyle: Int): EasyPopup {
    val ep = EasyPopup(context)
        .setContentView<EasyPopup>(layoutId)
        .setAnimationStyle<EasyPopup>(animationStyle)
        .setFocusAndOutsideEnable<EasyPopup>(true)
        .setFocusable<EasyPopup>(false)//点击外部响应点击事件
        .setWidth<EasyPopup>(ScreenUtils.getScreenWidth())
        .createPopup<EasyPopup>()
    return ep
}

fun createPopupWindow(
    context: Context, @LayoutRes layoutId: Int, @StyleRes animationStyle: Int,
    width: Int,
    height: Int
): EasyPopup {
    val ep = EasyPopup(context)
        .setContentView<EasyPopup>(layoutId)
        .setAnimationStyle<EasyPopup>(animationStyle)
        .setFocusAndOutsideEnable<EasyPopup>(true)
        .setFocusable<EasyPopup>(false)//点击外部响应点击事件
        .setWidth<EasyPopup>(width)
        .setHeight<EasyPopup>(height)
        .createPopup<EasyPopup>()
    return ep
}


fun TextView.setDrawable(resId: Int, enum: TextDrawableDirection) {
    var drawable = this.context.getConvertDrawable(resId)
    setDrawable(drawable, enum)
}

fun TextView.setDrawable(drawable: Drawable?, enum: TextDrawableDirection) {
    drawable?.let {
        it.setBounds(0, 0, it.minimumWidth, it.minimumHeight)
        when (enum) {
            TextDrawableDirection.LEFT -> setCompoundDrawables(it, null, null, null)
            TextDrawableDirection.TOP -> setCompoundDrawables(null, it, null, null)
            TextDrawableDirection.RIGHT -> setCompoundDrawables(null, null, it, null)
            TextDrawableDirection.BOTTOM -> setCompoundDrawables(null, null, null, it)
            TextDrawableDirection.EMPTY -> setCompoundDrawables(null, null, null, null)
        }
    }
}

/**
 * 首页底部tabbar点击切换动画缩放
 */
fun View.tabbarAnimation(duration: Long) {
    var animatorSet = AnimatorSet()
    val animatorScaleX = ObjectAnimator.ofFloat(this, "scaleX", 1f, 1.2f)
    val animatorScaleY = ObjectAnimator.ofFloat(this, "scaleY", 1f, 1.2f)
    val animatorScaleXBack = ObjectAnimator.ofFloat(this, "scaleX", 1.2f, 1f)
    val animatorScaleYBack = ObjectAnimator.ofFloat(this, "scaleY", 1.2f, 1f)

    animatorSet.duration = duration
    animatorSet.interpolator = AccelerateDecelerateInterpolator()
    animatorSet.playTogether(animatorScaleX, animatorScaleY, animatorScaleXBack, animatorScaleYBack)
    animatorSet.start()
}

/**
 * 去掉在Android P上的提醒弹窗 （Detected problems with API compatibility(visit g.co/dev/appcompat for more info)
 */
@SuppressLint("PrivateApi")
fun closeAndroidPDialog() {
    try {
        val aClass = Class.forName("android.content.pm.PackageParser\$Package")
        val declaredConstructor = aClass.getDeclaredConstructor(String::class.java)
        declaredConstructor.isAccessible = true
    } catch (e: Exception) {
        e.printStackTrace()
    }

    try {
        val cls = Class.forName("android.app.ActivityThread")
        val declaredMethod = cls.getDeclaredMethod("currentActivityThread")
        declaredMethod.isAccessible = true
        val activityThread = declaredMethod.invoke(null)
        val mHiddenApiWarningShown = cls.getDeclaredField("mHiddenApiWarningShown")
        mHiddenApiWarningShown.isAccessible = true
        mHiddenApiWarningShown.setBoolean(activityThread, true)
    } catch (e: Exception) {
        e.printStackTrace()
    }

}

/**
 * 文字设置局部变色、下划线、点击事件
 */
fun TextView.changeColorOrClick(
    start: Int,
    end: Int,
    content: String?,
    setUnderLine: Boolean,
    changeColor: Int,
    clickInvoke: TextClickInvoke?
) {
    content?.let {
        var spannableString = SpannableString(it)
        spannableString.setSpan(object : ClickableSpan() {

            override fun onClick(widget: View?) {
                clickInvoke?.let {
                    it.invokeBack(widget)
                }
            }

            override fun updateDrawState(ds: TextPaint?) {
                super.updateDrawState(ds)
                ds?.let {
                    it.isUnderlineText = setUnderLine
                }
            }

        }, start, end, Spannable.SPAN_EXCLUSIVE_INCLUSIVE)

        spannableString.setSpan(
            ForegroundColorSpan(this.context.getConvertColor(changeColor)),
            start,
            end,
            Spanned.SPAN_EXCLUSIVE_EXCLUSIVE
        )
        text = spannableString
        movementMethod = LinkMovementMethod.getInstance()
        highlightColor = Color.TRANSPARENT
    }
}

/**
 * 文字设置局部变色、下划线、点击事件
 */
fun TextView.setImage(
    context: Context, ides: Int,
    start: Int,
    end: Int,
    content: String?,
    clickInvoke: TextClickInvoke?
) {
    content?.let {
        val spannableString = SpannableString(it)
        spannableString.setSpan(object : ClickableSpan() {

            override fun onClick(widget: View?) {
                clickInvoke?.invokeBack(widget)
            }

        }, start, end, Spannable.SPAN_EXCLUSIVE_INCLUSIVE)

        val drawable = ContextCompat.getDrawable(context, ides)
        drawable?.setBounds(0, 0, dp2px(15,context),  dp2px(15,context))
        spannableString.setSpan(
            ImageSpan(drawable!!),
            start,
            end,
            Spanned.SPAN_EXCLUSIVE_EXCLUSIVE
        )
        text = spannableString
        movementMethod = LinkMovementMethod.getInstance()
    }
}

/**
 * 获取application中指定的meta-data
 * @return 如果没有获取成功(没有对应值，或者异常)，则返回值为空
 */
fun getAppMetaData(ctx: Context?, key: String): String {
    var resultData = ""
    if (ctx == null || TextUtils.isEmpty(key)) {
        return resultData
    }
    try {
        val packageManager = ctx.packageManager
        if (packageManager != null) {
            //注意此处为ApplicationInfo，因为友盟设置的meta-data是在application标签中
            val applicationInfo = packageManager.getApplicationInfo(ctx.packageName, PackageManager.GET_META_DATA)
            if (applicationInfo != null) {
                if (applicationInfo.metaData != null) {
                    //key要与manifest中的配置文件标识一致
                    resultData = applicationInfo.metaData.getString(key)
                }
            }
        }
    } catch (e: PackageManager.NameNotFoundException) {
        e.printStackTrace()
    }

    return resultData
}

