package com.koubeigongzuo.library.net

/**
 * @author wyman
 * @date  2018/9/3
 * description :
 */
interface SubscriberOnNextListener<T> {
    fun onNext(t :T)
//    fun onError(e:Throwable)
}