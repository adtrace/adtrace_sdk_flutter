//
//  Created by Aref Hosseini on 7th October 2019.
//

import 'dart:async';

import 'package:flutter/services.dart';

class AdtraceSdk {
  static const MethodChannel _channel =
      const MethodChannel('adtrace_sdk');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
