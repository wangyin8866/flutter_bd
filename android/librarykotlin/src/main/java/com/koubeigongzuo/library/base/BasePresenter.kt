package com.koubeigongzuo.library.base

import com.alibaba.android.arouter.launcher.ARouter
import com.blankj.utilcode.util.LogUtils
import com.blankj.utilcode.util.NetworkUtils
import com.blankj.utilcode.util.ToastUtils
import com.koubeigongzuo.library.config.BaseConstant
import com.koubeigongzuo.library.entity.HttpResult
import com.koubeigongzuo.library.entity.RecommendLocation
import com.koubeigongzuo.library.net.RetryWithDelay
import com.koubeigongzuo.library.utils.PreferenceData
import io.reactivex.Observable
import io.reactivex.Observer
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.disposables.CompositeDisposable
import io.reactivex.disposables.Disposable
import io.reactivex.schedulers.Schedulers
import java.lang.ref.SoftReference

/**
 * @author wyman
 * @date  2018/9/3
 * description :
 */
open class BasePresenter<T : BaseView> {
    private var mVReference: SoftReference<T>? = null
    private var compositeDisposable: CompositeDisposable? = null

    protected fun <V> invoke(observable: Observable<V>, isShowProgressDialog: Boolean = true, path: String = "") {
        if (!NetworkUtils.isConnected()) {
            ToastUtils.showShort("当前网络不可用")
            return
        }
        if (getView()?.bindToLife<V>() != null) {
            observable.subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .compose(getView()?.bindToLife())
                .retryWhen(RetryWithDelay())
                .subscribe(object : Observer<V> {
                    override fun onComplete() {
                        if (isShowProgressDialog) {
                            getView()?.hideLoading()
                        }
                    }

                    override fun onSubscribe(d: Disposable) {
                        if (isShowProgressDialog) {
                            getView()?.showLoading()
                        }
                    }

                    override fun onNext(t: V) {

                        when (t) {
                            is RecommendLocation -> {
                                if (t.status == 0) {
                                    getView()?.showBaiduRecommend(t)
                                }
                            }
                            is HttpResult<*> -> {
                                if (t.code == 200001 || t.code == 220001 || t.code == 220005 || t.code == 220010 || t.code == 220008 || t.code == 200008 || t.code == 220013) {
                                    //清除信息
                                    PreferenceData.clearPreference()
                                    ARouter.getInstance().build("/kbgz/LoginActivity")
                                        .withString(BaseConstant.KEY_ASYN_LOGIN, BaseConstant.KEY_ASYN_LOGIN)
                                        .withString(BaseConstant.KEY_MSG, t.msg).withInt(BaseConstant.KEY_CODE, t.code)
                                        .navigation()
                                    return
                                }

                                t.path = path
                                try {
                                    if (t.code == 0) {
                                        getView()?.showSuccess(t)
                                    } else {
                                        getView()?.showErrorCode(t)
                                    }
                                } catch (e: Exception) {
                                    e.printStackTrace()
                                    LogUtils.eTag("wyman", e.message)

                                }
                            }
                        }

                    }

                    override fun onError(e: Throwable) {
                        LogUtils.eTag("wyman", e.message)

                        if (isShowProgressDialog) {
                            getView()?.hideLoading()
                        }
                    }

                })
        }
    }

    fun addSubscribe(disposable: Disposable) {
        if (compositeDisposable == null) {
            compositeDisposable = CompositeDisposable()
        }

        compositeDisposable?.add(disposable)
    }

    fun removeSubscribe(disposable: Disposable) {
        compositeDisposable?.let {
            it.remove(disposable)
        }
    }

    fun unsubscribe() {
        compositeDisposable?.let {
            it.dispose()
        }
    }

    /**
     * 关联View
     */
    fun attachView(view: T) {
        mVReference = SoftReference(view)
    }

    /**
     * 解除关联
     */
    fun detachView() {
        mVReference?.clear()
        mVReference = null
        unsubscribe()
    }

    fun getView(): T? {
        return mVReference?.get()

    }
}