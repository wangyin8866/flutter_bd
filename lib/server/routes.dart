import 'package:flutter/material.dart';
import 'package:flutter_bd/modules/login/login.dart';
import 'package:flutter_bd/modules/tabbar/tabbar.dart';

final routes = {
    '/': (context) => loginPage(),
    '/tabbar': (context) => tabbarWidget(),
    // '/orderDetail': (context, {arguments}) => orderDetailWidget(arguments: arguments),
    // '/messageList': (context) => messageListWidget(),
    // '/qrcode': (context) => qrcodeWidget(),
    // '/memberDetail': (context) => memberDetailWidget(),
    // '/setting': (context) => settingWidget(),
    // '/userInfo': (context) => userInfoWidget(),
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
            final Route route = MaterialPageRoute(
                builder: (context) => pageContentBuilder(context));
            return route;
          }
        }
      };