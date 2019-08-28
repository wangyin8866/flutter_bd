import 'package:dio/dio.dart';
import 'package:flutter_bd/config/config.dart';
import 'package:flutter_bd/tools/storage.dart';

class AddHeaderInterceptor extends Interceptor {

  @override
  onRequest(RequestOptions options) async {
    var token = await Storage.get(Config.TOKEN);
    options.headers =  {
      'Authorization': token ?? '',
      'Content-type': 'application/json; charset=utf-8',
      'device-id': 'xxxxxpppppp',
      'app-platform': 'flutter',
      'app-version': '0.0.1'
    };
    return super.onRequest(options);
  }

}