import 'package:flutter/material.dart';
import 'package:flutter_bd/tools/singleton.dart';

class OrderPage extends StatefulWidget {
  OrderPage({Key key}) : super(key: key);

  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OrderPage'),
      ),
      body: SafeArea(
        child: Center(
          child: Text('token:' + SingletonManager().user.token),
        ),
      ),
    );
  }
}
