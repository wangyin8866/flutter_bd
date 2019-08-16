
import 'package:flutter_bd/model/example.dart';

class BeanFactory {
  static wrapperBean<T>(json) {
    switch (T.toString()) {
      case 'Example':
        return Example.fromJson(json);
    }
  }
}