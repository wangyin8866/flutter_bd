class Config {

  static const TOKEN = 'token';

}

class UrlPath {

  static const String serverVersion = '1.0';

  // 登录接口
  static const String login = '$serverVersion/admin/manager/login';
  // 用户信息接口
  static const String userInfo = '$serverVersion/bd/user/info';
  // 日程-根据指定月份获取此月份的事件
  static const String monthList = '$serverVersion/bd/schedule/getMonthList';
  static const String get_account = '$serverVersion/bd/account/get_account';

}