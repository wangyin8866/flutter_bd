import 'package:flutter/material.dart';

import 'base_mvp.dart';
import 'base_presenter.dart';

abstract class BasePageState<T extends StatefulWidget, P extends BasePresenter>
    extends State<T> implements BaseView {
  P mPresenter;

  P createPresenter();

  BasePageState() {
    mPresenter = createPresenter();
    mPresenter.view = this;
  }

  @override
  void showLoading() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Material(
            type: MaterialType.transparency,
            child: Center(
              child: Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    CircularProgressIndicator(),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        'loading...',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  void hideLoading() {
    Navigator.of(context).pop();
  }

  @override
  void showErrorCode(int code, String msg) {
    // TODO: TOAST提示，子类想要自己操作可以拦截
  }

  @override
  void showSuccess(BaseBean response) {}

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
