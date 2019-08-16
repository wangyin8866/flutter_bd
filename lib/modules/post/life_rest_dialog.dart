import 'package:flutter/material.dart';

class LifeRestDialog extends StatefulWidget {
  final Function(int one, int two, int three) onConfirmTap;

  LifeRestDialog(this.onConfirmTap);

  @override
  LifeRestDialogState createState() => new LifeRestDialogState(onConfirmTap);
}

enum LifeRestType { life, work, reset }

class LifeRestDialogState extends State<LifeRestDialog> {
  final Function(int one, int two, int three) onConfirmTap;
  var _iLife = -1;
  var _iWork = -1;
  var _iRest = -1;

  LifeRestDialogState(this.onConfirmTap);

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
              '吃住情况',
              style: TextStyle(color: Color(0xFF2B2B2B), fontSize: 13),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 11, top: 5),
            child: Wrap(
              children: <Widget>[
                _createChoiceChip('包吃包住', _iLife, 0, LifeRestType.life, 12),
                SizedBox(
                  width: 17,
                ),
                _createChoiceChip('包吃', _iLife, 1, LifeRestType.life, 24),
                SizedBox(
                  width: 17,
                ),
                _createChoiceChip('包住', _iLife, 2, LifeRestType.life, 24),
                SizedBox(
                  width: 17,
                ),
                _createChoiceChip('不包吃住', _iLife, 3, LifeRestType.life, 12),
                _createChoiceChip('吃住看门店', _iLife, 4, LifeRestType.life, 6)
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 11, top: 10),
            child: Text(
              '倒班情况',
              style: TextStyle(color: Color(0xFF2B2B2B), fontSize: 13),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 11, top: 5),
            child: Wrap(
              children: <Widget>[
                _createChoiceChip('长白班', _iWork, 0, LifeRestType.work, 18),
                SizedBox(
                  width: 17,
                ),
                _createChoiceChip('长夜班', _iWork, 1, LifeRestType.work, 18),
                SizedBox(
                  width: 17,
                ),
                _createChoiceChip('两班倒', _iWork, 2, LifeRestType.work, 18),
                SizedBox(
                  width: 17,
                ),
                _createChoiceChip('三班倒', _iWork, 3, LifeRestType.work, 18),
                _createChoiceChip('倒班看门店', _iWork, 4, LifeRestType.work, 6)
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 11, top: 10),
            child: Text(
              '作息情况',
              style: TextStyle(color: Color(0xFF2B2B2B), fontSize: 13),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 11, top: 5),
            child: Wrap(
              children: <Widget>[
                _createChoiceChip('周末双休', _iRest, 0, LifeRestType.work, 12),
                SizedBox(
                  width: 17,
                ),
                _createChoiceChip('月休一天', _iRest, 1, LifeRestType.work, 12),
                SizedBox(
                  width: 17,
                ),
                _createChoiceChip('月休两天', _iRest, 2, LifeRestType.work, 12),
                SizedBox(
                  width: 17,
                ),
                _createChoiceChip('做六休一', _iRest, 3, LifeRestType.work, 12),
                _createChoiceChip('作息看门店', _iRest, 4, LifeRestType.work, 6)
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 11, right: 11, top: 10, bottom: 12),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _iLife = -1;
                        _iWork = -1;
                        _iRest = -1;
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
                        widget.onConfirmTap(_iLife, _iWork, _iRest);
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
            case LifeRestType.life:
              {
                if (iSelected == selfTag) {
                  _iLife = -1;
                } else {
                  _iLife = selfTag;
                }
              }
              break;
            case LifeRestType.work:
              {
                if (iSelected == selfTag) {
                  _iWork = -1;
                } else {
                  _iWork = selfTag;
                }
              }
              break;
            case LifeRestType.reset:
              {
                if (iSelected == selfTag) {
                  _iRest = -1;
                } else {
                  _iRest = selfTag;
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
