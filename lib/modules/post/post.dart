import 'package:flutter/material.dart';
import 'package:flutter_bd/model/example.dart';
import 'package:flutter_bd/modules/base/base_mvp.dart';
import 'package:flutter_bd/modules/post/PostPresenter.dart';
import 'package:flutter_bd/tools/singleton.dart';
import 'package:flutter_bd/modules/base/base_state_page.dart';

class PostPage extends StatefulWidget {
  PostPage({Key key}) : super(key: key);

  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends BasePageState<PostPage, PostPresenter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PostPage'),
      ),
      body: SafeArea(
        child: Center(
          child: Text('id:${SingletonManager().user.userInfo.id}'),
        ),
      ),
    );
  }

  @override
  void showSuccess(BaseBean response) {
    if (response is Example) {

    }
  }

  @override
  PostPresenter createPresenter() {
    return PostPresenter();
  }
}