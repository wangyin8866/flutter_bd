import 'package:flutter/material.dart';
import 'package:flutter_bd/model/example.dart';
import 'package:flutter_bd/modules/base/base_mvp.dart';
import 'package:flutter_bd/modules/post/PostPresenter.dart';
import 'package:flutter_bd/modules/base/base_state_page.dart';
import 'package:flutter_bd/modules/post/item.dart';

class PostPage extends StatefulWidget {
  PostPage({Key key}) : super(key: key);

  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends BasePageState<PostPage, PostPresenter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1EEEE),
      appBar: AppBar(
        actions: _createActionList(),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _selectViews(),
            SizedBox(
              width: double.infinity,
              height: 1,
            ),
            Expanded(
              child: _initListView(),
              flex: 1,
            )
          ],
        ),
      ),
    );
  }

  _createActionList() {
    return [
      Padding(
        padding: EdgeInsets.only(left: 3),
        child: GestureDetector(
          onTap: () {},
          child: Container(
            width: 85,
            height: double.infinity,
            alignment: Alignment.centerLeft,
            child: Text(
              '冰河世纪的啦的',
              style: TextStyle(color: Colors.white, fontSize: 13),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
      _searchBox(),
      GestureDetector(
        onTap: () {},
        child: Padding(
            padding: EdgeInsets.only(left: 12, right: 8),
            child: Icon(Icons.info)),
      ),
      GestureDetector(
        onTap: () {},
        child: Padding(
            padding: EdgeInsets.only(left: 8, right: 8),
            child: Icon(Icons.info)),
      )
    ];
  }

  Widget _searchBox() {
    return Padding(
      padding: EdgeInsets.only(left: 0, top: 10, right: 0, bottom: 10),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          height: 30,
          width: 186,
          decoration: BoxDecoration(
              color: Color(0xFFF7F7F7),
              borderRadius: BorderRadius.circular(5.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '搜索岗位名称或企业名称',
                style: TextStyle(color: Color(0xFF626262), fontSize: 13),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _selectViews() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(left: 0, right: 0, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: _selectView('岗位类型'),
              flex: 1,
            ),
            Expanded(
              child: _selectView('招聘信息'),
              flex: 1,
            ),
            Expanded(
              child: _selectView('吃住信息'),
              flex: 1,
            ),
            Expanded(
              child: _selectView('岗位信息'),
              flex: 1,
            )
          ],
        ),
      ),
    );
  }

  Widget _selectView(String type) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          type,
          style: TextStyle(color: Colors.black, fontSize: 14),
        )
      ],
    );
  }

  Widget _initListView() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return PostItem();
      },
      itemCount: 10,
    );
  }

  @override
  void showSuccess(BaseBean response) {
    if (response is Example) {}
  }

  @override
  PostPresenter createPresenter() {
    return PostPresenter();
  }
}
