import 'package:flutter/material.dart';

class OrderDetailPage extends StatefulWidget {
  OrderDetailPage({Key key}) : super(key: key);

  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('orderDetail'),
      ),
    );
  }
}
