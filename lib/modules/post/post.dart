import 'package:flutter/material.dart';
import 'package:flutter_bd/tools/singleton.dart';

class postPage extends StatefulWidget {
  postPage({Key key}) : super(key: key);

  _postPageState createState() => _postPageState();
}

class _postPageState extends State<postPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('postPage'),
      ),
      body: SafeArea(
        child: Center(
          child: Text('id:${singletonManager().user.userInfo.id}'),
        ),
      ),
    );
  }
}