import 'package:dio/dio.dart';
import 'package:flutter_bd/modules/base/base_mvp.dart';
import 'package:flutter_bd/net/constant.dart';
import 'package:flutter_bd/net/net.dart';
import 'base_mvp.dart';

class BasePresenter<V extends BaseView> extends IPresenter {
  V view;

  CancelToken _cancelToken;

  BasePresenter() {
    _cancelToken = CancelToken();
  }

  invoke<T>(String url,
      {Map<String, dynamic> params = const {},
      String method = NetConstant.GET,
      bool isShowLoading = true}) async {

    if (isShowLoading) {
      view?.showLoading();
    }

    NetWrapper.init().request(url, _cancelToken,
        params: params,
        method: method,
        onSuccess: (baseBean) {
          if (isShowLoading) {
            view?.hideLoading();
          }
          view?.showSuccess(baseBean);
        },
        onErrorCode: (code, msg) {
          if (isShowLoading) {
            view?.hideLoading();
          }
          view?.showErrorCode(code, msg);
        },
        onOtherError: (msg) {
          if (isShowLoading) {
            view?.hideLoading();
          }
          view?.showOtherError(msg);
        });
  }

  @override
  void deactivate() {}

  @override
  void didChangeDependencies() {}

  @override
  void didUpdateWidgets<W>(W oldWidget) {}

  @override
  void dispose() {
    if (!_cancelToken.isCancelled) {
      _cancelToken.cancel();
    }
  }

  @override
  void initState() {}
}
