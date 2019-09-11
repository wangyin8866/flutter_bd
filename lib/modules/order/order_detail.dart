import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bd/tools/custom_widgets.dart';

class OrderDetailPage extends StatefulWidget {
  OrderDetailPage({Key key}) : super(key: key);

  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {

  final MethodChannel _channel = const MethodChannel('bd.flutter.io/map');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: Text(
          '订单详情',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w500,
            color: Color(0xff030303),
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xff030303),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            _mapWidget(),
            _mainWidget(),
          ],
        ),
      ),
    );
  }

  Widget _mapWidget() {
    return Container(
      child: UiKitView(viewType: 'mapView'),
    );
  }

  Widget _mainWidget() {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          10, 0, 10, 10 + MediaQuery.of(context).padding.bottom),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RaisedButton(
                child: Text('查看简历'),
                onPressed: () {
                  print('查看简历');
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.center_focus_strong,
                  size: 35,
                ),
                onPressed: () {
                  _channel.invokeListMethod('moveToCenter');
                },
              )
            ],
          ),
          SizedBox(height: 16),
          _userInfoCard(),
          SizedBox(height: 10),
          _interviewInfoCard(),
        ],
      ),
    );
  }

  Widget _userInfoCard() {
    return Container(
      height: 136,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            offset: Offset(0, 1),
            blurRadius: 17,
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          SizedBox(height: 10),
          Row(
            children: <Widget>[
              SizedBox(width: 12),
              Container(
                height: 70,
                width: 70,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.network(
                    'http://cc.cocimg.com/api/uploads/190904/ed8a03f1135e71b1cf92624f330ecfbd.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  normalText('王晓燕  17729770987', Color(0xff020202), 14,
                      FontWeight.w500),
                  SizedBox(height: 4),
                  normalText(
                      '提交时间  13:23:56', Color(0xff4a4c5a), 14, FontWeight.w400),
                  SizedBox(height: 4),
                  normalText(
                      '已等待  1小时35分钟', Color(0xff4a4c5a), 14, FontWeight.w400),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            height: 1,
            color: Color(0xffdadada),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: normalImageTextButton(Icons.message, '发消息', () {
                    print('send msg');
                  }),
                ),
                Container(
                  width: 1,
                  color: Color(0xffdadada),
                ),
                Expanded(
                  flex: 1,
                  child: normalImageTextButton(Icons.call, '打电话', () {
                    print('call');
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _interviewInfoCard() {
    return Container(
        height: 125,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.13),
              offset: Offset(0, -5),
              blurRadius: 23,
            ),
          ],
        ),
        padding: EdgeInsets.fromLTRB(12, 12, 12, 10),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                normalText('面试地点', Color(0xff232323), 13, FontWeight.w500),
                SizedBox(width: 10),
                normalText('源深体育中心', Color(0xffea4c56), 13, FontWeight.w500,
                    textDecoration: TextDecoration.underline),
                SizedBox(width: 5),
                Icon(Icons.location_on, size: 12, color: Color(0xffea4c56)),
                Expanded(child: Container()),
                GestureDetector(
                  child: Container(
                    child: normalText(
                        '修改', Color(0xffea4c56), 10, FontWeight.w500),
                  ),
                  onTap: () {
                    print('alter address');
                  },
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: <Widget>[
                normalText('面试地点  2019-01-11  13:23', Color(0xff232323), 13, FontWeight.w500),
                Expanded(child: Container()),
                GestureDetector(
                  child: Container(
                    child: normalText(
                        '修改', Color(0xffea4c56), 10, FontWeight.w500),
                  ),
                  onTap: () {
                    print('alter date');
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: normalRoundRectButton(normalText('取消面试', Color(0xff4a4c5a), 17, FontWeight.w400), 44, 0, Color(0xffe3e3e3), 5, (){
                    print('cancel');
                  }),
                ),
                SizedBox(width: 12),
                Expanded(
                  flex: 1,
                  child: normalRoundRectButton(normalText('我已出发', Colors.white, 17, FontWeight.w400), 44, 0, Color(0xffea4c56), 5, (){
                    print('operation');
                  }),
                ),
              ],
            )
          ],
        ));
  }
}
