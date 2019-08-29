import 'package:dio/dio.dart';
import 'package:flutter_bd/modules/base/base_mvp.dart';
import 'package:flutter_bd/net/constant.dart';
import 'package:flutter_bd/net/interceptor.dart';
import 'package:flutter_bd/net/bean_factory.dart';

class NetWrapper {
  static Dio _dio;

  NetWrapper.init() {
    _dio ??= Dio()
      ..options.baseUrl = NetConstant.HOST
      ..options.connectTimeout = NetConstant.CONNECT_TIMEOUT
      ..options.receiveTimeout = NetConstant.RECEIVE_TIMEOUT
      ..interceptors.add(AddHeaderInterceptor());
  }

  request<T>(String url, CancelToken cancelToken,
      {Map<String, dynamic> params = const {},
      String method = NetConstant.GET,
      Function(BaseBean baseBean) onSuccess,
      Function(int code, String msg) onErrorCode,
      Function(String msg) onOtherError}) async {
    try {
      Response response = await _dio.request(url,
          data: params,
          options: Options(method: method),
          cancelToken: cancelToken);
      if (response?.statusCode == 200) {
        print('response--->${response.data}');
        var bean = BeanFactory.wrapperBean<T>(response.data);
        if (bean == null) {
          print('bean为空');
          onSuccess(BaseBean());
        } else {
          if (bean.code == NetConstant.SUCCESS_CODE) {
            onSuccess(bean);
          } else {
            print('bean.code--->${bean.code}, bean.msg--->${bean.msg}');
            onErrorCode(bean.code, bean.msg);
          }
        }
      } else {
        print('statusCode--->${response?.statusCode}, statusMessage--->${response?.statusMessage}');
        onOtherError(response?.statusMessage);
      }
    } catch (e) {
      print('网络请求出错--->$e');
      onOtherError('网络请求出错');
    }
  }
}
