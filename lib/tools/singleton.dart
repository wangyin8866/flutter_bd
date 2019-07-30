import 'package:flutter_bd/modules/login/user.dart';

class singletonManager {

  // 如果一个函数的构造方法并不总是返回一个新的对象的时候，可以使用factory，
  // 比如从缓存中获取一个实例并返回或者返回一个子类型的实例
 
  // 工厂方法构造函数
  factory singletonManager() => _getInstance();
 
  // instance的getter方法，通过UserManager.instance获取对象
  static singletonManager get instance => _getInstance();
 
  // 静态变量_instance，存储唯一对象
  static singletonManager _instance;
 
  // 私有的命名式构造方法，通过它可以实现一个类可以有多个构造函数，
  // 子类不能继承internal不是关键字，可定义其他名字
  singletonManager._internal() {
    // TODO:
  }
  
  // 获取对象
  static singletonManager _getInstance() {
    if (_instance == null) {
      // 使用私有的构造方法来创建对象
      _instance = singletonManager._internal();
    }
    return _instance;
  }
  
  // 用户对象
  User user;

}