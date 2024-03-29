import 'package:flutter/material.dart';
import 'package:flutter_bd/modules/member/member.dart';
import 'package:flutter_bd/modules/mine/mine.dart';
import 'package:flutter_bd/modules/order/order.dart';
import 'package:flutter_bd/modules/post/post.dart';
import 'package:flutter_bd/modules/schedule/schedule.dart';

class tabbarWidget extends StatefulWidget {
  tabbarWidget({Key key}) : super(key: key);

  _tabbarWidgetState createState() => _tabbarWidgetState();
}

class _tabbarWidgetState extends State<tabbarWidget> {

  int _currentIndex = 0;
  List _pageList = [
   orderPage(),
   memberPage(),
   schedulePage(),
   postPage(),
   minePage()
 ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageList[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        fixedColor: Colors.red,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            this._currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            title: Text('订单')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.beenhere),
            title: Text('会员')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.date_range),
            title: Text('日程')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            title: Text('岗位')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('我的')
          ),
        ],
      ),
    );
  }
}