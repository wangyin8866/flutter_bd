package com.shurenzhipin.flutter_bd

import android.os.Bundle
import com.shurenzhipin.flutter_bd.mapwidget.ForMapPlugin

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)
    //自定义plugin
    MyPlugin.registerWith(flutterView,this)

    ForMapPlugin.registerWith(this)
  }
}
