import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bd/model/AccountBean.dart';
import 'package:flutter_bd/modules/base/base_mvp.dart';
import 'package:flutter_bd/modules/base/base_state_page.dart';
import 'package:flutter_bd/tools/singleton.dart';
import 'package:flutter_bd/widget/my_custom_tab.dart';
import 'package:flutter_bd/widget/my_custom_text.dart';
import 'package:oktoast/oktoast.dart';

import 'mine_presenter.dart';

class MinePage extends StatefulWidget {
  MinePage({Key key}) : super(key: key);

  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends BasePageState<MinePage, MinePresenter> {
  //今日数据的字体颜色
  int _color_one = 0xFFD61A1A;

  //团队数据的字体颜色
  int _color_two = 0xFF4A4C5B;

  //选中的数据
  int _postion = 0;

  double _statusHeight = 0;

  String _money;

  @override
  void showSuccess(BaseBean response) {
    super.showSuccess(response);
    if (response is AccountBean) {

      setState(() {
        _money = response.data.balance;

      });
    }
  }

  @override
  void initState() {
    super.initState();

    mPresenter.requestAccount<AccountBean>();
  }

  @override
  Widget build(BuildContext context) {
    _statusHeight = MediaQuery
        .of(context)
        .padding
        .top;
    return Scaffold(
      body: SafeArea(
          top: false,
          bottom: true,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              child: Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      topCardWidget(),
                      bottomWidget(),
                    ],
                  ),
                  centerCardWidget()
                ],
              ),
            ),
          )),
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
            padding: EdgeInsets.fromLTRB(0, 23 + _statusHeight, 30, 0),
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
                    child: Image.network(
                      SingletonManager().userInfo.data.imPortrait,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(14, 0, 28, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(SingletonManager().userInfo.data.name,
                            style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 23,
                                fontWeight: FontWeight.w600)),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              SingletonManager().userInfo.data.mobile,
                              style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              ">",
                              style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ],
                    )),
                Expanded(
                    flex: 1,
                    child: Row(
                      children: <Widget>[
                        Expanded(flex: 1, child: SizedBox()),
                        Container(
                          width: 102,
                          height: 36,
                          decoration: BoxDecoration(
                              color: Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(44),
                                  topRight: Radius.circular(0),
                                  bottomRight: Radius.circular(0),
                                  bottomLeft: Radius.circular(44))),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 5, 5, 5),
                            child: Row(
                              children: <Widget>[
                                Image.asset(
                                  "images/icon_jlj.png",
                                  fit: BoxFit.contain,
                                  width: 20,
                                  height: 20,
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "奖励金",
                                      style: TextStyle(
                                          color: Color(0xFFD61A1A),
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "¥$_money",
                                      style: TextStyle(
                                          color: Color(0xFFD61A1A),
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Stack(
                                      alignment: Alignment.centerRight,
                                      children: <Widget>[
                                        Positioned(
                                            child: Text(
                                              ">",
                                              style: TextStyle(
                                                  color: Color(0xFFD61A1A),
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w500),
                                            ))
                                      ],
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget centerCardWidget() {
    return Positioned(
        top: 145 + _statusHeight,
        right: 18,
        left: 20,
        child: Container(
          decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                    color: Color(0xfff1eeee),
                    offset: Offset(0, 8),
                    blurRadius: 9)
              ]),
          width: 338,
          height: 213,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 17, 0, 9),
                      child: GestureDetector(
                        child: Text(
                          "个人今日数据",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(_color_one),
                              fontSize: 13,
                              fontWeight: FontWeight.w600),
                        ),
                        onTap: () {
                          setState(() {
                            _color_one = 0xFFD61A1A;
                            _color_two = 0xFF4A4C5B;
                          });
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 33,
                    color: Color(0xFFE8E8E8),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 17, 0, 9),
                      child: GestureDetector(
                        child: Text(
                          "团队今日数据",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(_color_two),
                              fontSize: 13,
                              fontWeight: FontWeight.w600),
                        ),
                        onTap: () {
                          setState(() {
                            _color_one = 0xFF4A4C5B;
                            _color_two = 0xFFD61A1A;
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 13, 20),
                width: double.infinity,
                height: 1,
                color: Color(0xFFE8E8E8),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MyCustomText(
                    count: "10",
                    text: "新增简历",
                  ),
                  MyCustomText(
                    count: "20",
                    text: "新增预约",
                  ),
                  MyCustomText(
                    count: "30",
                    text: "新增刀面",
                  )
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MyCustomText(
                    count: "8",
                    text: "面试通过",
                  ),
                  MyCustomText(
                    count: "8",
                    text: "新增入职",
                  ),
                  MyCustomText(
                    count: "0",
                    text: "新增离职",
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 12, 13, 0),
                width: double.infinity,
                height: 1,
                color: Color(0xFFE8E8E8),
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(child: SizedBox(), flex: 1),
                    Text(
                      "查看历史",
                      style: TextStyle(color: Color(0xFF5D5D5D), fontSize: 12),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(8, 0, 12, 0),
                      child: Text(
                        ">",
                        style:
                        TextStyle(color: Color(0xFF5D5D5D), fontSize: 12),
                      ),
                    )
                  ],
                ),
                flex: 1,
              )
            ],
          ),
        ));
  }

  Widget bottomWidget() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 160 + _statusHeight, 0, 0),
      child: Column(
        children: <Widget>[
          MyCustomTab(
              imgPath: "images/icon_activity.png",
              content: "我的二维码",
              onTap: () {
                showToast("我的二维码");
              }),
          Container(
            width: double.infinity,
            height: 1,
            color: Color(0xFFE8E8E8),
          ),
          MyCustomTab(
              imgPath: "images/icon_message.png",
              content: "我的消息",
              onTap: () {
                showToast("我的消息");
              }),
          Container(
            width: double.infinity,
            height: 1,
            color: Color(0xFFE8E8E8),
          ),
          MyCustomTab(
              imgPath: "images/icon_activity.png",
              content: "金融活动",
              onTap: () {
                showToast("金融活动");
              }),
          Container(
            width: double.infinity,
            height: 1,
            color: Color(0xFFE8E8E8),
          ),
          MyCustomTab(
              imgPath: "images/icon_setting.png",
              content: "设置",
              onTap: () {
                showToast("设置");
              }),
        ],
      ),
    );
  }

  @override
  MinePresenter createPresenter() {
    return MinePresenter();
  }
}
