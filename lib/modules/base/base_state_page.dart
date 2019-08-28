import 'package:flutter/material.dart';

import 'base_mvp.dart';
import 'base_presenter.dart';

abstract class BasePageState<T extends StatefulWidget, P extends BasePresenter> extends State<T> implements BaseView {

  P mPresenter;

  P createPresenter();

  BasePageState() {
    mPresenter = createPresenter();
    mPresenter.view = this;
  }

  @override
  void showLoading() {

  }

  @override
  void hideLoading() {

  }

  @override
  void showErrorCode(int code, String msg) {
    // TODO: TOAST提示，子类想要自己操作可以拦截
  }

  @override
  void showSuccess(BaseBean response) {
  }

  @override
  void showOtherError(String msg) {
    // TODO: TOAST提示，子类想要自己操作可以拦截
  }


  @override
  void initState() {
    super.initState();
    mPresenter?.initState();
  }

  @override
  void deactivate() {
    super.deactivate();
    mPresenter?.deactivate();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    mPresenter?.didChangeDependencies();
  }

  @override
  void didUpdateWidget(T oldWidget) {
    super.didUpdateWidget(oldWidget);
    mPresenter?.didUpdateWidgets(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
    mPresenter?.dispose();
  }

  @override
  BuildContext getContext() => context;

}