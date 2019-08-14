import 'package:dio/dio.dart';
import 'package:flutter_bd/modules/base/base_mvp.dart';
import 'package:flutter_bd/net/constant.dart';
import 'package:flutter_bd/net/interceptor.dart';
import 'package:flutter_bd/net/bean_factory.dart';

class NetWrapper {
  static Dio dio;

  NetWrapper.init() {
    dio ??= Dio()
      ..options.baseUrl = NetConstant.HOST
      ..options.connectTimeout = NetConstant.CONNECT_TIMEOUT
      ..options.receiveTimeout = NetConstant.RECEIVE_TIMEOUT;

    //TODO 拦截操作，在此添加
    dio.interceptors.add(AddHeaderInterceptor());
  }

  request<T>(String url, CancelToken cancelToken,
      {Map<String, dynamic> params = const {},
      String method = NetConstant.GET,
      Function(BaseBean baseBean) onSuccess,
      Function(int code, String msg) onErrorCode,
      Function(String msg) onOtherError}) async {
    try {
      Response response = await dio.request(url,
          data: params,
          options: Options(method: method),
          cancelToken: cancelToken);
      if (response?.statusCode == 200) {
        var bean = BeanFactory.wrapperBean<T>(response.data);
        if (bean == null) {
          onSuccess(BaseBean());
        } else {
          if (bean.code == NetConstant.SUCCESS_CODE) {
            onSuccess(bean);
          } else {
            onErrorCode(bean.code, bean.msg);
          }
        }
      } else {
        onOtherError(response?.statusMessage);
      }
    } catch (e) {
      onOtherError('网络请求出错');
    }
  }
}
