import 'package:flutter/material.dart';
import 'package:flutter_bd/config/config.dart';
import 'package:flutter_bd/model/userLoginInfo.dart';
import 'package:flutter_bd/modules/base/base_mvp.dart';
import 'package:flutter_bd/modules/base/base_state_page.dart';
import 'package:flutter_bd/modules/login/login_presenter.dart';
import 'package:flutter_bd/server/routes.dart';
import 'package:flutter_bd/tools/singleton.dart';
import 'package:flutter_bd/tools/storage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends BasePageState<LoginPage, LoginPresenter> {
  var _userName = '';
  var _password = '';
  var _click;

  @override
  void initState() {
    super.initState();

    _checkLogined();
  }

  _checkLogined() async {
    String token = await Storage.get(Config.TOKEN);
    if (token != null && token.length > 0) {
      Navigator.pushReplacementNamed(context, tabbarRoutesName);
    }
  }

  @override
  void showSuccess(BaseBean response) {
    if (response is UserLoginInfo) {
      SingletonManager().userLoginInfo = response;
      Storage.save(Config.TOKEN, SingletonManager().userLoginInfo.data.token);
      Navigator.pushReplacementNamed(context, tabbarRoutesName);
    }
  }

  _login() {
    mPresenter?.requestLogin<UserLoginInfo>(_userName, _password);
  }

  _checkValid() {
    var isValid = (_userName.length == 11) && (_password.length == 6);
    if (isValid) {
      _click = () {
        FocusScope.of(context).requestFocus(FocusNode());
        _login();
      };
    } else {
      _click = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        child: Stack(
          children: <Widget>[
            backgroundWidget(),
            mainWidget(),
          ],
        ),
      ),
    );
  }

  Widget backgroundWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.red,
            height: 350,
          ),
          Expanded(child: Container()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 38,
                width: 38,
                color: Colors.red,
              ),
              SizedBox(width: 8),
              Text(
                '有了你，熟仁直聘平台会更美好',
                style: TextStyle(
                  color: Color(0xffe7434c),
                  fontSize: 16,
                ),
              )
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget mainWidget() {
    return Align(
      alignment: Alignment(0.0, -0.3),
      child: Container(
        height: 416,
        width: 329,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.grey, offset: Offset(0, 1), blurRadius: 13),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(27),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 4),
              Text(
                '欢迎登录\n熟仁直聘BD工具',
                style: TextStyle(
                  color: Color(0xffe7434c),
                  fontSize: 29,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 43),
              TextField(
                keyboardType: TextInputType.number,
                cursorColor: Color(0xffe7434c),
                decoration: InputDecoration(
                  hintText: '请输入用户名',
                  hintStyle: TextStyle(
                    color: Color(0xffa6aab2),
                    fontSize: 14,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xffe7434c),
                    ),
                  ),
                ),
                onChanged: (value) {
                  _userName = value;
                  setState(() {
                    _checkValid();
                  });
                },
              ),
              SizedBox(height: 33),
              TextField(
                cursorColor: Color(0xffe7434c),
                obscureText: true,
                decoration: InputDecoration(
                  hintText: '请输入密码',
                  hintStyle: TextStyle(
                    color: Color(0xffa6aab2),
                    fontSize: 14,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xffe7434c),
                    ),
                  ),
                ),
                onChanged: (value) {
                  _password = value;
                  setState(() {
                    _checkValid();
                  });
                },
              ),
              SizedBox(height: 61),
              Container(
                height: 44,
                width: 274,
                child: RaisedButton(
                  color: Color(0xffe7434c),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Text(
                    '登录',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onPressed: _click,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  LoginPresenter createPresenter() {
    return LoginPresenter();
  }
}
