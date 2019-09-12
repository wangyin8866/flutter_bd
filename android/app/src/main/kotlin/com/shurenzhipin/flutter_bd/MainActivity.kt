package com.shurenzhipin.flutter_bd

import android.Manifest
import android.os.Bundle
import com.shurenzhipin.flutter_bd.mapwidget.ForMapPlugin
import com.shurenzhipin.flutter_bd.utils.ApplyPermissionsUtils
import io.flutter.app.FlutterFragmentActivity
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterFragmentActivity() {

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)
    //自定义plugin
    MyPlugin.registerWith(flutterView,this)

    ForMapPlugin.registerWith(this)


    ApplyPermissionsUtils.instance.requestPermissions("Location", this, {

    }, Manifest.permission.ACCESS_FINE_LOCATION,
            Manifest.permission.ACCESS_COARSE_LOCATION)
  }

}
