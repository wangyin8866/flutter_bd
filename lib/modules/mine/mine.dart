import 'package:flutter/material.dart';
import 'package:flutter_bd/tools/singleton.dart';

class MinePage extends StatefulWidget {
  MinePage({Key key}) : super(key: key);

  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MinePage'),
      ),
      body: SafeArea(
        child: Center(
          child: Text('updated_at:' + SingletonManager().user.userInfo.updatedAt),
        ),
      ),
    );
  }
}
