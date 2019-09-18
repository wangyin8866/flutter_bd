package com.xinrenlei.koubeigongzuobd.utils

import android.annotation.SuppressLint
import com.tbruyelle.rxpermissions2.RxPermissions
import com.xinrenlei.koubeigongzuobd.MainActivity
import io.reactivex.disposables.CompositeDisposable

/**
 * Auth：yujunyao
 * Since: 2018/12/19 下午7:45
 * Email：yujunyao@aiwending.com
 */

class ApplyPermissionsUtils {

    companion object {
        val instance: ApplyPermissionsUtils by lazy(mode = LazyThreadSafetyMode.SYNCHRONIZED) {
            ApplyPermissionsUtils()
        }

        val map = mutableMapOf<String, CompositeDisposable>()
    }

    @SuppressLint("CheckResult")
    fun requestPermissions(
            tag: String,
            fragmentActivity: MainActivity,
            onNext: ((t: Boolean) -> Unit),
            vararg permissions: String
    ) {

        var compositeDisposable = CompositeDisposable()
        map[tag] = compositeDisposable

        compositeDisposable.add(RxPermissions(fragmentActivity).request(*permissions).subscribe(onNext))
    }

    fun unbind(tag: String) {
        var disposable = map[tag]
        if (null != disposable && !disposable.isDisposed) {
            disposable.clear()
        }
        map.remove(tag)
    }

}