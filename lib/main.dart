import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bd/server/routes.dart';
import 'package:oktoast/oktoast.dart';

void main() {
  runZoned(() {
    runApp(MyApp());
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }, onError: (Object obj, StackTrace stack) {
    print(obj);
    print(stack);
  });
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
