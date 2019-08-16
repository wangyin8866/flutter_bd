import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  // 字符串存储
  static save(String key, value) async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    pre.setString(key, value);
  }

  static get(String key) async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    return pre.get(key);
  }

  static remove(String key) async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    pre.remove(key);
  }

  // TODO 根据自己需要扩展其他类型存储

}