package com.shurenzhipin.flutter_bd.mapwidget;

import android.content.Context;
import android.view.View;
import android.widget.Toast;

import com.baidu.mapapi.map.BaiduMap;
import com.baidu.mapapi.map.MapView;

import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.platform.PlatformView;

/**
 * Auth：yujunyao
 * Since: 2019-09-11 10:52
 * Email：yujunyao@xinrenlei.net
 */

public class MapViewWidget implements PlatformView, IView {

    private MapView mMapView;
    private BaiduMap mBaiduMap;

    private void initInvokeChannel(BinaryMessenger messenger) {
        new MethodChannel(messenger, "bd.flutter.io/map").setMethodCallHandler((methodCall, result) -> {

            switch (methodCall.method) {
                case ConstantChannel.moveToCenter:
                    moveToCenter();
                    break;
                    default:
                        break;
            }
        });
    }

    public MapViewWidget(Context context, BinaryMessenger messenger, int id, Map<String, Object> params) {
        if (null == mMapView) {
            mMapView = new MapView(context);
        }

        if (null == mBaiduMap) {
            mBaiduMap = mMapView.getMap();
        }

        initInvokeChannel(messenger);
    }

    @Override
    public View getView() {
        return mMapView;
    }

    @Override
    public void dispose() {

    }

    @Override
    public void moveToCenter() {
        Toast.makeText(mMapView.getContext(), "moveToCenter", Toast.LENGTH_SHORT).show();
    }
}
