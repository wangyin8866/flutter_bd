import 'dart:ui' as prefix0;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bd/modules/base/base_state_page.dart';
import 'package:flutter_bd/modules/post/interview_info.dart';
import 'package:flutter_bd/modules/post/job_requirements.dart';
import 'package:flutter_bd/modules/post/job_statement.dart';
import 'package:flutter_bd/modules/post/post_detail_presenter.dart';
import 'package:flutter_bd/modules/post/recruit_store.dart';
import 'package:flutter_bd/modules/post/work_info.dart';
import 'package:flutter_bd/widget/round_indicator.dart';

class PostDetailPage extends StatefulWidget {
  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState
    extends BasePageState<PostDetailPage, PostDetailPresenter>
    with SingleTickerProviderStateMixin {
  String title = '奶茶店营业员';
  bool isShowTitle = false;
  List<String> _tabTitle = ['岗位要求', '岗位职责', '在招门店', '面试信息']; //tab集合
  TabController controller; //tab控制器
  final ScrollController _scrollController = ScrollController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: _tabTitle.length, vsync: this);

    _scrollController.addListener(() {
      setState(() {
        if (_scrollController.offset > 100) {
          isShowTitle = true;
        } else {
          isShowTitle = false;
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 300)).then((_){
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            pinned: true,
            expandedHeight: 140,
            leading: _createLeading(),
            actions: _createActions(),
            flexibleSpace: _createFlexible(),
          ),
          SliverToBoxAdapter(
            child: _createJobWelfare(),
          ),
          SliverToBoxAdapter(
            child: _createUserInfo(),
          ),
          SliverToBoxAdapter(
            child: _createTabbar(),
          ),
          SliverToBoxAdapter(
            child: _createLine(),
          ),
          SliverToBoxAdapter(
            child: _createTypeView(),
          ),
          SliverToBoxAdapter(
            child: WorkInfoPage(),
          )
//          SliverFillRemaining(
//            child: _createTabView(),
//          )
        ],
      )),
    );
  }

  _createLeading() {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
    );
  }

  _createActions() {
    return [
      IconButton(
        icon: Icon(
          Icons.share,
          color: Colors.black,
        ),
        onPressed: () {},
      )
    ];
  }

  _createFlexible() {
    return FlexibleSpaceBar(
      title: Text(
        title,
        style: TextStyle(
            color: isShowTitle ? Color(0xFF232323) : Colors.transparent),
      ),
      background: Container(
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              left: 16,
              top: 65,
            ),
            Positioned(
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 126,
                      child: Text(
                        title,
                        style:
                            TextStyle(color: Color(0xFF4A4C5B), fontSize: 21),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      height: 14,
                      width: 36,
                      color: Colors.green,
                    ),
                  ],
                ),
                left: 85,
                top: 65),
            Positioned(
              child: Text('2月3号发布',
                  style: TextStyle(color: Color(0xFFA7A7A7), fontSize: 12)),
              right: 15,
              top: 70,
            ),
            Positioned(
              child: Row(
                children: <Widget>[
                  Text('6500～8000',
                      style: TextStyle(color: Color(0xFFEA4C56), fontSize: 21)),
                  Text('元/月',
                      style: TextStyle(color: Color(0xFFEA4C56), fontSize: 12))
                ],
              ),
              left: 85,
              top: 95,
            ),
            Positioned(
              child: Text('招3人·候选5人\n复试通过3人',
                  style: TextStyle(color: Color(0xFF4A4C5B), fontSize: 12)),
              right: 15,
              top: 100,
            )
          ],
        ),
      ),
    );
  }

  _createJobWelfare() {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 15,
        ),
        _createWelfareSub('包吃', ''),
        SizedBox(
          width: 67,
        ),
        _createWelfareSub('月休两天', ''),
        SizedBox(
          width: 67,
        ),
        _createWelfareSub('长白班', ''),
      ],
    );
  }

  _createWelfareSub(title, resID) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 8,
        ),
        Container(
          width: 20,
          height: 20,
          color: Colors.green,
        ),
        SizedBox(
          height: 8,
        ),
        Text(title, style: TextStyle(color: Color(0xFF4A4C5B), fontSize: 12))
      ],
    );
  }

  _createUserInfo() {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15, top: 29, bottom: 26),
      child: GestureDetector(
        child: Container(
          height: 69,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 247, 247, 247),
              borderRadius: BorderRadius.circular(3)),
          child: Stack(
            children: <Widget>[
              Positioned(
                child: Container(
                  height: 49,
                  width: 49,
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFA7A7A7)),
                      borderRadius: BorderRadius.circular(25)),
                ),
                left: 14,
                top: 10,
              ),
              Positioned(
                child: Row(
                  children: <Widget>[
                    Text(
                      '王千月',
                      style: TextStyle(
                          color: Color(0xFF333333),
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Container(
                      width: 50,
                      height: 12,
                      color: Colors.green,
                    )
                  ],
                ),
                left: 78,
                top: 12,
              ),
              Positioned(
                child: Text(
                  '13728398745',
                  style: TextStyle(color: Color(0xFF333333), fontSize: 16),
                ),
                left: 78,
                bottom: 9,
              ),
              Positioned(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 76,
                    height: 29,
                    decoration: BoxDecoration(
                      color: Color(0xFFEA4C56),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.phone,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          '联系他',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        )
                      ],
                    ),
                  ),
                ),
                right: 26,
                top: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  _createTabbar() {
    return DefaultTabController(
      length: _tabTitle.length,
      child: TabBar(
        controller: controller,
        labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        labelColor: Color(0xFF292929),
        indicatorColor: Color(0xFFEA4C56),
        indicatorWeight: 4,
        labelPadding: EdgeInsets.only(bottom: 7),
        indicatorSize: TabBarIndicatorSize.label,
        unselectedLabelStyle: TextStyle(fontSize: 14),
        indicator: RoundUnderLineTabIndicator(
          borderSide: BorderSide(width: 4.0, color: Colors.red),
        ),
        tabs: _tabTitle.map((title) {
          return Text(title);
        }).toList(),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  _createLine() {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Color(0xFFDCDCDC),
      ),
    );
  }

  _createTypeView() {
    switch (_currentIndex) {
      case 0:
        return JobRequirementsPage();
      case 1:
        return JobStatementPage();
        break;
      case 2:
        return RecruitStorePage();
        break;
      case 3:
        return InterviewInfoPage();
        break;
    }
  }

//  _createTabView() {
//    return TabBarView(
//      controller: controller,
//      children: <Widget>[
//        JobRequirementsPage(),
//        JobStatementPage(),
//        RecruitStorePage(),
//        InterviewInfoPage(),
//      ],
//    );
//  }

  @override
  PostDetailPresenter createPresenter() {
    return PostDetailPresenter();
  }
}
