package com.cxz.wanandroid.receiver

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import com.blankj.utilcode.util.NetworkUtils
import com.koubeigongzuo.library.base.RxBus
import com.koubeigongzuo.library.config.BaseConstant
import com.koubeigongzuo.library.event.NetworkChangeEvent
import com.koubeigongzuo.library.utils.PreferenceData

/**
 * Created by wyman on 2018/8/1.
 */
@Deprecated("暂时不用")
class NetworkChangeReceiver : BroadcastReceiver() {

    /**
     * 缓存上一次的网络状态
     */
    private var hasNetwork: Boolean by PreferenceData(BaseConstant.HAS_NETWORK_KEY, true)

    override fun onReceive(context: Context, intent: Intent) {
        val isConnected = NetworkUtils.isConnected()
        if (isConnected) {
            if (isConnected != hasNetwork) {
                RxBus.getInstance().post(NetworkChangeEvent(isConnected,false))
            }
        } else {
            RxBus.getInstance().post(NetworkChangeEvent(isConnected,false))
        }
    }

}