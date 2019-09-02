import 'package:flutter/material.dart';

class InterviewInfoPage extends StatefulWidget {
  @override
  _InterviewInfoPageState createState() => _InterviewInfoPageState();
}

class _InterviewInfoPageState extends State<InterviewInfoPage> {
  double _screenWidth = 0;
  double _singleItemWidth = 0;
  List<String> _temp = ['', '', '', '', '', '', ''];

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _singleItemWidth = (_screenWidth - 30) / 2;
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15, top: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '面试时间',
            style: TextStyle(
                color: Color(0xFF4A4C5A),
                fontSize: 13,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 9,),
          Wrap(
            children: _createInterviewInfoWidget(),
          ),
          SizedBox(height: 20,),
          Text(
            '面试地点',
            style: TextStyle(
                color: Color(0xFF4A4C5A),
                fontSize: 13,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 9,),
          Row(
            children: <Widget>[
              Expanded(
                  child: Text(
                    '上海市浦东新区浦东大道克里大厦B幢北楼2上海市浦东新区浦东大道克里大厦B幢北楼2',
                    style: TextStyle(
                      color: Color(0xFF4D4F5E),
                      fontSize: 13,
                      decoration: TextDecoration.underline,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )),
              Container(
                height: 20,
                width: 20,
                color: Colors.green,
              )
            ],
          ),
          SizedBox(height: 29,),
          Text(
            '入职说明',
            style: TextStyle(
                color: Color(0xFF4A4C5A),
                fontSize: 13,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 9,),
          Text('入职周期说明\n入职周期分为3个阶段，均为6天，18个小时综合，综合特殊情况分配比例位置', style: TextStyle(color: Color(0xFF4A4C5B), fontSize: 13, height: 1.5),),
          SizedBox(height: 19,),
          Text('入职流程说明\n入职流程分为3个阶段，均为6天，18个小时综合，综合特殊情况分配比例位置', style: TextStyle(color: Color(0xFF4A4C5B), fontSize: 13, height: 1.5),),
          SizedBox(height: 20,),
        ],
      ),
    );
  }

  _createInterviewInfoWidget() {
     return _temp.map((_){
       return Container(
         width: _singleItemWidth,
         height: 20,
         alignment: Alignment.centerLeft,
         child: Text('周一 13:00-16:00', style: TextStyle(color: Color(0xFF4D4F5E), fontSize: 13),),
       );
     }).toList();
  }
}
