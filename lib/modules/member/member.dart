import 'package:flutter/material.dart';
import 'package:flutter_bd/tools/singleton.dart';

class MemberPage extends StatefulWidget {
  MemberPage({Key key}) : super(key: key);

  _MemberPageState createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MemberPage'),
      ),
      body: SafeArea(
        child: Center(
          child: Text('name:' + SingletonManager().userInfo.name),
        ),
      ),
    );
  }
}
