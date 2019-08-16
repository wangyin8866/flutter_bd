class UserLoginInfo {
  User user;
  String token;
  List<String> perms;

  UserLoginInfo({this.user, this.token, this.perms});

  UserLoginInfo.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
    perms = json['perms'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['token'] = this.token;
    data['perms'] = this.perms;
    return data;
  }
}

class User {
  int id;
  String name;
  String mobile;
  int isAdmin;
  int isBd;
  Null deletedAt;
  int isLocked;
  String updatedAt;

  User(
      {this.id,
      this.name,
      this.mobile,
      this.isAdmin,
      this.isBd,
      this.deletedAt,
      this.isLocked,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
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