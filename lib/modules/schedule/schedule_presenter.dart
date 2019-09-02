import 'dart:collection';

import 'package:flutter_bd/config/config.dart';
import 'package:flutter_bd/modules/base/base_presenter.dart';
import 'package:flutter_bd/net/constant.dart';

class SchedulePresenter extends BasePresenter {

  requestMonthList<T>(date) {
    var map = HashMap<String, Object>();
    map['date'] = date;

    invoke<T>(UrlPath.monthList, params: map, method: NetConstant.GET);
  }

}