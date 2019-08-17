import 'package:flutter/material.dart';

class RecruitmentInfoDialog extends StatefulWidget {

  final Function(int one, int two, int three) onConfirmTap;

  RecruitmentInfoDialog(this.onConfirmTap);

  @override
  _RecruitmentInfoDialogState createState() =>
      new _RecruitmentInfoDialogState(onConfirmTap);
}

enum RecruitmentInfoType { recruiting, urgent, time }

class _RecruitmentInfoDialogState extends State<RecruitmentInfoDialog> {
  var _iRecruiting = -1;
  var _iUrgentRecruit = -1;
  var _iInterviewTime = -1;

  final Function(int one, int two, int three) onConfirmTap;

  _RecruitmentInfoDialogState(this.onConfirmTap);

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
              '是否在招',
              style: TextStyle(color: Color(0xFF2B2B2B), fontSize: 13),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 11, top: 5),
            child: Row(
              children: <Widget>[
                _createChoiceChip(
                    '在招', _iRecruiting, 0, RecruitmentInfoType.recruiting, 23),
                SizedBox(
                  width: 19,
                ),
                _createChoiceChip(
                    '停招', _iRecruiting, 1, RecruitmentInfoType.recruiting, 23)
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 11, top: 10),
            child: Text(
              '是否急招',
              style: TextStyle(color: Color(0xFF2B2B2B), fontSize: 13),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 11, top: 5),
            child: Row(
              children: <Widget>[
                _createChoiceChip(
                    '急招', _iUrgentRecruit, 0, RecruitmentInfoType.urgent, 23),
                SizedBox(
                  width: 19,
                ),
                _createChoiceChip(
                    '非急招', _iUrgentRecruit, 1, RecruitmentInfoType.urgent, 17)
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 11, top: 10),
            child: Text(
              '面试时间',
              style: TextStyle(color: Color(0xFF2B2B2B), fontSize: 13),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 11, top: 5),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              children: <Widget>[
                _createChoiceChip(
                    '周一', _iInterviewTime, 0, RecruitmentInfoType.time, 23),
                SizedBox(
                  width: 19,
                ),
                _createChoiceChip(
                    '周二', _iInterviewTime, 1, RecruitmentInfoType.time, 23),
                SizedBox(
                  width: 19,
                ),
                _createChoiceChip(
                    '周三', _iInterviewTime, 2, RecruitmentInfoType.time, 23),
                SizedBox(
                  width: 19,
                ),
                _createChoiceChip(
                    '周四', _iInterviewTime, 3, RecruitmentInfoType.time, 23),
                _createChoiceChip(
                    '周五', _iInterviewTime, 4, RecruitmentInfoType.time, 23),
                SizedBox(
                  width: 19,
                ),
                _createChoiceChip(
                    '周六', _iInterviewTime, 5, RecruitmentInfoType.time, 23),
                SizedBox(
                  width: 19,
                ),
                _createChoiceChip(
                    '周日', _iInterviewTime, 6, RecruitmentInfoType.time, 23),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 11, right: 11, top: 30, bottom: 12),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _iRecruiting = -1;
                        _iUrgentRecruit = -1;
                        _iInterviewTime = -1;
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
                        widget.onConfirmTap(_iRecruiting, _iUrgentRecruit, _iInterviewTime);
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
            case RecruitmentInfoType.recruiting:
              {
                if (iSelected == selfTag) {
                  _iRecruiting = -1;
                } else {
                  _iRecruiting = selfTag;
                }
              }
              break;
            case RecruitmentInfoType.urgent:
              {
                if (iSelected == selfTag) {
                  _iUrgentRecruit = -1;
                } else {
                  _iUrgentRecruit = selfTag;
                }
              }
              break;
            case RecruitmentInfoType.time:
              {
                if (iSelected == selfTag) {
                  _iInterviewTime = -1;
                } else {
                  _iInterviewTime = selfTag;
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
}
