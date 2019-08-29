
import 'package:flutter_bd/modules/base/base_mvp.dart';

/// @author : created by wyman
/// @date : 2019-08-28 15:35 
/// des :
class AccountBean extends BaseBean{
  Data data;

  AccountBean({this.data});

  AccountBean.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int adminId;
  String balance;

  Data({this.adminId, this.balance});

  Data.fromJson(Map<String, dynamic> json) {
    adminId = json['admin_id'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['admin_id'] = this.adminId;
    data['balance'] = this.balance;
    return data;
  }
}
