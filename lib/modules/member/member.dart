import 'package:flutter/material.dart';
import 'package:flutter_bd/tools/singleton.dart';

class MemberPage extends StatefulWidget {
  MemberPage({Key key}) : super(key: key);

  _MemberPageState createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffea4c56),
        elevation: 0,
        actions: <Widget>[
          SizedBox(
            width: 15,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text('欢迎！${SingletonManager().userInfo.data.name}'),
          ),
          Expanded(
            child: Container(),
          ),
          Container(
            height: 20,
            width: 20,
            child: GestureDetector(
              onTap: () {
                print('点了小铃铛');
              },
              child: Icon(
                Icons.add_alert,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Container(
            height: 20,
            width: 20,
            child: GestureDetector(
              onTap: () {
                print('点了三维码');
              },
              child: Icon(
                Icons.nfc,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: 15,
          )
        ],
      ),
      body: SafeArea(
          child: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              height: 55,
              color: Color(0xffea4c56),
              child: TextField(
                keyboardType: TextInputType.text,
                obscureText: true,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: '搜索会员姓名或手机号',
                  hintStyle: TextStyle(color: Color(0xffa6aab2), fontSize: 14),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFFFFF),
                    ),
                  ),
                ),
                onChanged: (tx) {
                  print('$tx');
                },
              ),
            ),
            Positioned(
              top: 55,
              left: 0,
              right: 0,
              bottom: 0,
              child: ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: 50,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.only(
                      bottom: 10,
                    ),
                    child: Container(
                      height: 158,
                      child: Text('$index'),
                      color: Colors.orange,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}
