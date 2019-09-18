import 'package:flutter_bd/config/config.dart';
import 'package:flutter_bd/modules/base/base_presenter.dart';
import 'package:flutter_bd/net/constant.dart';

class MinePresenter extends BasePresenter {
  requestAccount<T>() {
    invoke<T>(UrlPath.get_account,
        method: NetConstant.GET, isShowLoading: false);
  }

  requestRong<T>(){
    invoke<T>(UrlPath.get_account,
        method: NetConstant.GET, isShowLoading: false);
  }
}
