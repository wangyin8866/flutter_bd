import 'package:flutter/material.dart';
import 'package:flutter_bd/tools/singleton.dart';

class minePage extends StatefulWidget {
  minePage({Key key}) : super(key: key);

  _minePageState createState() => _minePageState();
}

class _minePageState extends State<minePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('minePage'),
      ),
      body: SafeArea(
        child: Center(
          child: Text('updated_at:' + singletonManager().user.userInfo.updatedAt),
        ),
      ),
    );
  }
}
