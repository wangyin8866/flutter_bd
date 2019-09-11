import 'package:flutter/material.dart';

class ScheduleDetailPage extends StatefulWidget {
  ScheduleDetailPage({Key key}) : super(key: key);

  _ScheduleDetailPageState createState() => _ScheduleDetailPageState();
}

class _ScheduleDetailPageState extends State<ScheduleDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text('日程详情'),
        backgroundColor: Color(0xffdf5151),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            backgroundWidget(),
            topWidget(),
          ],
        ),
      ),
    );
  }

  Widget backgroundWidget() {
    return Column(
      children: <Widget>[
        Container(
          height: 87,
          color: Color(0xffdf5151),
        ),
        SizedBox(height: 81),
        Row(
          children: <Widget>[
            SizedBox(width: 19),
            Container(
              color: Color(0xffdf5151),
              height: 18,
              width: 3,
            ),
            SizedBox(width: 8),
            Text(
              '2019-01-12  周一',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
        SizedBox(height: 12),
        Row(
          children: <Widget>[
            SizedBox(width: 19),
            Expanded(
              child: Container(
                color: Color(0xffe1e1e1),
                height: 1,
              ),
            ),
            SizedBox(width: 19),
          ],
        ),
        SizedBox(height: 13),
        Padding(
          padding: EdgeInsets.only(left: 19, right: 19),
          child: Text(
            '现在此人员家里有点事情，发生了突发情况所以需要找工作。',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xff030303),
            ),
          ),
        ),
      ],
    );
  }

  Widget topWidget() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(width: 8),
            Expanded(child: cardWidget()),
            SizedBox(width: 8),
          ],
        ),
        Expanded(child: Container()),
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Color(0xffea4c56).withOpacity(0.5),
                offset: Offset(0, 9),
                blurRadius: 17,
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            '已处理',
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
          ),
        ),
        SizedBox(height: 89),
      ],
    );
  }

  Widget cardWidget() {
    return Container(
      height: 132,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.15),
              offset: Offset(0, 1),
              blurRadius: 17),
        ],
      ),
      child: Column(
        children: <Widget>[
          SizedBox(height: 4),
          Row(
            children: <Widget>[
              SizedBox(width: 10),
              Padding(
                padding: EdgeInsets.only(top: 3),
                child: Container(
                  height: 74,
                  width: 74,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: FadeInImage.assetNetwork(
                      placeholder: '',
                      image:
                          'http://cc.cocimg.com/api/uploads/190819/ef2cb49e0fd3446eda605491a6c63a6e.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 19),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          '王晓燕',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          height: 15,
                          width: 44,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Color(0xffe7434c),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(11),
                                bottomRight: Radius.circular(11)),
                          ),
                          child: Text(
                            '待确认',
                            style: TextStyle(
                              fontSize: 9,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2),
                    Text(
                      '17789239348',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff020202),
                      ),
                    ),
                    SizedBox(height: 7),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.room,
                          size: 12,
                          color: Color(0xffa2a6ae),
                        ),
                        SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            '上海-上海市-浦东新区·陆家嘴浦东南路' * 2,
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xff4c4e5b),
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    height: 27,
                    width: 27,
                    padding: EdgeInsets.only(left: 4),
                    color: Color(0xffffc5c8),
                    alignment: Alignment.center,
                    child: Text(
                      '跟踪招聘',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffea4c56),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '>',
                    style: TextStyle(
                      fontSize: 30,
                      color: Color(0xff717171),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 11),
            ],
          ),
          SizedBox(height: 14),
          Row(
            children: <Widget>[
              SizedBox(width: 3),
              Expanded(
                child: Container(
                  height: 1,
                  color: Color(0xffdadada),
                ),
              ),
              SizedBox(width: 3),
            ],
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                imageWordBtn(Icons.message, '发消息', () {
                  print('msg');
                }),
                Container(
                  width: 1,
                  color: Color(0xffdadada),
                ),
                imageWordBtn(Icons.call, '打电话', () {
                  print('call');
                }),
                Container(
                  width: 1,
                  color: Color(0xffdadada),
                ),
                imageWordBtn(Icons.note_add, '新建备注', () {
                  print('mark');
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget imageWordBtn(IconData icon, String title, Function action) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon),
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
        onTap: action,
      ),
    );
  }
}
