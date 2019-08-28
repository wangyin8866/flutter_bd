import 'package:flutter/material.dart';
import 'package:flutter_bd/tools/singleton.dart';

class MemberPage extends StatefulWidget {
  MemberPage({Key key}) : super(key: key);

  _MemberPageState createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: this.getHeadrView(),
      body: SafeArea(
        child: ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: Stack(
            children: <Widget>[
              this.getSearchView(),
              this.getSelectView(),
              this.getListView(),
            ],
          ),
        ),
      ),
    );
  }

  /// 头部样式
  getHeadrView() {
    return AppBar(
      backgroundColor: Color(0xffea4c56),
      elevation: 0,
      actions: <Widget>[
        SizedBox(
          width: 15,
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Text('欢迎！${SingletonManager().userInfo.data.name}'),
        ),
        Expanded(
          child: Container(),
        ),
        Container(
          height: 20,
          width: 20,
          child: GestureDetector(
            onTap: () {
              print('点了小铃铛');
            },
            child: Icon(
              Icons.add_alert,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Container(
          height: 20,
          width: 20,
          child: GestureDetector(
            onTap: () {
              print('点了三维码');
            },
            child: Icon(
              Icons.nfc,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          width: 15,
        )
      ],
    );
  }

  /// 搜索输入条
  getSearchView() {
    return Container(
      padding: EdgeInsets.all(10),
      height: 55,
      color: Color(0xffea4c56),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.search,
              color: Color(0xff626262),
            ),
            Text(
              '搜索会员姓名或手机号',
              style: TextStyle(color: Color(0xff626262)),
            ),
          ],
        ),
      ),
    );
  }

  /// 筛选条
  getSelectView() {
    return Positioned(
      top: 55,
      left: 0,
      right: 0,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text('状态'),
              Icon(
                Icons.arrow_drop_down,
                size: 18,
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Text('招聘类型'),
              Icon(
                Icons.arrow_drop_down,
                size: 18,
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Text('更多筛选'),
              Icon(
                Icons.format_align_center,
                size: 14,
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 列表
  getListView() {
    return Positioned(
        top: 95,
        left: 0,
        right: 0,
        bottom: 0,
        child: Container(
          color: Color(0xffF1EEEE),
          child: ListView.builder(
            padding: EdgeInsets.all(10),
            itemCount: 50,
            itemBuilder: (context, index) {
              return this.getListCellView(index);
            },
          ),
        ));
  }

  /// 自定义cell
  getListCellView(int index) {
    return Container(
      padding: EdgeInsets.only(
        bottom: 10,
      ),
      child: Container(
        height: 158,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(3),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Text(
                          '吴凡' * 1 + ' ' + '186****5328' * 1,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Color(0xFF282828),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Image.network(
                          'https://www.baidu.com/img/bd_logo1.png?where=super',
                          fit: BoxFit.cover,
                          width: 44,
                          height: 15,
                          // color: Colors.red,
                        ),
                        Expanded(
                          child: Container(),
                        ),
                      ],
                    ),
                    flex: 1,
                  ),

                  // Expanded(
                  //   child: Container(),
                  // ),
                  SizedBox(
                    width: 10,
                  ),
                  Image.network(
                    'https://www.baidu.com/img/bd_logo1.png?where=super',
                    fit: BoxFit.cover,
                    width: 28,
                    height: 32,
                    // color: Colors.red,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Row(
                children: <Widget>[
                  Text(
                    '女 | 26岁',
                    style: TextStyle(
                      color: Color(0xFF4A4C5A),
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Image.network(
                    'https://www.baidu.com/img/bd_logo1.png?where=super',
                    fit: BoxFit.cover,
                    width: 37,
                    height: 13,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: Row(
                children: <Widget>[
                  Image.network(
                    'https://www.baidu.com/img/bd_logo1.png?where=super',
                    width: 8,
                    height: 9,
                    fit: BoxFit.cover,
                  ),
                  Expanded(
                    child: Text(
                      '上海-上海市-浦东新区·陆家嘴浦东哪路1271号',
                      style: TextStyle(
                        color: Color(0xFF4A4C5A),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 47,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 1,
                    color: Color(0xFFDADADA),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.message,
                                  size: 18,
                                  color: Color(0xFF4A4C5A),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '发消息',
                                  style: TextStyle(
                                    color: Color(0xFF4A4C5A),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 1,
                            color: Color(0xFFDADADA),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.call,
                                  size: 18,
                                  color: Color(0xFF4A4C5A),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '打电话',
                                  style: TextStyle(
                                    color: Color(0xFF4A4C5A),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
