import 'package:flutter/material.dart';

// 常规Text快速写法
Text normalText(
    String text, Color color, double fontSize, FontWeight fontWeight,
    {TextDecoration textDecoration = TextDecoration.none}) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      decoration: textDecoration,
    ),
  );
}

// 常规图文按钮快速写法
Widget normalImageTextButton(IconData iconData, String title, Function onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(iconData),
        SizedBox(width: 5),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: Color(0xff4a4c5a),
          ),
        ),
      ],
    ),
  );
}

// 常规方块圆角按钮快速写法
Widget normalRoundRectButton(Text text, double height, double width,
    Color backgroundColor, double radius, Function onTap) {
  return GestureDetector(
    child: Container(
      height: height,
      width: width,
      child: text,
      alignment: Alignment.center,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius), color: backgroundColor),
    ),
    onTap: onTap,
  );
}
