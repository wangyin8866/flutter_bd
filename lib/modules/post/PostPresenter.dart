import 'package:flutter_bd/modules/base/base_presenter.dart';

class PostPresenter extends BasePresenter {
  requestTest<T>() {
    invoke<T>('url');
  }
}
