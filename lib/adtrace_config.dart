//
//  Created by Aref Hosseini on 7th October 2019.
//

import 'package:adtrace_sdk/adtrace_attribution.dart';
import 'package:adtrace_sdk/adtrace_event_failure.dart';
import 'package:adtrace_sdk/adtrace_event_success.dart';
import 'package:adtrace_sdk/adtrace_session_failure.dart';
import 'package:adtrace_sdk/adtrace_session_success.dart';
import 'package:flutter/services.dart';

enum AdTraceLogLevel { verbose, debug, info, warn, error, suppress }
enum AdTraceEnvironment { production, sandbox }

typedef void AttributionCallback(AdTraceAttribution attributionData);
typedef void SessionSuccessCallback(AdTraceSessionSuccess successData);
typedef void SessionFailureCallback(AdTraceSessionFailure failureData);
typedef void EventSuccessCallback(AdTraceEventSuccess successData);
typedef void EventFailureCallback(AdTraceEventFailure failureData);
typedef void DeferredDeeplinkCallback(String uri);

class AdTraceConfig {
  static const MethodChannel _channel = const MethodChannel('io.adtrace.sdk/api');
  static const String _attributionCallbackName = 'adj-attribution-changed';
  static const String _sessionSuccessCallbackName = 'adj-session-success';
  static const String _sessionFailureCallbackName = 'adj-session-failure';
  static const String _eventSuccessCallbackName = 'adj-event-success';
  static const String _eventFailureCallbackName = 'adj-event-failure';
  static const String _deferredDeeplinkCallbackName = 'adj-deferred-deeplink';

  num _info1;
  num _info2;
  num _info3;
  num _info4;
  num _secretId;
  String _appToken;
  AdTraceEnvironment _environment;

  double delayStart;
  bool isDeviceKnown;
  bool sendInBackground;
  bool enableInstalledApps;
  bool eventBufferingEnabled;
  bool launchDeferredDeeplink;
  String sdkPrefix;
  String userAgent;
  String defaultTracker;
  String processName;
  AdTraceLogLevel logLevel;
  AttributionCallback attributionCallback;
  SessionSuccessCallback sessionSuccessCallback;
  SessionFailureCallback sessionFailureCallback;
  EventSuccessCallback eventSuccessCallback;
  EventFailureCallback eventFailureCallback;
  DeferredDeeplinkCallback deferredDeeplinkCallback;

  AdTraceConfig(this._appToken, this._environment) {
    _initCallbackHandlers();
  }

  void setAppSecret(num secretId, num info1, num info2, num info3, num info4) {
    _secretId = secretId;
    _info1 = info1;
    _info2 = info2;
    _info3 = info3;
    _info4 = info4;
  }

  void _initCallbackHandlers() {
    _channel.setMethodCallHandler((MethodCall call) {
      try {
        switch (call.method) {
          case _attributionCallbackName:
            if (attributionCallback != null) {
              AdTraceAttribution attribution = AdTraceAttribution.fromMap(call.arguments);
              attributionCallback(attribution);
            }
            break;
          case _sessionSuccessCallbackName:
            if (sessionSuccessCallback != null) {
              AdTraceSessionSuccess sessionSuccess = AdTraceSessionSuccess.fromMap(call.arguments);
              sessionSuccessCallback(sessionSuccess);
            }
            break;
          case _sessionFailureCallbackName:
            if (sessionFailureCallback != null) {
              AdTraceSessionFailure sessionFailure = AdTraceSessionFailure.fromMap(call.arguments);
              sessionFailureCallback(sessionFailure);
            }
            break;
          case _eventSuccessCallbackName:
            if (eventSuccessCallback != null) {
              AdTraceEventSuccess eventSuccess = AdTraceEventSuccess.fromMap(call.arguments);
              eventSuccessCallback(eventSuccess);
            }
            break;
          case _eventFailureCallbackName:
            if (eventFailureCallback != null) {
              AdTraceEventFailure eventFailure = AdTraceEventFailure.fromMap(call.arguments);
              eventFailureCallback(eventFailure);
            }
            break;
          case _deferredDeeplinkCallbackName:
            String uri = call.arguments['uri'];
            if (deferredDeeplinkCallback != null) {
              deferredDeeplinkCallback(uri);
            }
            break;
          default:
            throw new UnsupportedError('[AdTraceFlutter]: Received unknown native method: ${call.method}');
        }
      } catch (e) {
        print(e.toString());
      }
    });
  }

  Map<String, String> get toMap {
    Map<String, String> configMap = {
      'sdkPrefix': sdkPrefix,
      'appToken': _appToken,
      'environment': _environment.toString().substring(_environment.toString().indexOf('.') + 1),
    };

    if (userAgent != null) {
      configMap['userAgent'] = userAgent;
    }
    if (processName != null) {
      configMap['processName'] = processName;
    }
    if (logLevel != null) {
      configMap['logLevel'] = logLevel.toString().substring(logLevel.toString().indexOf('.') + 1);
    }
    if (defaultTracker != null) {
      configMap['defaultTracker'] = defaultTracker;
    }
    if (isDeviceKnown != null) {
      configMap['isDeviceKnown'] = isDeviceKnown.toString();
    }
    if (sendInBackground != null) {
      configMap['sendInBackground'] = sendInBackground.toString();
    }
    if (enableInstalledApps != null) {
      configMap['enableInstalledApps'] = enableInstalledApps.toString();
    }
    if (eventBufferingEnabled != null) {
      configMap['eventBufferingEnabled'] = eventBufferingEnabled.toString();
    }
    if (launchDeferredDeeplink != null) {
      configMap['launchDeferredDeeplink'] = launchDeferredDeeplink.toString();
    }
    if (_info1 != null) {
      configMap['info1'] = _info1.toString();
    }
    if (_info2 != null) {
      configMap['info2'] = _info2.toString();
    }
    if (_info3 != null) {
      configMap['info3'] = _info3.toString();
    }
    if (_info4 != null) {
      configMap['info4'] = _info4.toString();
    }
    if (_secretId != null) {
      configMap['secretId'] = _secretId.toString();
    }
    if (delayStart != null) {
      configMap['delayStart'] = delayStart.toString();
    }
    if (attributionCallback != null) {
      configMap['attributionCallback'] = _attributionCallbackName;
    }
    if (sessionSuccessCallback != null) {
      configMap['sessionSuccessCallback'] = _sessionSuccessCallbackName;
    }
    if (sessionFailureCallback != null) {
      configMap['sessionFailureCallback'] = _sessionFailureCallbackName;
    }
    if (eventSuccessCallback != null) {
      configMap['eventSuccessCallback'] = _eventSuccessCallbackName;
    }
    if (eventFailureCallback != null) {
      configMap['eventFailureCallback'] = _eventFailureCallbackName;
    }
    if (deferredDeeplinkCallback != null) {
      configMap['deferredDeeplinkCallback'] = _deferredDeeplinkCallbackName;
    }

    return configMap;
  }
}