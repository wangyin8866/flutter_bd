package com.koubeigongzuo.library.entity

/**
 * @author wyman
 * @date  2018/9/4
 * description :
 */

data class HttpResult<T>(
        val code: Int,
        val msg: String,
        var path: String?,
        val data: T
)




