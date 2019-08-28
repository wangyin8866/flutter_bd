import 'package:flutter/material.dart';

/// @author : created by wyman
/// @date : 2019-08-28 09:51
/// des :

class MyCustomText extends StatefulWidget {
  final String count;
  final String text;

  const MyCustomText({Key key, this.count, this.text}) : super(key: key);

  @override
  MyCustomTextState createState() => new MyCustomTextState();
}

class MyCustomTextState extends State<MyCustomText> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(widget.count,
            style: TextStyle(
                color: Color(0xFFD61A1A),
                fontSize: 20,
                fontWeight: FontWeight.w600)),
        SizedBox(height: 5,),
        Text(widget.text,
            style: TextStyle(color: Color(0xFF5D5D5D), fontSize: 12)),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(MyCustomText oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}
