import 'package:flutter/material.dart';
import 'package:flutter_bd/modules/login/userInfo.dart';
import 'package:flutter_bd/server/routes.dart';
import 'package:flutter_bd/tools/singleton.dart';
import 'package:flutter_bd/tools/storage.dart';
import 'package:flutter_bd/config/config.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class OrderPage extends StatefulWidget {
  OrderPage({Key key}) : super(key: key);

  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  String _name = '';

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 2);
    _tabController.addListener(() {
      print(_tabController.index);
    });

    _getUserInfo();
  }

  _getUserInfo() async {
    var token = await Storage.get(Config.TOKEN);
    var url = 'http://onsite-api.ci.dev.lanxinka.com/1.0/bd/user/info';
    var response = await http.get(url, headers: {'Authorization': token});
    if (response.statusCode == 200) {
      var jsonStr = convert.Utf8Decoder().convert(response.bodyBytes);
      var json = convert.jsonDecode(jsonStr);
      print(json);
      if (json['code'] == 0) {
        SingletonManager().userInfo = UserInfo.fromJson(json['data']);
        setState(() {
          _name = SingletonManager().userInfo.name;
        });
      } else if (json['code'] == 200001) {
        // 登录信息无效
        Storage.remove(Config.TOKEN);
        Navigator.pushReplacementNamed(context, loginRoutesName);
      } else {
        print(json['msg']);
      }
    } else {
      print('status code is ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff1eeee),
        appBar: AppBar(
          backgroundColor: Color(0xffea4c56),
          elevation: 0,
          actions: <Widget>[
            SizedBox(width: 15),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                '欢迎！${_name}Hi',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
            Expanded(
              child: Container(),
            ),
            Container(
              height: 20,
              width: 20,
              child: GestureDetector(
                onTap: () {
                  print('msg click');
                },
                child: Icon(
                  Icons.access_alarm,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 20),
            Container(
              height: 20,
              width: 20,
              child: GestureDetector(
                onTap: () {
                  print('qr click');
                },
                child: Icon(
                  Icons.nfc,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 20),
          ],
          bottom: TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            indicatorSize: TabBarIndicatorSize.label,
            controller: _tabController,
            tabs: <Widget>[
              Tab(text: '待确认'),
              Tab(text: '待面试'),
            ],
          ),
        ),
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(height: 50, color: Color(0xffea4c56)),
                Expanded(child: Container()),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  ListView.builder(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    itemCount: 9,
                    itemBuilder: (context, index) {
                      return confirmCell(index);
                    },
                  ),
                  ListView.builder(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    itemCount: 9,
                    itemBuilder: (context, index) {
                      return interviewCell(index);
                    },
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Widget confirmCell(int index) {
    return Column(
      children: <Widget>[
        GestureDetector(
          child: Container(
            height: 141,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            padding: EdgeInsets.fromLTRB(15, 11, 15, 0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '其妙  18612345678',
                      style: TextStyle(
                        color: Color(0xff282828),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '已等待 1小时35分钟',
                      style: TextStyle(
                        color: Color(0xff3b3b3b),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Color(0xfff6f6f6),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  padding: EdgeInsets.fromLTRB(9, 8, 9, 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.room,
                            size: 12,
                            color: Color(0xffa2a6ae),
                          ),
                          SizedBox(width: 4),
                          Text(
                            '上海-上海市-浦东新区·陆家嘴浦东南路1271号',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xff4c4e5b),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.access_alarm,
                            size: 12,
                            color: Color(0xffa2a6ae),
                          ),
                          SizedBox(width: 4),
                          Text(
                            '2019-06-12 13:00',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xff4c4e5b),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '2.1km 丨  预计耗时 13分钟',
                        style: TextStyle(
                          color: Color(0xff030303),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Container(
                        height: 23,
                        width: 61,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xffc2c2c2),
                                offset: Offset(0, 3),
                                blurRadius: 12),
                          ],
                        ),
                        child: RaisedButton(
                          color: Color(0xffc2c2c2),
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Text(
                            '取消面试',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                            ),
                          ),
                          onPressed: () {
                            print('取消面试');
                          },
                        ),
                      ),
                      SizedBox(width: 11),
                      Container(
                        height: 23,
                        width: 61,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xffe7434c).withOpacity(0.41),
                                offset: Offset(0, 3),
                                blurRadius: 12),
                          ],
                        ),
                        child: RaisedButton(
                          color: Color(0xffea4c56),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Text(
                            '确认',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                            ),
                          ),
                          onPressed: () {
                            print('确认');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            print(index);
          },
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget interviewCell(int index) {
    return Column(
      children: <Widget>[
        GestureDetector(
          child: Container(
            height: 141,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            padding: EdgeInsets.fromLTRB(15, 11, 15, 0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '其妙  18612345678',
                      style: TextStyle(
                        color: Color(0xff282828),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    GestureDetector(
                      child: Icon(
                        Icons.message,
                        color: Color(0xff4a4c5a),
                      ),
                      onTap: () {
                        print('msg---$index');
                      },
                    ),
                    SizedBox(width: 33),
                    GestureDetector(
                      child: Icon(
                        Icons.call,
                        color: Color(0xff4a4c5a),
                      ),
                      onTap: () {
                        print('call---$index');
                      },
                    ),
                    SizedBox(width: 114),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Color(0xfff6f6f6),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  padding: EdgeInsets.fromLTRB(9, 8, 9, 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.room,
                            size: 12,
                            color: Color(0xffa2a6ae),
                          ),
                          SizedBox(width: 4),
                          Text(
                            '上海-上海市-浦东新区·陆家嘴浦东南路1271号',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xff4c4e5b),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.access_alarm,
                            size: 12,
                            color: Color(0xffa2a6ae),
                          ),
                          SizedBox(width: 4),
                          Text(
                            '2019-06-12 13:00',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xff4c4e5b),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '我已到达',
                        style: TextStyle(
                          color: Color(0xff030303),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Container(
                        height: 23,
                        width: 72,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xffc2c2c2),
                                offset: Offset(0, 3),
                                blurRadius: 12),
                          ],
                        ),
                        child: RaisedButton(
                          color: Color(0xffc2c2c2),
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Text(
                            '会员未到面',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                            ),
                          ),
                          onPressed: () {
                            print('取消面试');
                          },
                        ),
                      ),
                      SizedBox(width: 11),
                      Container(
                        height: 23,
                        width: 61,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xffe7434c).withOpacity(0.41),
                                offset: Offset(0, 3),
                                blurRadius: 12),
                          ],
                        ),
                        child: RaisedButton(
                          color: Color(0xffea4c56),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Text(
                            '确认',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                            ),
                          ),
                          onPressed: () {
                            print('确认');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            print(index);
          },
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
