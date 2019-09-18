package com.koubeigongzuo.library.base

import android.content.Context
import android.graphics.Color
import android.os.Bundle
import android.view.KeyEvent
import android.view.View
import androidx.annotation.LayoutRes
import com.alibaba.android.arouter.launcher.ARouter
import com.blankj.utilcode.util.ToastUtils
import com.jakewharton.rxbinding2.view.RxView
import com.koubeigongzuo.library.R
import com.koubeigongzuo.library.entity.HttpResult
import com.koubeigongzuo.library.entity.RecommendLocation
import com.koubeigongzuo.library.net.CustomProgressDialog
import com.koubeigongzuo.library.utils.CleanLeakUtils
import com.koubeigongzuo.library.widget.views.TitleBar
import com.trello.rxlifecycle2.LifecycleTransformer
import com.trello.rxlifecycle2.components.support.RxAppCompatActivity
import com.umeng.analytics.MobclickAgent
import kotlinx.android.synthetic.main.activity_base.*
import kotlinx.android.synthetic.main.title_bar.view.*
import me.yokeyword.fragmentation.*
import me.yokeyword.fragmentation.anim.FragmentAnimator
import java.util.concurrent.TimeUnit


/**
 * @author wyman
 * @date  2018/9/3
 * description :
 */
abstract class BaseActivity<T : BasePresenter<V>, V : BaseView> : RxAppCompatActivity(), ISupportActivity, BaseView {

    var mPresenter: T? = null
    private var mDelegate: SupportActivityDelegate = SupportActivityDelegate(this)
    private var progressDialog: CustomProgressDialog? = null
    lateinit var mContext: Context

    var mTitleBar: TitleBar? = null
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        mContext = this
        mDelegate.onCreate(savedInstanceState)

        super.setContentView(R.layout.activity_base)
        ActivityCollector.addActivity(this)
        ARouter.getInstance().inject(this)

        getLayoutId()?.let { setContentView(it) }

        mPresenter = createPresenter()
        mPresenter?.attachView(this as V)
        mTitleBar = titleBar
        if (isNeedTitleBar()) {
            mTitleBar?.visibility = View.VISIBLE
            showTitle(title.toString())
            addClickListener(mTitleBar?.titleBack)
        } else {
            mTitleBar?.visibility = View.GONE
        }

        initData(savedInstanceState)
    }

    fun showTitle(title: String) {
        mTitleBar?.showTitle(title)
    }

    fun setTransparentColor() {
        if (baseContainer != null) {
            baseContainer.setBackgroundColor(Color.TRANSPARENT)
        }
    }

    override fun setContentView(@LayoutRes layoutResID: Int) {
        layoutInflater.inflate(layoutResID, baseContainer)
    }

    open fun addClickListener(view: View?) {
        view?.let {
            mPresenter?.addSubscribe(RxView.clicks(it).throttleFirst(1, TimeUnit.SECONDS).subscribe {
                onClickView(view)
            })
        }
    }

    open fun onClickView(v: View?) {
        when (v?.id) {
            R.id.titleBack -> {
                finish()
            }
        }
    }


    override fun onDestroy() {
        CleanLeakUtils.fixInputMethodManagerLeak(this)
        ActivityCollector.removeActivity(this)
        super.onDestroy()
        mDelegate.onDestroy()
        mPresenter?.detachView()
        if (mPresenter != null) {
            mPresenter = null
        }
    }

    private fun dismissProgressDialog() {
        progressDialog?.dismiss()
    }

    private fun showProgressDialog() {
        if (progressDialog == null) {
            progressDialog = CustomProgressDialog(this)
        }
        if (!progressDialog?.isShowing!!) {
            progressDialog?.show()
        }
    }


    abstract fun initData(savedInstanceState: Bundle?)

    abstract fun createPresenter(): T?

    abstract fun getLayoutId(): Int?

    //是否需要通用的titleBar
    open fun isNeedTitleBar(): Boolean {
        return true
    }

    /**
     * 按左上角返回键，如需屏蔽，重写此函数即可
     */
    open fun functionKeyBack() {
        this.finish()
    }

    /**
     * 按物理返回键，如需屏蔽，重写此函数即可
     */
    open fun physicalKeyBack() {
        this.finish()
    }

    override fun onKeyDown(keyCode: Int, event: KeyEvent?): Boolean {
        if (keyCode == KeyEvent.KEYCODE_BACK) {
            physicalKeyBack()
            return true
        }
        return super.onKeyDown(keyCode, event)
    }

    override fun showNotNet() {
        ToastUtils.showShort(getString(R.string.tip_not_net))
    }

    override fun <T> bindToLife(): LifecycleTransformer<T> {
        return this.bindToLifecycle()
    }

    override fun setFragmentAnimator(fragmentAnimator: FragmentAnimator) {
        mDelegate.fragmentAnimator
    }

    override fun onResume() {
        super.onResume()
        MobclickAgent.onResume(this)
    }

    override fun finish() {
        super.finish()
    }

    override fun onPause() {
        super.onPause()
        MobclickAgent.onPause(this)
    }

    /**
     * 获取设置的全局动画 copy
     *
     * @return FragmentAnimator
     */
    override fun getFragmentAnimator(): FragmentAnimator {
        return mDelegate.fragmentAnimator
    }

    override fun onBackPressedSupport() {
        mDelegate.onBackPressedSupport()
    }

    /**
     * Perform some extra transactions.
     * 额外的事务：自定义Tag，添加SharedElement动画，操作非回退栈Fragment
     */
    override fun extraTransaction(): ExtraTransaction {
        return mDelegate.extraTransaction()
    }

    /**
     * Set all fragments animation.
     * 构建Fragment转场动画
     * <p/>
     * 如果是在Activity内实现,则构建的是Activity内所有Fragment的转场动画,
     * 如果是在Fragment内实现,则构建的是该Fragment的转场动画,此时优先级 > Activity的onCreateFragmentAnimator()
     *
     * @return FragmentAnimator对象
     */
    override fun onCreateFragmentAnimator(): FragmentAnimator {
        return mDelegate.onCreateFragmentAnimator()
    }

    override fun getSupportDelegate(): SupportActivityDelegate? {
        return mDelegate
    }

    override fun post(runnable: Runnable) {
        mDelegate.post(runnable)
    }

    override fun showLoading() {
        showProgressDialog()
    }

    override fun hideLoading() {
        dismissProgressDialog()
    }

    //网络成功响应
    override fun showSuccess(response: HttpResult<*>?) {

    }

    //网络请求异常
    override fun showFailed(message: String) {

    }

    //网络成功响应，但code码不对
    override fun showErrorCode(response: HttpResult<*>?) {
        if (response?.code == 100021 || response?.code == 100010) {//不给用户提示
            return
        }
        ToastUtils.showShort(response?.msg)
    }

    override fun showBaiduRecommend(response: RecommendLocation) {

    }

    /**
     * 得到位于栈顶Fragment
     */
    fun getTopFragment(): ISupportFragment {
        return SupportHelper.getTopFragment(supportFragmentManager)
    }

    /**
     * 获取栈内的fragment对象
     */
    fun <T : ISupportFragment> findFragment(fragmentClass: Class<T>): T? {
        return SupportHelper.findFragment(supportFragmentManager, fragmentClass)
    }

    /**
     * 加载多个同级根Fragment,类似Wechat, QQ主页的场景
     */
    fun loadMultipleRootFragment(containerId: Int, showPosition: Int, vararg toFragments: ISupportFragment?) {
        mDelegate.loadMultipleRootFragment(containerId, showPosition, *toFragments)
    }

    fun loadRootFragment(containerId: Int, toFragment: ISupportFragment) {
        mDelegate.loadRootFragment(containerId, toFragment)
    }

    /**
     * show一个Fragment,hide其他同栈所有Fragment
     * 使用该方法时，要确保同级栈内无多余的Fragment,(只有通过loadMultipleRootFragment()载入的Fragment)
     *
     *
     * 建议使用更明确的[.showHideFragment]
     *
     * @param showFragment 需要show的Fragment
     */
    fun showHideFragment(showFragment: ISupportFragment) {
        mDelegate.showHideFragment(showFragment)
    }

    /**
     * show一个Fragment,hide一个Fragment ; 主要用于类似微信主页那种 切换tab的情况
     */
    fun showHideFragment(showFragment: ISupportFragment?, hideFragment: ISupportFragment?) {
        mDelegate.showHideFragment(showFragment, hideFragment)
    }

    fun closeActivity() {
        finish()
    }
//
//    /**
//     * 设置加载数据结果
//     *
//     * @param baseQuickAdapter
//     * @param refreshLayout
//     * @param list
//     * @param loadType
//     */
//    protected fun <T> setLoadDataResult(baseQuickAdapter: BaseQuickAdapter<T, *>, refreshLayout: SmartRefreshLayout, list: List<T>?, @LoadType.checker loadType: Int) {
//        when (loadType) {
//            LoadType.TYPE_REFRESH_SUCCESS -> {
//                baseQuickAdapter.setNewData(list)
//                refreshLayout.finishRefresh()
//            }
//            LoadType.TYPE_REFRESH_ERROR ->  refreshLayout.finishRefresh()
//            LoadType.TYPE_LOAD_MORE_SUCCESS -> {
//                if (list != null) baseQuickAdapter.addData(list)
//            }
//            LoadType.TYPE_LOAD_MORE_ERROR -> baseQuickAdapter.loadMoreFail()
//        }
//        if (list == null || list.isEmpty() || list.size < BaseConstant.PAGE_SIZE) {
//            baseQuickAdapter.loadMoreEnd(false)
//        } else {
//            baseQuickAdapter.loadMoreComplete()
//        }
//    }
}