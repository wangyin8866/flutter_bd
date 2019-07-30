import 'package:flutter/material.dart';
import 'package:flutter_bd/tools/singleton.dart';

class schedulePage extends StatefulWidget {
  schedulePage({Key key}) : super(key: key);

  _schedulePageState createState() => _schedulePageState();
}

class _schedulePageState extends State<schedulePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('schedulePage'),
      ),
      body: SafeArea(
        child: Center(
          child: Text('mobile:' + singletonManager().user.userInfo.mobile),
        ),
      ),
    );
  }
}