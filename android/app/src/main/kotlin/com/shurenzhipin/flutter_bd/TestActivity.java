package com.shurenzhipin.flutter_bd;

import android.os.Bundle;
import android.util.Log;
import android.widget.TextView;

import io.flutter.app.FlutterActivity;

/**
 * @author : created by wyman
 * @date : 2019-08-14 15:58
 * des :
 */
public class TestActivity extends FlutterActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);


        TextView textView = new TextView(this);
        textView.setText("wangyin");
        setContentView(textView);
        Log.e("wyman", "wasdfs");
    }
}
