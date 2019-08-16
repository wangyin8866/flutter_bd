import 'package:flutter/material.dart';
import 'package:flutter_bd/tools/singleton.dart';

class SchedulePage extends StatefulWidget {
  SchedulePage({Key key}) : super(key: key);

  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SchedulePage'),
      ),
      body: SafeArea(
        child: Center(
          child: Text('mobile:' + SingletonManager().userInfo.mobile),
        ),
      ),
    );
  }
}