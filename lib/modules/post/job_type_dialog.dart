import 'package:flutter/material.dart';

class JobTypeDialog extends StatefulWidget {

  var _leftPosition = 0;
  var _rightPosition = 0;
  List<String> _leftList;
  List<String> _rightList;
  final Function(int leftSelect, int rightSelect) _onItemTap;

  JobTypeDialog(this._leftPosition, this._rightPosition, this._leftList,
      this._rightList, this._onItemTap);

  @override
  _JobTypeDialogState createState() => _JobTypeDialogState(this._leftPosition, this._rightPosition, this._leftList,
      this._rightList, this._onItemTap);

}

class _JobTypeDialogState extends State<JobTypeDialog> {

  var _leftPosition = 0;
  var _rightPosition = 0;
  List<String> _leftList;
  List<String> _rightList;
  final Function(int leftSelect, int rightSelect) _onItemTap;

  _JobTypeDialogState(this._leftPosition, this._rightPosition, this._leftList,
      this._rightList, this._onItemTap);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Expanded(child: _initListView(true), flex: 1,),
          Expanded(child: _initListView(false), flex: 1,)
        ],
      ),
    );
  }

  Widget _initListView(isLeft) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return _createitem(context, index, isLeft);
      },
      itemCount: 20,
    );
  }

  Widget _createitem(context, index, isLeft) {
    return GestureDetector(onTap: () {
      if (isLeft) {
        setState(() {
          _leftPosition = index;
        });
      } else {
        if (widget._onItemTap != null) {
          setState(() {
            _rightPosition = index;
          });
          widget._onItemTap(_leftPosition, index);
        }
      }
    }, child: Container(
      height: 38,
      width: double.infinity,
      color: _getBackgroundColor(index, isLeft),
      alignment: Alignment.centerLeft,
      child: Padding(padding: EdgeInsets.only(left: 12),
        child: Text(
          '热门岗位',
          style: TextStyle(color: _getColor(index, isLeft), fontSize: 14),),),
    ),);
  }

  _getBackgroundColor(index, isLeft) {
    if (isLeft) {
      return index == _leftPosition ? Colors.white : Color(0xFFF3F3F3);
    } else {
      return Colors.white;
    }
  }

  _getColor(index, isLeft) {
    if (isLeft) {
      return index == _leftPosition ? Color(0xFFEB545E) : Color(0xFF232323);
    } else {
      return index == _rightPosition ? Color(0xFFEB545E) : Color(0xFF232323);
    }
  }

}