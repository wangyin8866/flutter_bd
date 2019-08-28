
import 'package:flutter_bd/model/example.dart';
import 'package:flutter_bd/model/userInfo.dart';
import 'package:flutter_bd/model/userLoginInfo.dart';

class BeanFactory {
  static wrapperBean<T>(json) {
    print('T--->${T.toString()}');
    switch (T.toString()) {
      case 'Example':
        return Example.fromJson(json);
      case 'UserLoginInfo':
        return UserLoginInfo.fromJson(json);
        case 'UserInfo':
        return UserInfo.fromJson(json);
      default:
        return null;
    }
  }
}