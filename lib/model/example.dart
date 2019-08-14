


import 'package:flutter_bd/modules/base/base_mvp.dart';

class Example extends BaseBean {

  Data data = Data();

  Example.fromJson(Map<String, dynamic> json){
    code = json['code'] as int;
    msg = json['msg'] as String;
    if (json['data'] != null) {
      data = Data.fromJson(json['data']);
    }
  }

}


class Data {
  Data();

  String name = "";
  int level_status = 0;
  int work_age = 0;
  String header_url = "";
  int user_level = 0;
  String next_level_name;
  int percentage;
  int next_level_condition;

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String;
    level_status = json['level_status'] as int;
    work_age = json['work_age'] as int;
    header_url = json['header_url'] as String;
    user_level = json['user_level'] as int;
    next_level_name = json['next_level_name'] as String;
    percentage = json['percentage'] as int;
    next_level_condition = json['next_level_condition'] as int;
  }
}