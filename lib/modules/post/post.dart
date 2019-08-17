import 'package:flutter/material.dart';
import 'package:flutter_bd/model/example.dart';
import 'package:flutter_bd/modules/base/base_mvp.dart';
import 'package:flutter_bd/modules/post/PostPresenter.dart';
import 'package:flutter_bd/modules/base/base_state_page.dart';
import 'package:flutter_bd/modules/post/item.dart';
import 'package:flutter_bd/modules/post/job_require_dialog.dart';
import 'package:flutter_bd/modules/post/job_type_dialog.dart';
import 'package:flutter_bd/modules/post/life_rest_dialog.dart';
import 'package:flutter_bd/modules/post/recruitment_info_dialog.dart';
import 'package:flutter_bd/widget/dropdowm/gzx_dropdown_global.dart';

class PostPage extends StatefulWidget {
  PostPage({Key key}) : super(key: key);

  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends BasePageState<PostPage, PostPresenter> {
  GZXDropdownMenuController _dropdownMenuController =
      GZXDropdownMenuController();
  GZXDropdownMenuController _controller = GZXDropdownMenuController();
  GlobalKey _stackKey = GlobalKey();
  var _jobTypeLeftPosition = 0;
  var _jobTypeRightPosition = 0;
  var _circleLeftPosition = 0;
  var _circleRightPosition = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1EEEE),
      appBar: AppBar(
        actions: _createActionList(),
      ),
      body: SafeArea(
        child: Stack(
          key: _stackKey,
          children: <Widget>[
            Column(
              children: <Widget>[
                _selectViews(),
                _lineViewWithDropDown(),
                Expanded(
                  child: _initListView(),
                  flex: 1,
                )
              ],
            ),
            _dropDownDialog(),
            _dropDownCircleDialog(),
          ],
        ),
      ),
    );
  }

  _dropDownDialog() {
    return GZXDropDownMenu(
        controller: _dropdownMenuController,
        animationMilliseconds: 0,
        menus: [
          GZXDropdownMenuBuilder(
              dropDownWidget: JobTypeDialog(
                  _jobTypeLeftPosition, _jobTypeRightPosition, null, null,
                  (leftSelect, rightSelect) {
                _jobTypeLeftPosition = leftSelect;
                _jobTypeRightPosition = rightSelect;
                _dropdownMenuController.hide();
              }),
              dropDownHeight: 412),
          GZXDropdownMenuBuilder(
              dropDownWidget: RecruitmentInfoDialog((one, two, three) {
                _dropdownMenuController.hide();
              }),
              dropDownHeight: 370),
          GZXDropdownMenuBuilder(
              dropDownWidget: LifeRestDialog((one, two, three) {
                _dropdownMenuController.hide();
              }),
              dropDownHeight: 440),
          GZXDropdownMenuBuilder(
              dropDownWidget: JobRequireDialog((gender, school, minAge, maxAge) {
                _dropdownMenuController.hide();
              }),
              dropDownHeight: 380)
        ]);
  }

  _dropDownCircleDialog() {
    return GZXDropDownMenu(
        controller: _controller,
        animationMilliseconds: 0,
        menus: [
          GZXDropdownMenuBuilder(
              dropDownWidget: JobTypeDialog(
                  _circleLeftPosition, _circleRightPosition, null, null,
                  (leftSelect, rightSelect) {
                _circleLeftPosition = leftSelect;
                _circleRightPosition = rightSelect;
                _controller.hide();
              }),
              dropDownHeight: 412),
        ]);
  }

  _createActionList() {
    return [
      Padding(
        padding: EdgeInsets.only(left: 3),
        child: GestureDetector(
          onTap: () {
            if (!_controller.isShow) {
              _controller.show(0);
            }
          },
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
        padding: EdgeInsets.only(left: 5),
        child: GZXDropDownHeader(
          stackKey: _stackKey,
          items: [
            GZXDropDownHeaderItem('岗位类型', iconData: Icons.arrow_drop_down),
            GZXDropDownHeaderItem('招聘信息', iconData: Icons.arrow_drop_down),
            GZXDropDownHeaderItem('吃住信息', iconData: Icons.arrow_drop_down),
            GZXDropDownHeaderItem('岗位信息', iconData: Icons.arrow_drop_down)
          ],
          controller: _dropdownMenuController,
          dividerHeight: 0,
          borderWidth: 0,
          color: Colors.transparent,
          style: TextStyle(color: Colors.black, fontSize: 14),
          dropDownStyle: TextStyle(color: Color(0xFFEB545E), fontSize: 14),
        ),
      ),
    );
  }

  Widget _lineViewWithDropDown() {
    return GZXDropDownHeader(
      stackKey: _stackKey,
      items: [GZXDropDownHeaderItem('')],
      controller: _controller,
      dividerHeight: 0,
      borderWidth: 0,
      height: 1,
      color: Colors.transparent,
      style: TextStyle(color: Colors.black, fontSize: 14),
      dropDownStyle: TextStyle(color: Color(0xFFEB545E), fontSize: 14),
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
