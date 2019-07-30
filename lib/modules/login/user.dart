class User {
  UserInfo userInfo;
  String token;
  List<String> perms;

  User({this.userInfo, this.token, this.perms});

  User.fromJson(Map<String, dynamic> json) {
    userInfo = json['user'] != null ? new UserInfo.fromJson(json['user']) : null;
    token = json['token'];
    perms = json['perms'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userInfo != null) {
      data['user'] = this.userInfo.toJson();
    }
    data['token'] = this.token;
    data['perms'] = this.perms;
    return data;
  }
}

class UserInfo {
  int id;
  String name;
  String mobile;
  int isAdmin;
  int isBd;
  Null deletedAt;
  int isLocked;
  String updatedAt;

  UserInfo(
      {this.id,
      this.name,
      this.mobile,
      this.isAdmin,
      this.isBd,
      this.deletedAt,
      this.isLocked,
      this.updatedAt});

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    isAdmin = json['is_admin'];
    isBd = json['is_bd'];
    deletedAt = json['deleted_at'];
    isLocked = json['is_locked'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['is_admin'] = this.isAdmin;
    data['is_bd'] = this.isBd;
    data['deleted_at'] = this.deletedAt;
    data['is_locked'] = this.isLocked;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}