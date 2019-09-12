import 'package:flutter/material.dart';
import 'package:flutter_bd/config/config.dart';
import 'package:flutter_bd/server/routes.dart';
import 'package:flutter_bd/tools/singleton.dart';
import 'package:flutter_bd/tools/storage.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

class SchedulePage extends StatefulWidget {
  SchedulePage({Key key}) : super(key: key);

  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  String _newValue = '全部';
  var _currentDate = DateTime.now();
  var _selectedDate = DateTime.now();
  var _changedDate = DateTime.now();

  EventList<Event> _markedDateMap = EventList<Event>(
    events: {
      DateTime(2019, 8, 6): [
        Event(
          date: DateTime(2019, 8, 6),
        ),
      ],
    },
  );

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
              Storage.remove(Config.TOKEN);
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
            child: Stack(
              children: <Widget>[
                Center(
                  child: Text(
                    _changedDate.month.toString(),
                    style: TextStyle(fontSize: 199, color: Color(0xfff4f4f4)),
                  ),
                ),
                calendarWidget(),
              ],
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

  Widget calendarWidget() {
    return CalendarCarousel(
      locale: 'ZH',
      daysHaveCircularBorder: true,
      todayButtonColor: Color(0x00ffffff),
      todayBorderColor: Color(0x00ffffff),
      todayTextStyle: TextStyle(color: Colors.black),
      weekDayFormat: WeekdayFormat.standaloneNarrow,
      weekdayTextStyle: TextStyle(color: Color(0xff717171)),
      onDayPressed: (DateTime date, _) {
        _selectedDate = date;
        print(_selectedDate);
        print(_currentDate);
        setState(() {
          _currentDate = date;
          _markedDateMap.removeAll(date);
          _markedDateMap.add(
              date,
              Event(
                date: date,
              ));
        });
      },
      markedDateWidget: Container(
        height: 5,
        width: 5,
        decoration: BoxDecoration(
          color: Color(0xfffe9614),
          borderRadius: BorderRadius.circular(2.5),
        ),
      ),
      thisMonthDayBorderColor: Color(0x00ffffff),
      selectedDayButtonColor: Color(0xffea4c56),
      selectedDayBorderColor: Color(0x00ffffff),
      height: 271.0,
      selectedDateTime: _currentDate,
      markedDatesMap: _markedDateMap,
      dayPadding: 0.0,
      showHeader: false,
      onCalendarChanged: (date) {
        setState(() {
          _changedDate = date;
        });
      },
    );
  }

  Widget scheduleCell(int index) {
    return GestureDetector(
      child: Stack(
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
                              border: Border.all(
                                  color: Color(0xff4bc339), width: 1),
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
      ),
      onTap: () {
        Navigator.pushNamed(context, scheduleDetailRoutesName);
      },
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
            alignment: Alignment(0.4, 0),
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
