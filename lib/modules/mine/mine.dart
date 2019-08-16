import 'package:flutter/material.dart';

class MinePage extends StatefulWidget {
  MinePage({Key key}) : super(key: key);

  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            alignment: AlignmentDirectional.topStart,
            children: <Widget>[
              topCardWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget topCardWidget() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("images/my_bg.png"), fit: BoxFit.cover),
      ),
      width: double.infinity,
      height: 203,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 23, 30, 0),
            child: Align(
              alignment: Alignment.topRight,
              child: Image.asset(
                "images/camera.png",
                width: 21,
                height: 16,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 37),
            child: Row(
              children: <Widget>[
                ClipOval(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(35)),
                    width: 70,
                    height: 70,
                    child: Image.asset(
                      "images/but_weixin_login.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(14, 0, 28, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("小慧慧",
                            style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 23,
                                fontWeight: FontWeight.w600)),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          "176 0215 614",
                          style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
