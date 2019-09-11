import 'package:flutter/material.dart';
import 'package:flutter_bd/modules/login/login.dart';
import 'package:flutter_bd/modules/post/gallery.dart';
import 'package:flutter_bd/modules/post/post_detail.dart';
import 'package:flutter_bd/modules/order/order_detail.dart';
import 'package:flutter_bd/modules/schedule/schedule_detail.dart';
import 'package:flutter_bd/modules/tabbar/tabbar.dart';

final loginRoutesName = '/';
final tabbarRoutesName = '/tabbar';
final postDetailRoutesName = '/postDetail';
final orderDetailRoutesName = '/orderDetail';
final scheduleDetailRoutesName = '/scheduleDetail';
final galleryRoutesName = '/gallery';

final routes = {
  loginRoutesName: (context) => LoginPage(),
  tabbarRoutesName: (context) => TabbarWidget(),
  postDetailRoutesName: (context, {arguments}) => PostDetailPage(),
  orderDetailRoutesName: (context) => OrderDetailPage(),
  scheduleDetailRoutesName: (context) => ScheduleDetailPage(),
  galleryRoutesName: (context, {arguments}) => GalleryPage(),
};

var onGenerateRoute = (settings) {
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};

