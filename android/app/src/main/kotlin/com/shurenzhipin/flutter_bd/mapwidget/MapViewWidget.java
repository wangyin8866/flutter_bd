package com.shurenzhipin.flutter_bd.mapwidget;

import android.content.Context;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.view.View;

import com.baidu.location.BDAbstractLocationListener;
import com.baidu.location.BDLocation;
import com.baidu.location.LocationClient;
import com.baidu.location.LocationClientOption;
import com.baidu.mapapi.map.BaiduMap;
import com.baidu.mapapi.map.BitmapDescriptor;
import com.baidu.mapapi.map.BitmapDescriptorFactory;
import com.baidu.mapapi.map.MapStatus;
import com.baidu.mapapi.map.MapStatusUpdate;
import com.baidu.mapapi.map.MapStatusUpdateFactory;
import com.baidu.mapapi.map.MapView;
import com.baidu.mapapi.map.MyLocationConfiguration;
import com.baidu.mapapi.map.MyLocationData;
import com.baidu.mapapi.model.LatLng;
import com.shurenzhipin.flutter_bd.R;

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
    private LocationClient mLocationClient;
    private BitmapDescriptor mCurrentMarker = BitmapDescriptorFactory.fromResource(R.drawable.icon_current_marker);
    private SensorManager mSensorManager;



    private boolean isFirstLoc = true;

    //默认人民广场
    private double latitude = 31.238938;
    private double longitude = 121.481693;
    private String address = "人民广场";
    private String city = "上海";
    private float radius = 0.0f;
    private int mCurrentDirection = 0;
    private double lastX = 0.0;

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
            mBaiduMap.getUiSettings().setOverlookingGesturesEnabled(false);
            mBaiduMap.getUiSettings().setRotateGesturesEnabled(false);
            mBaiduMap.setMyLocationEnabled(true);

            mBaiduMap.setMyLocationConfiguration(new MyLocationConfiguration(MyLocationConfiguration.LocationMode.NORMAL,
                    true,
                    mCurrentMarker));
        }

        mSensorManager = (SensorManager) context.getSystemService(Context.SENSOR_SERVICE);

        initLoaction();

        initInvokeChannel(messenger);

        //为系统注册传感器监听
        mSensorManager.registerListener(
                new SensorEventListenerImpl(),
                mSensorManager.getDefaultSensor(Sensor.TYPE_ORIENTATION),
                SensorManager.SENSOR_DELAY_UI
        );
    }

    @Override
    public View getView() {
        return mMapView;
    }

    @Override
    public void dispose() {

    }

    @Override
    public void initLoaction() {
        mLocationClient = new LocationClient(mMapView.getContext());
        mLocationClient.registerLocationListener(new LocationListenerImpl());

        LocationClientOption option = new LocationClientOption();
        option.setScanSpan(1_000);
        option.setCoorType("bd09ll");
        option.setIsNeedAddress(true);
        mLocationClient.setLocOption(option);

        mLocationClient.start();
    }

    @Override
    public void moveToCenter() {
        MapStatusUpdate mapStatusUpdate = MapStatusUpdateFactory.newMapStatus(new MapStatus.Builder()
                .target(new LatLng(latitude, longitude))
                .build());
        mBaiduMap.setMapStatus(mapStatusUpdate);
    }


    private class LocationListenerImpl extends BDAbstractLocationListener {

        @Override
        public void onReceiveLocation(BDLocation bdLocation) {
            if (null != bdLocation && bdLocation.getLocType() != BDLocation.TypeServerError) {
                if (bdLocation.getLatitude() == 4.9E-324 || bdLocation.getLongitude() == 4.9E-324) {
                    latitude = 31.238938;
                    longitude = 121.481693;
                    address = "人民广场";
                } else {
                    latitude = bdLocation.getLatitude();
                    longitude = bdLocation.getLongitude();
                    address = bdLocation.getAddress().street;
                    city = bdLocation.getCity();
                    radius = bdLocation.getRadius();
                }


                mBaiduMap.setMyLocationData(new MyLocationData.Builder()
                        .accuracy(radius)
                        .direction(mCurrentDirection)
                        .latitude(latitude)
                        .longitude(longitude)
                        .build());


                if (isFirstLoc) {
                    isFirstLoc = false;
                    LatLng ll = new LatLng(latitude, longitude);
                    mBaiduMap.animateMapStatus(MapStatusUpdateFactory.newMapStatus(new MapStatus.Builder().target(ll).zoom(17.0f).build()));
                }
            }
        }
    }

    private class SensorEventListenerImpl implements SensorEventListener {

        @Override
        public void onSensorChanged(SensorEvent event) {
            double x = event.values[SensorManager.DATA_X];
            if (Math.abs(x - lastX) > 1.0) {
                mCurrentDirection = (int) x;
                mBaiduMap.setMyLocationData(new MyLocationData.Builder()
                        .accuracy(radius)
                        // 此处设置开发者获取到的方向信息，顺时针0-360
                        .direction(mCurrentDirection).latitude(latitude)
                        .longitude(longitude).build());
            }
            lastX = x;
        }

        @Override
        public void onAccuracyChanged(Sensor sensor, int accuracy) {

        }
    }

}
