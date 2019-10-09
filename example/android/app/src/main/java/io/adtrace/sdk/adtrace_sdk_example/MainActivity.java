package io.adtrace.sdk.adtrace_sdk_example;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;

import io.adtrace.sdk.flutter.AdTraceSdk;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    Intent intent = getIntent();
    Uri data = intent.getData();
    AdTraceSdk.appWillOpenUrl(data, this);
  }

  @Override
  protected void onNewIntent(Intent intent) {
    super.onNewIntent(intent);
    Uri data = intent.getData();
    AdTraceSdk.appWillOpenUrl(data, this);
  }
}
