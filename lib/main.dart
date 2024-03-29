import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bd/server/routes.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      title: '熟仁直聘BD工具',
      initialRoute: '/',
      onGenerateRoute: onGenerateRoute,
    );
  }
}
