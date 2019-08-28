import 'package:flutter_bd/modules/base/base_mvp.dart';

class UserInfo extends BaseBean {

  Data data;

  UserInfo.fromJson(Map<String, dynamic> json) {
    code = json['code'] as int;
    msg = json['msg'] as String;
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

}

class Data {

  Data();

  int id;
  String name;
  String mobile;
  String bdToken;
  String imUserId;
  String registerId;
  String imToken;
  String imPortrait;
  String lastLocationLon;
  String lastLocationLat;
  int isAdmin;
  int isBd;
  int isLocked;
  String wechat;
  String remark;
  String regionName;
  int regionId;
  String cityName;
  int cityId;
  int pid;
  int cityAdminId;
  int bdmAdminId;
  String createdAt;
  List<String> roleName;
  int level;
  List<String> districtList;
  String scheduleInfo;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    bdToken = json['bd_token'];
    imUserId = json['im_user_id'];
    registerId = json['register_id'];
    imToken = json['im_token'];
    imPortrait = json['im_portrait'];
    lastLocationLon = json['last_location_lon'];
    lastLocationLat = json['last_location_lat'];
    isAdmin = json['is_admin'];
    isBd = json['is_bd'];
    isLocked = json['is_locked'];
    wechat = json['wechat'];
    remark = json['remark'];
    regionName = json['region_name'];
    regionId = json['region_id'];
    cityName = json['city_name'];
    cityId = json['city_id'];
    pid = json['pid'];
    cityAdminId = json['city_admin_id'];
    bdmAdminId = json['bdm_admin_id'];
    createdAt = json['created_at'];
    if (json['role_name'] != null) {
      roleName = json['role_name'].cast<String>();
    }
    level = json['level'];
    if (json['district_list'] != null) {
      roleName = json['district_list'].cast<String>();
    }
    scheduleInfo = json['schedule_info'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['bd_token'] = this.bdToken;
    data['im_user_id'] = this.imUserId;
    data['register_id'] = this.registerId;
    data['im_token'] = this.imToken;
    data['im_portrait'] = this.imPortrait;
    data['last_location_lon'] = this.lastLocationLon;
    data['last_location_lat'] = this.lastLocationLat;
    data['is_admin'] = this.isAdmin;
    data['is_bd'] = this.isBd;
    data['is_locked'] = this.isLocked;
    data['wechat'] = this.wechat;
    data['remark'] = this.remark;
    data['region_name'] = this.regionName;
    data['region_id'] = this.regionId;
    data['city_name'] = this.cityName;
    data['city_id'] = this.cityId;
    data['pid'] = this.pid;
    data['city_admin_id'] = this.cityAdminId;
    data['bdm_admin_id'] = this.bdmAdminId;
    data['created_at'] = this.createdAt;
    data['role_name'] = this.roleName;
    data['level'] = this.level;
    data['district_list'] = this.roleName;
    data['schedule_info'] = this.scheduleInfo;
    return data;
  }
}