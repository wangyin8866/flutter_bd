import 'package:flutter/material.dart';
import 'package:flutter_bd/modules/login/user.dart';
import 'package:flutter_bd/tools/singleton.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class loginPage extends StatefulWidget {
  loginPage({Key key}) : super(key: key);

  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {

  var _userName = '18697715328';
  var _password = '123456';

  _login() async {
    var url =
        'http://onsite-api.ci.dev.lanxinka.com/1.0/admin/manager/login?client_type=2&mobile=$_userName&password=$_password';
    var response = await http.post(url);
    if (response.statusCode == 200) {
      var jsonStr = convert.Utf8Decoder().convert(response.bodyBytes);
      var json = convert.jsonDecode(jsonStr);
      print(json);
      if (json['code'] == 0) {
        singletonManager().user = User.fromJson(json['data']);
        Navigator.pushReplacementNamed(context, '/tabbar');
      } else {
        print(json['msg']);
      }
    } else {
      print('status code is ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
       child: RaisedButton(
         child: Text('login'),
         onPressed: () {
           _login();
         },
       )
      )
    );
  }
}