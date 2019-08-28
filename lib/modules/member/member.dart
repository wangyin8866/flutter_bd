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
          child: Text('欢迎！${SingletonManager().userInfo.name}'),
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
    /*return Container(
      padding: EdgeInsets.all(10),
      height: 55,
      color: Color(0xffea4c56),
      child: TextField(
        keyboardType: TextInputType.text,
        obscureText: false,
        cursorColor: Colors.red,
        cursorWidth: 2,
        cursorRadius: Radius.circular(1),
        autofocus: true,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: '搜索会员姓名或手机号',
          hintStyle: TextStyle(color: Color(0xffa6aab2), fontSize: 14),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFFFFF),
            ),
          ),
        ),
        onChanged: (tx) {
          print('内容改变：$tx');
        },
        onSubmitted: (tx){
          print('内容提交：$tx');
        },
      ),
    );
    */
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
              Icon(Icons.arrow_drop_down),
            ],
          ),
          Row(
            children: <Widget>[
              Text('招聘类型'),
              Icon(Icons.arrow_drop_down),
            ],
          ),
          Row(
            children: <Widget>[
              Text('更多筛选'),
              Icon(Icons.arrow_drop_down),
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
          children: <Widget>[
            Container(
              height: 55,
              color: Colors.yellow,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      children: <Widget>[
                        Text(
                            '吴凡 18697715328' * 1,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        Image.network(
                          'https://www.baidu.com/img/bd_logo1.png?where=super',
                          fit: BoxFit.cover,
                          width: 44,
                          height: 15,
                          // color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 10),
                    child: Image.network(
                      'https://www.baidu.com/img/bd_logo1.png?where=super',
                      fit: BoxFit.cover,
                      width: 28,
                      height: 32,
                      // color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
