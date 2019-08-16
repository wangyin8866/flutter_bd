
abstract class BaseView {

  void showLoading();

  void hideLoading();

  void showSuccess(BaseBean response);

  void showErrorCode(int code, String msg);

  void showOtherError(String msg);

}

abstract class IPresenter {
  void initState();

  void didChangeDependencies();

  void didUpdateWidgets<W>(W oldWidget);

  void deactivate();

  void dispose();
}

class BaseBean {
  int code;
  String msg;
}