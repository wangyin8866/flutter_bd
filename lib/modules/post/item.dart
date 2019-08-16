import 'package:flutter/material.dart';


class PostItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Container(
        color: Colors.white,
        height: 89,
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Row(
                children: <Widget>[
                  Text(
                    '便利店营业员',
                    style: TextStyle(color: Color(0xFF333333), fontSize: 14),
                  ),
                  SizedBox(width: 10,),
                  Container(height: 12, width: 20, color: Colors.red,)
                ],
              ),
              left: 15,
              top: 10,
            ),
            Positioned(
              child: Text(
                '4100-5500元/月',
                style: TextStyle(color: Color(0xFFEA4C56), fontSize: 14),
              ),
              top: 10,
              right: 9,
            ),
            Positioned(
              child: Row(
                children: <Widget>[
                Container(height: 20, width: 20, color: Colors.red,),
                  SizedBox(width: 5,),
                  Text(
                    '7-11便利店',
                    style: TextStyle(color: Color(0xFF232323), fontSize: 12),
                  ),
                ],
              ),
              left: 15,
              bottom: 22,
            ),
            Positioned(
              child: Text(
                '招10人',
                style: TextStyle(color: Color(0xFF232323), fontSize: 12),
              ),
              bottom: 23,
              right: 13,
            )
          ],
        ),
      ),
    );
  }
}