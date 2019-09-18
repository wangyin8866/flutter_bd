package com.koubeigongzuo.library.base

import com.koubeigongzuo.library.entity.HttpResult
import com.koubeigongzuo.library.entity.RecommendLocation
import com.trello.rxlifecycle2.LifecycleTransformer

/**
 * @author wyman
 * @date  2018/9/3
 * description :
 */
interface BaseView {

    //显示进度条
    fun showLoading()

    //隐藏进度条
    fun hideLoading()

    //请求成功
    fun showSuccess(response: HttpResult<*>?)

    //请求失败
    fun showFailed(message: String)

    //code码不对的时候
    fun showErrorCode(response: HttpResult<*>?)

    fun showNotNet()

    fun showBaiduRecommend(response: RecommendLocation)

    //绑定生命周期
    fun <T> bindToLife() :LifecycleTransformer<T>


}