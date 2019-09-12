package com.shurenzhipin.flutter_bd.mapwidget;

import android.content.Context;
import android.graphics.Point;
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
import com.blankj.utilcode.util.LogUtils;
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
    private SensorEventListenerImpl sensorEventListener;


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
                    moveToCenter(new LatLng(latitude, longitude), true);
                    break;
                case ConstantChannel.onResumed:
                    onResumed();
                    break;
                case ConstantChannel.onPaused:
                    onPaused();
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
        sensorEventListener = new SensorEventListenerImpl();

        //为系统注册传感器监听
        mSensorManager.registerListener(
                sensorEventListener,
                mSensorManager.getDefaultSensor(Sensor.TYPE_ORIENTATION),
                SensorManager.SENSOR_DELAY_UI
        );

        initLoaction();

        initInvokeChannel(messenger);
    }

    @Override
    public View getView() {
        return mMapView;
    }

    @Override
    public void dispose() {
        LogUtils.e("mapView---->dispose");
        mMapView.onDestroy();
        mLocationClient.stop();
    }

    @Override
    public void onResumed() {
        LogUtils.e("mapView---->onResumed");
        mMapView.onResume();
        //为系统注册传感器监听
        mSensorManager.registerListener(
                sensorEventListener,
                mSensorManager.getDefaultSensor(Sensor.TYPE_ORIENTATION),
                SensorManager.SENSOR_DELAY_UI
        );
    }

    @Override
    public void onPaused() {
        LogUtils.e("mapView---->onPaused");
        mMapView.onPause();
        mSensorManager.unregisterListener(sensorEventListener);
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
    public void moveToCenter(LatLng latLng, boolean defalutZoom) {
        MapStatus mapStatus;
        if (defalutZoom) {
            mapStatus = new MapStatus.Builder()
                    .target(latLng)
                    .zoom(17.0f)
                    .build();
        } else {
            mapStatus = new MapStatus.Builder()
                    .target(latLng)
                    .build();
        }
        MapStatusUpdate mapStatusUpdate = MapStatusUpdateFactory.newMapStatus(mapStatus);
        mBaiduMap.setMapStatus(mapStatusUpdate);

        calculateOffsetAndMove(latLng);
    }

    @Override
    public void calculateOffsetAndMove(LatLng latLng) {
        mMapView.postDelayed(() -> {
            LatLng originLatLng = mBaiduMap.getProjection().fromScreenLocation(new Point(0, 0));
            double offsetLatitude = (originLatLng.latitude - latLng.latitude) / 2;
            LatLng ll1 = new LatLng(latLng.latitude - offsetLatitude, longitude);
            mBaiduMap.setMapStatus(MapStatusUpdateFactory.newMapStatus(new MapStatus.Builder().target(ll1).zoom(17.0f).build()));

        }, 300);
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
                    moveToCenter(new LatLng(latitude, longitude), true);
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
