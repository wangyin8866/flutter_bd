import 'package:flutter/material.dart';

/// @author : created by wyman
/// @date : 2019-08-28 10:28
/// des :

class MyCustomTab extends StatefulWidget {
  final String imgPath;
  final String content;
  final GestureTapCallback onTap;

  const MyCustomTab({Key key, this.imgPath, this.content, this.onTap})
      : super(key: key);

  @override
  MyCustomTabState createState() => new MyCustomTabState();
}

class MyCustomTabState extends State<MyCustomTab> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: double.infinity,
        height: 55,
        child: Row(
          children: <Widget>[
            Image.asset(widget.imgPath),
            Text(widget.content,
                style: TextStyle(fontSize: 14, color: Color(0xFF282828))),
            Expanded(
                child: Text(
              ">",
              style: TextStyle(color: Color(0xFF282828), fontSize: 14),
            ))
          ],
        ),
      ),
      onTap: widget.onTap,
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
  void didUpdateWidget(MyCustomTab oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}
