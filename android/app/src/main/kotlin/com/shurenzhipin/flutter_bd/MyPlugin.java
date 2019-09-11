package com.shurenzhipin.flutter_bd;

import android.content.Intent;

import io.flutter.app.FlutterFragmentActivity;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;

/**
 * @author : created by wyman
 * @date : 2019-08-14 15:56
 * des :
 */
public class MyPlugin {
    public static void registerWith(final BinaryMessenger messenger, FlutterFragmentActivity activity) {
        new MethodChannel(messenger, "com.shurenzhipin.flutter_bd/flutter_plugin").setMethodCallHandler((methodCall, result) -> {

            // 解析参数，做页面跳转
            if ("openNative".equals(methodCall.method)) {

                String target = methodCall.argument("target");
                activity.startActivity(new Intent(activity, TestActivity.class));
            }
        });
    }
}
