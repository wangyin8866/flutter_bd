package com.koubeigongzuo.library.net

import android.content.Context
import android.widget.Toast
import com.blankj.utilcode.util.LogUtils
import com.blankj.utilcode.util.NetworkUtils
import com.koubeigongzuo.library.R
import io.reactivex.Observer
import io.reactivex.disposables.Disposable


/**
 * @author wyman
 * @date  2018/9/3
 * description :
 */
@Deprecated("暂时不用")
class ProgressObserver<T>(private val mSubscriberOnNextListener: SubscriberOnNextListener<T>, private var context: Context) : Observer<T>, ProgressCancelListener {
    private var disposable: Disposable? = null
    private var mProgressDialogHandler: ProgressDialogHandler = ProgressDialogHandler(context, true, this)

    override fun onCancelProgress() {
        disposable?.dispose()

    }

    override fun onComplete() {
        dismissProgressDialog()
    }

    override fun onSubscribe(d: Disposable) {
        disposable = d
        if (!NetworkUtils.isConnected()) {
            Toast.makeText(context, R.string.tip_not_net, Toast.LENGTH_SHORT).show()
            onComplete()
            return
        }
        showProgressDialog()
    }


    override fun onNext(t: T) {
        //网络请求载入数据的时候统一保护，防止app崩溃
        try {
            mSubscriberOnNextListener.onNext(t)
        } catch (e: Exception) {
            e.printStackTrace()
            LogUtils.eTag("error", e.message)
        }
    }

    override fun onError(e: Throwable) {
//        if (e.message?.contains("Failed to connect to", true)!!) {
//            LogUtils.e("onError", e.message)
//
//            ARouter.getInstance().build("/lxk/LoginActivity").navigation()
//        }
        LogUtils.e("onError", e.message)
        dismissProgressDialog()
//        ToastUtils.showShort("网络异常，请稍后重试！")
//        mSubscriberOnNextListener.onError(e)

    }

    private fun showProgressDialog() {
        mProgressDialogHandler.obtainMessage(ProgressDialogHandler.SHOW_PROGRESS_DIALOG).sendToTarget()
    }

    private fun dismissProgressDialog() {
        mProgressDialogHandler.obtainMessage(ProgressDialogHandler.DISMISS_PROGRESS_DIALOG).sendToTarget()
        disposable?.dispose()
    }

}