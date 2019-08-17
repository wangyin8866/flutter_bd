import 'package:flutter/material.dart';

class JobRequireDialog extends StatefulWidget {
  final Function(int gender, int school, int minAge, int maxAge) onConfirmTap;

  JobRequireDialog(this.onConfirmTap);

  @override
  JobRequireDialogState createState() =>
      new JobRequireDialogState(onConfirmTap);
}

enum JobRequireInfo { gender, school }

class JobRequireDialogState extends State<JobRequireDialog> {
  final Function(int gender, int school, int minAge, int maxAge) onConfirmTap;
  var _iGender = -1;
  var _iSchool = -1;
  var _defaultMinAge = 16;
  var _defaultMaxAge = 100;

  RangeValues _ageValues = const RangeValues(16.0, 100.0);

  JobRequireDialogState(this.onConfirmTap);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 11, top: 10),
            child: Text(
              '性别要求',
              style: TextStyle(color: Color(0xFF2B2B2B), fontSize: 13),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 11, top: 5),
            child: Row(
              children: <Widget>[
                _createChoiceChip(
                    '男女不限', _iGender, 0, JobRequireInfo.gender, 12),
                SizedBox(
                  width: 17,
                ),
                _createChoiceChip('男', _iGender, 1, JobRequireInfo.gender, 30),
                SizedBox(
                  width: 17,
                ),
                _createChoiceChip('女', _iGender, 2, JobRequireInfo.gender, 30)
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 11, top: 10),
            child: Text(
              '学历要求',
              style: TextStyle(color: Color(0xFF2B2B2B), fontSize: 13),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 11, top: 5),
            child: Wrap(
              children: <Widget>[
                _createChoiceChip(
                    '学历不限', _iSchool, 0, JobRequireInfo.school, 12),
                SizedBox(
                  width: 17,
                ),
                _createChoiceChip(
                    '小学及以上', _iSchool, 1, JobRequireInfo.school, 6),
                SizedBox(
                  width: 17,
                ),
                _createChoiceChip(
                    '初中及以上', _iSchool, 2, JobRequireInfo.school, 6),
                SizedBox(
                  width: 17,
                ),
                _createChoiceChip(
                    '高中及以上', _iSchool, 3, JobRequireInfo.school, 6),
                _createChoiceChip(
                    '大专及以上', _iSchool, 4, JobRequireInfo.school, 6),
                SizedBox(
                  width: 17,
                ),
                _createChoiceChip(
                    '本科及以上', _iSchool, 5, JobRequireInfo.school, 6),
                SizedBox(
                  width: 17,
                ),
                _createChoiceChip(
                    '硕士及以上', _iSchool, 6, JobRequireInfo.school, 6),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 11, top: 10),
            child: Row(
              children: <Widget>[
                Text(
                  '年龄要求',
                  style: TextStyle(color: Color(0xFF2B2B2B), fontSize: 13),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  _wapperAgeRange(_defaultMinAge, _defaultMaxAge),
                  style: TextStyle(color: Color(0xFFEA4C56), fontSize: 13),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 11, top: 15),
            child: Row(
              children: <Widget>[
                Text(
                  '16岁',
                  style: TextStyle(color: Color(0xFF2B2B2B), fontSize: 8),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '100岁',
                      style: TextStyle(color: Color(0xFF2B2B2B), fontSize: 8),
                    ),
                  ),
                  flex: 1,
                )
              ],
            ),
          ),
          SliderTheme(
              data: SliderTheme.of(context).copyWith(
                inactiveTrackColor: Color(0xFFF3F3F3),
                activeTrackColor: Color(0xFFEA4C56),
                thumbColor: Color(0xFFEADDDD),
                overlayColor: Colors.transparent
              ),
              child: RangeSlider(
                values: _ageValues,
                onChanged: (values) {
                  setState(() {
                    _ageValues = values;
                    _defaultMinAge = values.start.toInt();
                    _defaultMaxAge = values.end.toInt();
                  });
                },
                min: 16,
                max: 100,
              )),
          Padding(
            padding: EdgeInsets.only(left: 11, right: 11, top: 18, bottom: 12),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _iGender = -1;
                        _iSchool = -1;
                        _ageValues = const RangeValues(16.0, 100.0);
                        _defaultMinAge = _ageValues.start.toInt();
                        _defaultMaxAge = _ageValues.end.toInt();
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: Color(0xFFBCBCBC),
                              width: 0.5,
                              style: BorderStyle.solid)),
                      child: Text(
                        '重置',
                        style:
                        TextStyle(color: Color(0xFF626262), fontSize: 13),
                      ),
                    ),
                  ),
                  flex: 1,
                ),
                SizedBox(
                  width: 11,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (widget.onConfirmTap != null) {
                        widget.onConfirmTap(_iGender, _iSchool, _defaultMinAge, _defaultMaxAge);
                      }
                    },
                    child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Color(0xFFEA4C56),
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          '确定',
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        )),
                  ),
                  flex: 1,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _createChoiceChip(title, iSelected, selfTag, type, double horizontalPadding) {
    return ChoiceChip(
      label: Text(title),
      labelStyle: TextStyle(color: _getColor(iSelected, selfTag), fontSize: 12),
      selected: iSelected == selfTag,
      selectedColor: Color(0xFFFFC5C8),
      backgroundColor: Color(0xFFF3F3F3),
      onSelected: (value) {
        setState(() {
          switch (type) {
            case JobRequireInfo.gender:
              {
                if (iSelected == selfTag) {
                  _iGender = -1;
                } else {
                  _iGender = selfTag;
                }
              }
              break;
            case JobRequireInfo.school:
              {
                if (iSelected == selfTag) {
                  _iSchool = -1;
                } else {
                  _iSchool = selfTag;
                }
              }
              break;
          }
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      labelPadding: EdgeInsets.zero,
      padding:
          EdgeInsets.only(left: horizontalPadding, right: horizontalPadding),
    );
  }

  _getColor(iSelected, selfTag) {
    if (iSelected == selfTag) {
      return Color(0xFFEA4C56);
    } else {
      return Color(0xFF2B2B2B);
    }
  }

  _wapperAgeRange(minAge, maxAge) {
    var tempTips = '';

    if (minAge == 16 && maxAge == 100) {
      //默认不显示提示
      return tempTips;
    }

    if (minAge == 16) {
      tempTips = "$maxAge岁以下";
    }

    if (maxAge == 100) {
      tempTips = "$minAge岁以上";
    }

    if (minAge > 16 && maxAge < 100) {
      tempTips = "$minAge-$maxAge岁";
    }

    return tempTips;
  }
}
