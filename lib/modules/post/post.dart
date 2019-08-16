import 'package:flutter/material.dart';
import 'package:flutter_bd/tools/singleton.dart';

class PostPage extends StatefulWidget {
  PostPage({Key key}) : super(key: key);

  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PostPage'),
      ),
      body: SafeArea(
        child: Center(
          child: Text('id:${SingletonManager().userInfo.id}'),
        ),
      ),
    );
  }
}