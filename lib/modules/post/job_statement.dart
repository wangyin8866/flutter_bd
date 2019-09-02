import 'package:flutter/material.dart';

class JobStatementPage extends StatefulWidget {
  @override
  _JobStatementPageState createState() => _JobStatementPageState();
}

class _JobStatementPageState extends State<JobStatementPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 17,
          ),
          Text(
            '网红奶茶店营业员包吃住',
            style: TextStyle(color: Color(0xFF4A4C5A), fontSize: 13, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 9,
          ),
          Text(
            '1. 参与门店正常运营工作，饮品调制\n2. 厨房备料3.外送4.收银\n3. 服从门店管理者工作安排\n4. 第一个月试用期除了职能奖金没有，其他都有。',
            style:
                TextStyle(color: Color(0xFF4D4F5E), fontSize: 13, height: 1.5),
          ),
          SizedBox(
            height: 14,
          ),
          Text(
            '薪资待遇',
            style: TextStyle(color: Color(0xFF4A4C5A), fontSize: 13, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            '底薪3000元+房补1000元/月+全勤',
            style: TextStyle(color: Color(0xFF4D4F5E), fontSize: 13),
          ),
          SizedBox(
            height: 14,
          ),
          Text(
            '薪资组成说明',
            style: TextStyle(color: Color(0xFF4A4C5A), fontSize: 13, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            '薪资组成说明薪资组成说明',
            style: TextStyle(color: Color(0xFF4D4F5E), fontSize: 13),
          ),
          SizedBox(
            height: 14,
          ),
          Text(
            '社保公积金说明',
            style: TextStyle(color: Color(0xFF4A4C5A), fontSize: 13, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            '社保公积金说明社保公积金说明',
            style: TextStyle(color: Color(0xFF4D4F5E), fontSize: 13),
          ),
          SizedBox(
            height: 14,
          ),
          Text(
            '发薪日期',
            style: TextStyle(color: Color(0xFF4A4C5A), fontSize: 13, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            '每月5号',
            style: TextStyle(color: Color(0xFF4D4F5E), fontSize: 13),
          ),
          SizedBox(
            height: 14,
          ),
          Text(
            '晋升空间',
            style: TextStyle(color: Color(0xFF4A4C5A), fontSize: 13, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            '晋升空间晋升空间晋升空间晋升空间',
            style: TextStyle(color: Color(0xFF4D4F5E), fontSize: 13),
          ),
          SizedBox(
            height: 14,
          ),
          Text(
            '劳动关系归属乙方',
            style: TextStyle(color: Color(0xFF4A4C5A), fontSize: 13, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 14,
          ),
        ],
      ),
    );
  }
}
