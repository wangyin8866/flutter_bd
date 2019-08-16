import 'package:flutter/services.dart';

/// @author : created by wyman
/// @date : 2019-08-14 15:53
/// des :跳转原生页面

class MyFlutterPlugin {
  static const MethodChannel _channel =
      const MethodChannel('com.shurenzhipin.flutter_bd/flutter_plugin');

  /**
   * 打开原生页面
   */
  static Future<String> openNativePage(String target, {Map paramsMap}) async {
    if (paramsMap == null) {
      paramsMap = Map();
    }
    return await _channel
        .invokeMethod("openNative", {"target": target, "params": paramsMap});
  }
}
