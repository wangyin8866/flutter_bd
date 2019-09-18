import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bd/server/routes.dart';
import 'package:oktoast/oktoast.dart';
import 'package:rongcloud_im_plugin/rongcloud_im_plugin.dart';

void main() {
  runZoned(() {
    runApp(MyApp());
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle =
          SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
    init();
  }, onError: (Object obj, StackTrace stack) {
    print(obj);
    print(stack);
  });
}

Future init() async {
  if (bool.fromEnvironment("dart.vm.product")) {
    RongcloudImPlugin.init("pkfcgjstpzop8");
  }else {
    RongcloudImPlugin.init("bmdehs6pbgrbs");
  }

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(
        child: MaterialApp(
      // debugShowCheckedModeBanner: false,
      title: '熟仁直聘BD工具',
      initialRoute: loginRoutesName,
      onGenerateRoute: onGenerateRoute,
      theme: ThemeData(primaryColor: Color(0xFFDA4144)),
    ));
  }
}
