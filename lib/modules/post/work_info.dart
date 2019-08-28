import 'package:flutter/material.dart';

class WorkInfoPage extends StatefulWidget {
  @override
  _WorkInfoPageState createState() => _WorkInfoPageState();
}

class _WorkInfoPageState extends State<WorkInfoPage> {



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 10,
          color: Color(0xFFF4F4F4),
        ),
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15, top: 20),
          child: Text(
            '工作环境',
            style: TextStyle(color: Color(0xFF4A4C5B), fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        _photoWidget(),

      ],
    );
  }

  _photoWidget() {
    switch (1) {
      case 1:
        return _onePhotoWidget();
    }
  }

  _onePhotoWidget() {
    return Padding(padding: EdgeInsets.only(left: 15, right: 15, top: 20), child: Container(
      height: 162,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.green
      ),
    ),);
  }

}
