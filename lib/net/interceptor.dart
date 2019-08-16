import 'package:dio/dio.dart';

class AddHeaderInterceptor extends Interceptor {

  @override
  onRequest(RequestOptions options) {
    options.headers =  {
      'Authorization': '',
      'Content-type': 'application/json; charset=utf-8',
      'device-id': 'xxxxxpppppp',
      'app-platform': 'flutter',
      'app-version': '0.0.1'
    };
    return super.onRequest(options);
  }

}