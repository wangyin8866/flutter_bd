import 'package:flutter/material.dart';
import 'package:flutter_bd/tools/singleton.dart';

class SchedulePage extends StatefulWidget {
  SchedulePage({Key key}) : super(key: key);

  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  String _newValue = '全部';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff1eeee),
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        centerTitle: true,
        brightness: Brightness.light,
        title: Text(
          '日程',
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.access_alarm, color: Colors.black),
            onPressed: () {
              print('msg click');
            },
          ),
          IconButton(
            icon: Icon(Icons.nfc, color: Colors.black),
            onPressed: () {
              print('qr click');
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 271,
            color: Colors.white,
            child: Center(
              child: Text('日历---$_newValue'),
            ),
          ),
          SizedBox(height: 1),
          Container(
            height: 59,
            color: Colors.white,
            child: radioWidget(),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.fromLTRB(8, 11, 10, 12),
              itemCount: 9,
              itemBuilder: (context, index) {
                return scheduleCell(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget scheduleCell(int index) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(2, 2, 0, 0),
          child: Column(
            children: <Widget>[
              Container(
                height: 95,
                padding: EdgeInsets.fromLTRB(15, 13, 15, 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '其妙  186****5678',
                          style: TextStyle(
                            color: Color(0xff282828),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          width: 44,
                          height: 14,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Color(0xff4bc339), width: 1),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                            ),
                          ),
                          child: Text(
                            '入职跟进',
                            style: TextStyle(
                              color: Color(0xff58b44a),
                              fontSize: 8,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Text(
                      '备注：该会员预约了明天面试该会员预约了明天面试该会员预约了明天面试',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Color(0xff282828),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
        circleWidget(Color(0xfffe9614)),
      ],
    );
  }

  Widget circleWidget(Color color) {
    return Container(
      height: 15,
      width: 15,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7.5),
      ),
      child: Container(
        height: 13,
        width: 13,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6.5),
        ),
      ),
    );
  }

  Widget radioWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _radioBox('全部'),
        _radioBox('面试跟进'),
        _radioBox('入职跟进'),
        _radioBox('在职维护'),
      ],
    );
  }

  _radioBox(String title) {
    return Expanded(
      flex: title.length == 2 ? 4 : 5,
      child: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment(0.3, 0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: Color(0xff030303),
              ),
            ),
          ),
          Container(
            alignment: Alignment(-1, 0),
            child: Radio<String>(
              value: title,
              groupValue: _newValue,
              activeColor: Color(0xffea4c56),
              onChanged: (value) {
                setState(() {
                  _newValue = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
