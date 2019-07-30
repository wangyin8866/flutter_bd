import 'package:flutter/material.dart';
import 'package:flutter_bd/tools/singleton.dart';

class memberPage extends StatefulWidget {
  memberPage({Key key}) : super(key: key);

  _memberPageState createState() => _memberPageState();
}

class _memberPageState extends State<memberPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('memberPage'),
      ),
      body: SafeArea(
        child: Center(
          child: Text('name:' + singletonManager().user.userInfo.name),
        ),
      ),
    );
  }
}
