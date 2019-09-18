package com.koubeigongzuo.library.base

import android.annotation.SuppressLint
import android.app.Activity
import android.content.Context
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.annotation.LayoutRes
import com.blankj.utilcode.util.ToastUtils
import com.jakewharton.rxbinding2.view.RxView
import com.koubeigongzuo.library.R
import com.koubeigongzuo.library.entity.HttpResult
import com.koubeigongzuo.library.entity.RecommendLocation
import com.koubeigongzuo.library.net.CustomProgressDialog
import com.trello.rxlifecycle2.LifecycleTransformer
import com.trello.rxlifecycle2.components.support.RxFragment
import me.yokeyword.fragmentation.ExtraTransaction
import me.yokeyword.fragmentation.ISupportFragment
import me.yokeyword.fragmentation.SupportFragmentDelegate
import me.yokeyword.fragmentation.anim.FragmentAnimator
import java.util.concurrent.TimeUnit

/**
 * @author wyman
 * @date  2018/9/3
 * description :
 */
abstract class BaseFragment<T : BasePresenter<V>, V : BaseView> : RxFragment(), ISupportFragment, BaseView {

    protected var mPresenter: T? = null
    private var mDelegate: SupportFragmentDelegate = SupportFragmentDelegate(this)
    private var rootView: View? = null
    protected lateinit var mContext: Context
    private var progressDialog: CustomProgressDialog? = null

    companion object {
        private const val STATE_SAVE_IS_HIDDEN: String = "STATE_SAVE_IS_HIDDEN"
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        mContext = activity!!
        mDelegate.onCreate(savedInstanceState)
        mPresenter = createPresenter()
        mPresenter?.attachView(this as V)

        if (savedInstanceState != null) {
            val isSupportHidden = savedInstanceState.getBoolean(STATE_SAVE_IS_HIDDEN)
            val ft = fragmentManager!!.beginTransaction()
            if (isSupportHidden) {
                ft.hide(this)
            } else {
                ft.show(this)
            }
            ft.commit()
        }
    }

    fun addClickListener(view: View?) {
        view?.let {
            mPresenter?.addSubscribe(RxView.clicks(it).throttleFirst(1, TimeUnit.SECONDS).subscribe {
                onClickView(view)
            })
        }
    }

    open fun onClickView(v: View?) {

    }

    override fun onSaveInstanceState(outState: Bundle) {
        mDelegate.onSaveInstanceState(outState)
        outState.putBoolean(STATE_SAVE_IS_HIDDEN, isHidden)
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        inflaterView(inflater, container)
        return rootView
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        initView(rootView)
    }

    abstract fun initView(rootView: View?)

    private fun inflaterView(inflater: LayoutInflater, container: ViewGroup?) {
        if (rootView == null) {
            rootView = inflater.inflate(getLayoutId(), container, false)
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        mDelegate.onDestroy()
        mPresenter?.detachView()
        if (mPresenter != null) {
            mPresenter = null
        }
    }

    @LayoutRes
    abstract fun getLayoutId(): Int

    abstract fun createPresenter(): T?

    override fun setFragmentResult(resultCode: Int, bundle: Bundle?) {
        mDelegate.setFragmentResult(resultCode, bundle)
    }

    override fun onSupportInvisible() {
        mDelegate.onSupportInvisible()
    }

    override fun onNewBundle(args: Bundle?) {
        mDelegate.onNewBundle(args)
    }

    override fun onAttach(activity: Activity?) {
        super.onAttach(activity)

        mDelegate.onAttach(activity)
    }

    override fun extraTransaction(): ExtraTransaction {
        return mDelegate.extraTransaction()
    }

    override fun onCreateFragmentAnimator(): FragmentAnimator {
        return mDelegate.onCreateFragmentAnimator()
    }


    override fun onFragmentResult(requestCode: Int, resultCode: Int, data: Bundle?) {
        mDelegate.onFragmentResult(requestCode, resultCode, data)
    }

    override fun setFragmentAnimator(fragmentAnimator: FragmentAnimator?) {
        mDelegate.fragmentAnimator
    }

    /**
     * 同级下的 懒加载 ＋ ViewPager下的懒加载  的结合回调方法
     */
    override fun onLazyInitView(savedInstanceState: Bundle?) {
        mDelegate.onLazyInitView(savedInstanceState)

    }

    override fun getFragmentAnimator(): FragmentAnimator {
        return mDelegate.fragmentAnimator
    }

    override fun isSupportVisible(): Boolean {
        return mDelegate.isSupportVisible
    }

    override fun onEnterAnimationEnd(savedInstanceState: Bundle?) {
        mDelegate.onEnterAnimationEnd(savedInstanceState)
    }

    override fun onSupportVisible() {
        mDelegate.onSupportVisible()
    }

    override fun onBackPressedSupport(): Boolean {
        return mDelegate.onBackPressedSupport()
    }

    override fun getSupportDelegate(): SupportFragmentDelegate {
        return mDelegate
    }

    /**
     * 添加NewBundle,用于启动模式为SingleTask/SingleTop时
     */
    override fun putNewBundle(newBundle: Bundle?) {
        mDelegate.putNewBundle(newBundle)
    }

    @SuppressLint("MissingSuperCall")
    override fun onActivityCreated(savedInstanceState: Bundle?) {
        super.onActivityCreated(savedInstanceState)
        mDelegate.onActivityCreated(savedInstanceState)
    }

    override fun onResume() {
        super.onResume()
        mDelegate.onResume()
    }

    override fun onPause() {
        super.onPause()
        mDelegate.onPause()
    }

    override fun onDestroyView() {
        mDelegate.onDestroyView()
        super.onDestroyView()
    }


    override fun onHiddenChanged(hidden: Boolean) {
        super.onHiddenChanged(hidden)
        mDelegate.onHiddenChanged(hidden)
    }

    override fun setUserVisibleHint(isVisibleToUser: Boolean) {
        super.setUserVisibleHint(isVisibleToUser)
        mDelegate.setUserVisibleHint(isVisibleToUser)
    }

    override fun post(runnable: Runnable?) {
        mDelegate.post(runnable)
    }

    override fun enqueueAction(runnable: Runnable?) {
        mDelegate.enqueueAction(runnable)
    }

    override fun showLoading() {
        showProgressDialog()
    }

    override fun hideLoading() {
        dismissProgressDialog()
    }

    override fun showSuccess(response: HttpResult<*>?) {

    }

    override fun showErrorCode(response: HttpResult<*>?) {
        if (response?.code == 100021 || response?.code==100010) {//不给用户提示
            return
        }
        ToastUtils.showShort(response?.msg)
    }

    override fun showFailed(message: String) {
    }

    override fun showBaiduRecommend(response: RecommendLocation) {

    }

    override fun showNotNet() {
        ToastUtils.showShort(getString(R.string.tip_not_net))
    }

    override fun <T> bindToLife(): LifecycleTransformer<T> {
        return this.bindToLifecycle()
    }

    private fun dismissProgressDialog() {
        progressDialog?.dismiss()
    }

    private fun showProgressDialog() {
        if (progressDialog == null) {
            progressDialog = CustomProgressDialog(mContext)
        }
        if (!progressDialog?.isShowing!!) {
            progressDialog?.show()
        }
    }
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
//            LoadType.TYPE_REFRESH_ERROR -> refreshLayout.finishRefresh()
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