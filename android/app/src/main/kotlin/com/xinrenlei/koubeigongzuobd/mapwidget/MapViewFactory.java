package com.xinrenlei.koubeigongzuobd.mapwidget;

import android.app.Activity;
import android.content.Context;

import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

/**
 * Auth：yujunyao
 * Since: 2019-09-11 11:18
 * Email：yujunyao@xinrenlei.net
 */

public class MapViewFactory extends PlatformViewFactory {

    private final BinaryMessenger messenger;
    private Activity activity;

    public MapViewFactory(BinaryMessenger messenger, Activity activity) {
        super(StandardMessageCodec.INSTANCE);
        this.messenger = messenger;
        this.activity = activity;
    }

    @Override
    public PlatformView create(Context context, int id, Object args) {
        Map<String, Object> params = null;
        if (args != null) {
            params= (Map<String, Object>) args;
        }
        return new  MapViewWidget(activity, messenger, id, params);
    }
}
