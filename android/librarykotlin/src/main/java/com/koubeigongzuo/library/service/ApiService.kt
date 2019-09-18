package com.koubeigongzuo.library.service

import com.koubeigongzuo.library.entity.AdvBean
import com.koubeigongzuo.library.entity.HttpResult
import com.koubeigongzuo.library.entity.RacingBean
import io.reactivex.Observable
import retrofit2.http.FieldMap
import retrofit2.http.FormUrlEncoded
import retrofit2.http.GET
import retrofit2.http.POST

/**
 * Created by  on 2018/4/21.
 */
interface ApiService {


    /**
     * 广告页配置
     *
     */
    @GET("/1.0/common/ad_page")
    fun adv(): Observable<HttpResult<AdvBean>>

    /**
     * 广告页配置
     *
     */
    @GET("/1.0/common/horse-racing")
    fun getRacing(): Observable<HttpResult<RacingBean>>


    /**
     * 录入设备信息
     */
    @POST("/1.0/common/device")
    @FormUrlEncoded
    fun postDeviceInfo(@FieldMap map: HashMap<String, Any?>): Observable<HttpResult<Any>>
}