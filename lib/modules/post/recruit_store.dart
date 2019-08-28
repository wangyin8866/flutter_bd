import 'package:flutter/material.dart';

class RecruitStorePage extends StatefulWidget {
  @override
  _RecruitStorePageState createState() => _RecruitStorePageState();
}

class _RecruitStorePageState extends State<RecruitStorePage> {
  List<String> _temp = ['', '', '', ''];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15, top: 9, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _addressWidget()[0],
          _addressWidget()[1],
          _addressWidget()[2],
          _addressWidget()[3],
          _moreStoreWidget()
        ],
      ),
    );
  }

  List<Widget> _addressWidget() {
    return _temp.map((_) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 18,
          ),
          Text(
            '鹿角巷（世纪大道店）',
            style: TextStyle(
                color: Color(0xFF292929),
                fontSize: 13,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 3,
          ),
          Row(
            children: <Widget>[
              Expanded(
                  child: Text(
                '上海市浦东新区浦东大道克里大厦B幢北楼2上海市浦东新区浦东大道克里大厦B幢北楼2',
                style: TextStyle(
                  color: Color(0xFF4D4F5E),
                  fontSize: 12,
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
          )
        ],
      );
    }).toList();
  }

  Widget _moreStoreWidget() {
    return Padding(
      padding: EdgeInsets.only(top: 12, bottom: 15),
      child: Text(
        '更多门店>',
        style: TextStyle(
          color: Color(0xFF4D4F5E),
          fontSize: 13,
        ),
      ),
    );
  }
}
