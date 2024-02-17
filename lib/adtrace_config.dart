/**
 *  AdTrace SDK for Flutter
 *  Developed by Nasser Amini on Mar 2021
 *  for more information visit https://adtrace.io
 */
import 'package:adtrace_sdk_flutter/adtrace_attribution.dart';
import 'package:adtrace_sdk_flutter/adtrace_event_failure.dart';
import 'package:adtrace_sdk_flutter/adtrace_event_success.dart';
import 'package:adtrace_sdk_flutter/adtrace_session_failure.dart';
import 'package:adtrace_sdk_flutter/adtrace_session_success.dart';
import 'package:flutter/services.dart';

enum AdTraceLogLevel { verbose, debug, info, warn, error, suppress }

enum AdTraceEnvironment { production, sandbox }

typedef void AttributionCallback(AdTraceAttribution attributionData);
typedef void SessionSuccessCallback(AdTraceSessionSuccess successData);
typedef void SessionFailureCallback(AdTraceSessionFailure failureData);
typedef void EventSuccessCallback(AdTraceEventSuccess successData);
typedef void EventFailureCallback(AdTraceEventFailure failureData);
typedef void DeferredDeeplinkCallback(String? uri);
typedef void ConversionValueUpdatedCallback(num? conversionValue);
typedef void Skad4ConversionValueUpdatedCallback(num? conversionValue, String? coarseValue, bool? lockWindow);

class AdTraceConfig {
  static const MethodChannel _channel =
      const MethodChannel('io.adtrace.sdk/api');
  static const String _attributionCallbackName = 'adt-attribution-changed';
  static const String _sessionSuccessCallbackName = 'adt-session-success';
  static const String _sessionFailureCallbackName = 'adt-session-failure';
  static const String _eventSuccessCallbackName = 'adt-event-success';
  static const String _eventFailureCallbackName = 'adt-event-failure';
  static const String _deferredDeeplinkCallbackName = 'adt-deferred-deeplink';
  static const String _conversionValueUpdatedCallbackName =
      'adj-conversion-value-updated';
  static const String _skad4ConversionValueUpdatedCallbackName =
      'adj-skad4-conversion-value-updated';

  static const String UrlStrategyIndia = 'india';
  static const String UrlStrategyChina = 'china';
  static const String UrlStrategyCn = 'cn';
  static const String UrlStrategyCnOnly = 'cn-only';

  static const String DataResidencyEU = 'data-residency-eu';
  static const String DataResidencyTR = 'data-residency-tr';
  static const String DataResidencyUS = 'data-residency-us';

  static const String AdRevenueSourceAppLovinMAX = "applovin_max_sdk";
  static const String AdRevenueSourceMopub = 'mopub';
  static const String AdRevenueSourceAdMob = 'admob_sdk';
  static const String AdRevenueSourceIronSource = 'ironsource_sdk';
  static const String AdRevenueSourceAdMostSource = 'admost_sdk';
  static const String AdRevenueSourceUnity = 'unity_sdk';
  static const String AdRevenueSourceHeliumChartboost = 'helium_chartboost_sdk';
  static const String AdRevenueSourcePublisher = 'publisher_sdk';

  String _appToken;
  AdTraceEnvironment _environment;

  num? _info1;
  num? _info2;
  num? _info3;
  num? _info4;
  num? _secretId;
  bool? _skAdNetworkHandling;

  num? attConsentWaitingInterval;
  double? delayStart;
  bool? isDeviceKnown;
  bool? sendInBackground;
  bool? eventBufferingEnabled;
  bool? allowiAdInfoReading;
  bool? allowAdServicesInfoReading;
  bool? allowIdfaReading;
  bool? launchDeferredDeeplink;
  bool? needsCost;
  bool? preinstallTrackingEnabled;
  bool? playStoreKidsAppEnabled;
  bool? coppaCompliantEnabled;
  bool? linkMeEnabled;
  bool? finalAndroidAttributionEnabled;
  String? sdkPrefix;
  String? userAgent;
  String? defaultTracker;
  String? externalDeviceId;
  String? urlStrategy;
  String? processName;
  String? preinstallFilePath;
  AdTraceLogLevel? logLevel;
  AttributionCallback? attributionCallback;
  SessionSuccessCallback? sessionSuccessCallback;
  SessionFailureCallback? sessionFailureCallback;
  EventSuccessCallback? eventSuccessCallback;
  EventFailureCallback? eventFailureCallback;
  DeferredDeeplinkCallback? deferredDeeplinkCallback;
  ConversionValueUpdatedCallback? conversionValueUpdatedCallback;
  Skad4ConversionValueUpdatedCallback? skad4ConversionValueUpdatedCallback;

  AdTraceConfig(this._appToken, this._environment) {
    _initCallbackHandlers();
    _skAdNetworkHandling = true;
  }

  void _initCallbackHandlers() {
    _channel.setMethodCallHandler((MethodCall call) async {
      try {
        switch (call.method) {
          case _attributionCallbackName:
            if (attributionCallback != null) {
              AdTraceAttribution attribution =
                  AdTraceAttribution.fromMap(call.arguments);
              attributionCallback!(attribution);
            }
            break;
          case _sessionSuccessCallbackName:
            if (sessionSuccessCallback != null) {
              AdTraceSessionSuccess sessionSuccess =
                  AdTraceSessionSuccess.fromMap(call.arguments);
              sessionSuccessCallback!(sessionSuccess);
            }
            break;
          case _sessionFailureCallbackName:
            if (sessionFailureCallback != null) {
              AdTraceSessionFailure sessionFailure =
                  AdTraceSessionFailure.fromMap(call.arguments);
              sessionFailureCallback!(sessionFailure);
            }
            break;
          case _eventSuccessCallbackName:
            if (eventSuccessCallback != null) {
              AdTraceEventSuccess eventSuccess =
                  AdTraceEventSuccess.fromMap(call.arguments);
              eventSuccessCallback!(eventSuccess);
            }
            break;
          case _eventFailureCallbackName:
            if (eventFailureCallback != null) {
              AdTraceEventFailure eventFailure =
                  AdTraceEventFailure.fromMap(call.arguments);
              eventFailureCallback!(eventFailure);
            }
            break;
          case _deferredDeeplinkCallbackName:
            if (deferredDeeplinkCallback != null) {
              String? uri = call.arguments['uri'];
              if (deferredDeeplinkCallback != null) {
                deferredDeeplinkCallback!(uri);
              }
            }
            break;
          case _conversionValueUpdatedCallbackName:
            if (conversionValueUpdatedCallback != null) {
              String? conversionValue = call.arguments['conversionValue'];
              if (conversionValue != null) {
                conversionValueUpdatedCallback!(int.parse(conversionValue));
              }
            }
            break;
          case _skad4ConversionValueUpdatedCallbackName:
            if (skad4ConversionValueUpdatedCallback != null) {
              String? conversionValue = call.arguments['fineValue'];
              String? coarseValue = call.arguments['coarseValue'];
              String? lockWindow = call.arguments['lockWindow'];
              if (conversionValue != null && coarseValue != null && lockWindow != null) {
                skad4ConversionValueUpdatedCallback!(
                  int.parse(conversionValue),
                  coarseValue,
                  lockWindow.toLowerCase() == 'true');
              }
            }
            break;
          default:
            throw new UnsupportedError(
                '[AdTraceFlutter]: Received unknown native method: ${call.method}');
        }
      } catch (e) {
        print(e.toString());
      }
    });
  }

  void setAppSecret(num secretId, num info1, num info2, num info3, num info4) {
    _secretId = secretId;
    _info1 = info1;
    _info2 = info2;
    _info3 = info3;
    _info4 = info4;
  }

  void deactivateSKAdNetworkHandling() {
    _skAdNetworkHandling = false;
  }

  Map<String, String?> get toMap {
    Map<String, String?> configMap = {
      'sdkPrefix': sdkPrefix,
      'appToken': _appToken,
      'environment': _environment
          .toString()
          .substring(_environment.toString().indexOf('.') + 1),
    };

    if (userAgent != null) {
      configMap['userAgent'] = userAgent;
    }
    if (processName != null) {
      configMap['processName'] = processName;
    }
    if (logLevel != null) {
      configMap['logLevel'] =
          logLevel.toString().substring(logLevel.toString().indexOf('.') + 1);
    }
    if (defaultTracker != null) {
      configMap['defaultTracker'] = defaultTracker;
    }
    if (externalDeviceId != null) {
      configMap['externalDeviceId'] = externalDeviceId;
    }
    if (urlStrategy != null) {
      configMap['urlStrategy'] = urlStrategy;
    }
    if (isDeviceKnown != null) {
      configMap['isDeviceKnown'] = isDeviceKnown.toString();
    }
    if (sendInBackground != null) {
      configMap['sendInBackground'] = sendInBackground.toString();
    }
    if (eventBufferingEnabled != null) {
      configMap['eventBufferingEnabled'] = eventBufferingEnabled.toString();
    }
    if (needsCost != null) {
      configMap['needsCost'] = needsCost.toString();
    }
    if (preinstallTrackingEnabled != null) {
      configMap['preinstallTrackingEnabled'] =
          preinstallTrackingEnabled.toString();
    }
    if (playStoreKidsAppEnabled != null) {
      configMap['playStoreKidsAppEnabled'] = playStoreKidsAppEnabled.toString();
    }
    if (coppaCompliantEnabled != null) {
      configMap['coppaCompliantEnabled'] = coppaCompliantEnabled.toString();
    }
    if (finalAndroidAttributionEnabled != null) {
      configMap['finalAndroidAttributionEnabled'] = finalAndroidAttributionEnabled.toString();
    }
    if (linkMeEnabled != null) {
      configMap['linkMeEnabled'] = linkMeEnabled.toString();
    }
    if (allowiAdInfoReading != null) {
      configMap['allowiAdInfoReading'] = allowiAdInfoReading.toString();
    }
    if (allowAdServicesInfoReading != null) {
      configMap['allowAdServicesInfoReading'] =
          allowAdServicesInfoReading.toString();
    }
    if (allowIdfaReading != null) {
      configMap['allowIdfaReading'] = allowIdfaReading.toString();
    }
    if (_skAdNetworkHandling != null) {
      configMap['skAdNetworkHandling'] = _skAdNetworkHandling.toString();
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
    if (attConsentWaitingInterval != null) {
      configMap['attConsentWaitingInterval'] = attConsentWaitingInterval.toString();
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
    if (conversionValueUpdatedCallback != null) {
      configMap['conversionValueUpdatedCallback'] =
          _conversionValueUpdatedCallbackName;
    }
    if (skad4ConversionValueUpdatedCallback != null) {
      configMap['skad4ConversionValueUpdatedCallback'] =
          _skad4ConversionValueUpdatedCallbackName;
    }

    return configMap;
  }
}
