import 'dart:collection';

import 'package:flutter_bd/config/config.dart';
import 'package:flutter_bd/modules/base/base_presenter.dart';
import 'package:flutter_bd/net/constant.dart';

class PostPresenter extends BasePresenter {
  requestLogin<T>(mobile, password) {
    var map = HashMap<String, Object>();
    map['mobile'] = mobile;
    map['password'] = password;
    map['client_type'] = 2;

    invoke<T>(UrlPath.login, params: map, method: NetConstant.POST);
  }
}