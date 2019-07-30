import 'package:flutter/material.dart';
import 'package:flutter_bd/tools/singleton.dart';

class orderPage extends StatefulWidget {
  orderPage({Key key}) : super(key: key);

  _orderPageState createState() => _orderPageState();
}

class _orderPageState extends State<orderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('orderPage'),
      ),
      body: SafeArea(
        child: Center(
          child: Text('token:' + singletonManager().user.token),
        ),
      ),
    );
  }
}
