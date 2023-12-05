package io.adtrace.sdk.flutter;

import android.content.Context;
import android.net.Uri;
import android.util.Log;

import static io.adtrace.sdk.flutter.AdTraceUtils.*;

import io.adtrace.sdk.AdTrace;
import io.adtrace.sdk.AdTraceAdRevenue;
import io.adtrace.sdk.AdTraceAttribution;
import io.adtrace.sdk.AdTraceConfig;
import io.adtrace.sdk.AdTraceEvent;
import io.adtrace.sdk.AdTraceEventFailure;
import io.adtrace.sdk.AdTraceEventSuccess;
import io.adtrace.sdk.AdTracePurchase;
import io.adtrace.sdk.AdTracePurchaseVerificationResult;
import io.adtrace.sdk.AdTraceSessionFailure;
import io.adtrace.sdk.AdTraceSessionSuccess;
import io.adtrace.sdk.AdTracePlayStoreSubscription;
import io.adtrace.sdk.AdTraceThirdPartySharing;
import io.adtrace.sdk.AdTraceTestOptions;
import io.adtrace.sdk.LogLevel;
import io.adtrace.sdk.OnAttributionChangedListener;
import io.adtrace.sdk.OnDeeplinkResponseListener;
import io.adtrace.sdk.OnDeviceIdsRead;
import io.adtrace.sdk.OnEventTrackingFailedListener;
import io.adtrace.sdk.OnEventTrackingSucceededListener;
import io.adtrace.sdk.OnPurchaseVerificationFinishedListener;
import io.adtrace.sdk.OnSessionTrackingFailedListener;
import io.adtrace.sdk.OnSessionTrackingSucceededListener;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.MethodCall;

public class AdTraceSdk implements FlutterPlugin, ActivityAware, MethodCallHandler {
    private static String TAG = "AdTraceBridge";
    private static boolean launchDeferredDeeplink = true;
    private MethodChannel channel;
    private Context applicationContext;

    // FlutterPlugin
    @Override
    public void onAttachedToEngine(FlutterPluginBinding binding) {
        applicationContext = binding.getApplicationContext();
        channel = new MethodChannel(binding.getBinaryMessenger(), "io.adtrace.sdk/api");
        channel.setMethodCallHandler(this);
    }

    @Override
    public void onDetachedFromEngine(FlutterPluginBinding binding) {
        applicationContext = null;
        if (channel != null) {
            channel.setMethodCallHandler(null);
        }
        channel = null;
    }

    // ActivityAware
    @Override
    public void onAttachedToActivity(ActivityPluginBinding binding) {
        AdTrace.onResume();
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
    }

    @Override
    public void onReattachedToActivityForConfigChanges(
        ActivityPluginBinding binding) {
    }

    @Override
    public void onDetachedFromActivity() {
        AdTrace.onPause();
    }

    @Override
    public void onMethodCall(MethodCall call, final Result result) {
        switch (call.method) {
            case "start":
                start(call, result);
                break;
            case "onPause":
                onPause(result);
                break;
            case "onResume":
                onResume(result);
                break;
            case "trackEvent":
                trackEvent(call, result);
                break;
            case "isEnabled":
                isEnabled(result);
                break;
            case "setEnabled":
                setEnabled(call, result);
                break;
            case "setOfflineMode":
                setOfflineMode(call, result);
                break;
            case "setPushToken":
                setPushToken(call, result);
                break;
            case "appWillOpenUrl":
                appWillOpenUrl(call, result);
                break;
            case "sendFirstPackages":
                sendFirstPackages(result);
                break;
            case "getAdid":
                getAdid(result);
                break;
            case "getIdfa":
                getIdfa(result);
                break;
            case "getGoogleAdId":
                getGoogleAdId(result);
                break;
            case "getAmazonAdId":
                getAmazonAdId(result);
                break;
            case "getAttribution":
                getAttribution(result);
                break;
            case "getSdkVersion":
                getSdkVersion(result);
                break;
            case "setReferrer":
                setReferrer(call, result);
                break;
            case "gdprForgetMe":
                gdprForgetMe(result);
                break;
            case "disableThirdPartySharing":
                disableThirdPartySharing(result);
                break;
            case "addSessionCallbackParameter":
                addSessionCallbackParameter(call, result);
                break;
            case "addSessionPartnerParameter":
                addSessionPartnerParameter(call, result);
                break;
            case "removeSessionCallbackParameter":
                removeSessionCallbackParameter(call, result);
                break;
            case "removeSessionPartnerParameter":
                removeSessionPartnerParameter(call, result);
                break;
            case "resetSessionCallbackParameters":
                resetSessionCallbackParameters(result);
                break;
            case "resetSessionPartnerParameters":
                resetSessionPartnerParameters(result);
                break;
            case "trackAdRevenue":
                trackAdRevenue(call, result);
                break;
            case "trackAdRevenueNew":
                trackAdRevenueNew(call, result);
                break;
            case "trackAppStoreSubscription":
                trackAppStoreSubscription(result);
                break;
            case "trackPlayStoreSubscription":
                trackPlayStoreSubscription(call, result);
                break;
            case "requestTrackingAuthorizationWithCompletionHandler":
                requestTrackingAuthorizationWithCompletionHandler(result);
                break;
            case "updateConversionValue":
                updateConversionValue(result);
                break;
            case "trackThirdPartySharing":
                trackThirdPartySharing(call, result);
                break;
            case "trackMeasurementConsent":
                trackMeasurementConsent(call, result);
                break;
            case "checkForNewAttStatus":
                checkForNewAttStatus(call, result);
                break;
            case "getAppTrackingAuthorizationStatus":
                getAppTrackingAuthorizationStatus(call, result);
                break;
            case "getLastDeeplink":
                getLastDeeplink(call, result);
                break;
            case "verifyPlayStorePurchase":
                verifyPlayStorePurchase(call, result);
                break;
            case "verifyAppStorePurchase":
                verifyAppStorePurchase(call, result);
                break;
            case "setTestOptions":
                setTestOptions(call, result);
                break;
            default:
                Log.e(TAG, "Not implemented method: " + call.method);
                result.notImplemented();
                break;
        }
    }

    private void start(final MethodCall call, final Result result) {
        Map configMap = (Map) call.arguments;
        if (configMap == null) {
            return;
        }

        String appToken = null;
        String environment = null;
        String logLevel = null;
        boolean isLogLevelSuppress = false;

        // App token.
        if (configMap.containsKey("appToken")) {
            appToken = (String) configMap.get("appToken");
        }

        // Environment.
        if (configMap.containsKey("environment")) {
            environment = (String) configMap.get("environment");
        }

        // Suppress log level.
        if (configMap.containsKey("logLevel")) {
            logLevel = (String) configMap.get("logLevel");
            if (logLevel != null && logLevel.equals("suppress")) {
                isLogLevelSuppress = true;
            }
        }

        // Create configuration object.
        AdTraceConfig adtraceConfig = new AdTraceConfig(applicationContext, appToken, environment, isLogLevelSuppress);

        // SDK prefix.
        if (configMap.containsKey("sdkPrefix")) {
            String sdkPrefix = (String) configMap.get("sdkPrefix");
            adtraceConfig.setSdkPrefix(sdkPrefix);
        }

        // Log level.
        if (configMap.containsKey("logLevel")) {
            logLevel = (String) configMap.get("logLevel");
            if (logLevel != null) {
                switch (logLevel) {
                    case "verbose":
                        adtraceConfig.setLogLevel(LogLevel.VERBOSE);
                        break;
                    case "debug":
                        adtraceConfig.setLogLevel(LogLevel.DEBUG);
                        break;
                    case "warn":
                        adtraceConfig.setLogLevel(LogLevel.WARN);
                        break;
                    case "error":
                        adtraceConfig.setLogLevel(LogLevel.ERROR);
                        break;
                    case "assert":
                        adtraceConfig.setLogLevel(LogLevel.ASSERT);
                        break;
                    case "suppress":
                        adtraceConfig.setLogLevel(LogLevel.SUPRESS);
                        break;
                    case "info":
                    default:
                        adtraceConfig.setLogLevel(LogLevel.INFO);
                        break;
                }
            }
        }

        // Event buffering.
        if (configMap.containsKey("eventBufferingEnabled")) {
            String strEventBufferingEnabled = (String) configMap.get("eventBufferingEnabled");
            boolean eventBufferingEnabled = Boolean.parseBoolean(strEventBufferingEnabled);
            adtraceConfig.setEventBufferingEnabled(eventBufferingEnabled);
        }

        // COPPA compliance.
        if (configMap.containsKey("coppaCompliantEnabled")) {
            String strCoppaCompliantEnabled = (String) configMap.get("coppaCompliantEnabled");
            boolean coppaCompliantEnabled = Boolean.parseBoolean(strCoppaCompliantEnabled);
            adtraceConfig.setCoppaCompliantEnabled(coppaCompliantEnabled);
        }

        // Final attribution.
        if (configMap.containsKey("finalAndroidAttributionEnabled")) {
            String strFinalAndroidAttributionEnabled = (String) configMap.get("finalAndroidAttributionEnabled");
            boolean finalAndroidAttributionEnabled = Boolean.parseBoolean(strFinalAndroidAttributionEnabled);
            adtraceConfig.setFinalAttributionEnabled(finalAndroidAttributionEnabled);
        }

        // Google Play Store kids apps.
        if (configMap.containsKey("playStoreKidsAppEnabled")) {
            String strPlayStoreKidsAppEnabled = (String) configMap.get("playStoreKidsAppEnabled");
            boolean playStoreKidsAppEnabled = Boolean.parseBoolean(strPlayStoreKidsAppEnabled);
            adtraceConfig.setPlayStoreKidsAppEnabled(playStoreKidsAppEnabled);
        }

        // Main process name.
        if (configMap.containsKey("processName")) {
            String processName = (String) configMap.get("processName");
            adtraceConfig.setProcessName(processName);
        }

        // Default tracker.
        if (configMap.containsKey("defaultTracker")) {
            String defaultTracker = (String) configMap.get("defaultTracker");
            adtraceConfig.setDefaultTracker(defaultTracker);
        }

        // External device ID.
        if (configMap.containsKey("externalDeviceId")) {
            String externalDeviceId = (String) configMap.get("externalDeviceId");
            adtraceConfig.setExternalDeviceId(externalDeviceId);
        }

        // Custom preinstall file path.
        if (configMap.containsKey("preinstallFilePath")) {
            String preinstallFilePath = (String) configMap.get("preinstallFilePath");
            adtraceConfig.setPreinstallFilePath(preinstallFilePath);
        }

        // URL strategy.
        if (configMap.containsKey("urlStrategy")) {
            String urlStrategy = (String) configMap.get("urlStrategy");
            if (urlStrategy.equalsIgnoreCase("china")) {
                adtraceConfig.setUrlStrategy(AdTraceConfig.URL_STRATEGY_CHINA);
            } else if (urlStrategy.equalsIgnoreCase("india")) {
                adtraceConfig.setUrlStrategy(AdTraceConfig.URL_STRATEGY_INDIA);
            } else if (urlStrategy.equalsIgnoreCase("cn")) {
                adtraceConfig.setUrlStrategy(AdTraceConfig.URL_STRATEGY_CN);
            } else if (urlStrategy.equalsIgnoreCase("data-residency-eu")) {
                adtraceConfig.setUrlStrategy(AdTraceConfig.DATA_RESIDENCY_EU);
            } else if (urlStrategy.equalsIgnoreCase("data-residency-tr")) {
                adtraceConfig.setUrlStrategy(AdTraceConfig.DATA_RESIDENCY_TR);
            } else if (urlStrategy.equalsIgnoreCase("data-residency-us")) {
                adtraceConfig.setUrlStrategy(AdTraceConfig.DATA_RESIDENCY_US);
            }
        }

        // User agent.
        if (configMap.containsKey("userAgent")) {
            String userAgent = (String) configMap.get("userAgent");
            adtraceConfig.setUserAgent(userAgent);
        }

        // Background tracking.
        if (configMap.containsKey("sendInBackground")) {
            String strSendInBackground = (String) configMap.get("sendInBackground");
            boolean sendInBackground = Boolean.parseBoolean(strSendInBackground);
            adtraceConfig.setSendInBackground(sendInBackground);
        }

        // Set device known.
        if (configMap.containsKey("isDeviceKnown")) {
            String strIsDeviceKnown = (String) configMap.get("isDeviceKnown");
            boolean isDeviceKnown = Boolean.parseBoolean(strIsDeviceKnown);
            adtraceConfig.setDeviceKnown(isDeviceKnown);
        }

        // Cost data.
        if (configMap.containsKey("needsCost")) {
            String strNeedsCost = (String) configMap.get("needsCost");
            boolean needsCost = Boolean.parseBoolean(strNeedsCost);
            adtraceConfig.setNeedsCost(needsCost);
        }

        // Preinstall tracking.
        if (configMap.containsKey("preinstallTrackingEnabled")) {
            String strPreinstallTrackingEnabled = (String) configMap.get("preinstallTrackingEnabled");
            boolean preinstallTrackingEnabled = Boolean.parseBoolean(strPreinstallTrackingEnabled);
            adtraceConfig.setPreinstallTrackingEnabled(preinstallTrackingEnabled);
        }

        // Delayed start.
        if (configMap.containsKey("delayStart")) {
            String strDelayStart = (String) configMap.get("delayStart");
            if (isNumber(strDelayStart)) {
                double delayStart = Double.parseDouble(strDelayStart);
                adtraceConfig.setDelayStart(delayStart);
            }
        }

        // App secret.
        if (configMap.containsKey("secretId")
                && configMap.containsKey("info1")
                && configMap.containsKey("info2")
                && configMap.containsKey("info3")
                && configMap.containsKey("info4")) {
            try {
                String strSecretId = (String) configMap.get("secretId");
                String strInfo1 = (String) configMap.get("info1");
                String strInfo2 = (String) configMap.get("info2");
                String strInfo3 = (String) configMap.get("info3");
                String strInfo4 = (String) configMap.get("info4");
                long secretId = Long.parseLong(strSecretId, 10);
                long info1 = Long.parseLong(strInfo1, 10);
                long info2 = Long.parseLong(strInfo2, 10);
                long info3 = Long.parseLong(strInfo3, 10);
                long info4 = Long.parseLong(strInfo4, 10);
                adtraceConfig.setAppSecret(secretId, info1, info2, info3, info4);
            } catch (NumberFormatException ignore) {}
        }

        // Launch deferred deep link.
        if (configMap.containsKey("launchDeferredDeeplink")) {
            String strLaunchDeferredDeeplink = (String) configMap.get("launchDeferredDeeplink");
            launchDeferredDeeplink = strLaunchDeferredDeeplink.equals("true");
        }

        // Attribution callback.
        if (configMap.containsKey("attributionCallback")) {
            final String dartMethodName = (String) configMap.get("attributionCallback");
            if (dartMethodName != null) {
                adtraceConfig.setOnAttributionChangedListener(new OnAttributionChangedListener() {
                    @Override
                    public void onAttributionChanged(AdTraceAttribution adtraceAttribution) {
                        HashMap<String, Object> adtraceAttributionMap = new HashMap<String, Object>();
                        adtraceAttributionMap.put("trackerToken", adtraceAttribution.trackerToken);
                        adtraceAttributionMap.put("trackerName", adtraceAttribution.trackerName);
                        adtraceAttributionMap.put("network", adtraceAttribution.network);
                        adtraceAttributionMap.put("campaign", adtraceAttribution.campaign);
                        adtraceAttributionMap.put("adgroup", adtraceAttribution.adgroup);
                        adtraceAttributionMap.put("creative", adtraceAttribution.creative);
                        adtraceAttributionMap.put("clickLabel", adtraceAttribution.clickLabel);
                        adtraceAttributionMap.put("adid", adtraceAttribution.adid);
                        adtraceAttributionMap.put("costType", adtraceAttribution.costType);
                        adtraceAttributionMap.put("costAmount", adtraceAttribution.costAmount != null ?
                                adtraceAttribution.costAmount.toString() : "");
                        adtraceAttributionMap.put("costCurrency", adtraceAttribution.costCurrency);
                        adtraceAttributionMap.put("fbInstallReferrer", adtraceAttribution.fbInstallReferrer);
                        if (channel != null) {
                            channel.invokeMethod(dartMethodName, adtraceAttributionMap);
                        }
                    }
                });
            }
        }

        // Session success callback.
        if (configMap.containsKey("sessionSuccessCallback")) {
            final String dartMethodName = (String) configMap.get("sessionSuccessCallback");
            if (dartMethodName != null) {
                adtraceConfig.setOnSessionTrackingSucceededListener(new OnSessionTrackingSucceededListener() {
                    @Override
                    public void onFinishedSessionTrackingSucceeded(AdTraceSessionSuccess adtraceSessionSuccess) {
                        HashMap<String, String> adtraceSessionSuccessMap = new HashMap<String, String>();
                        adtraceSessionSuccessMap.put("message", adtraceSessionSuccess.message);
                        adtraceSessionSuccessMap.put("timestamp", adtraceSessionSuccess.timestamp);
                        adtraceSessionSuccessMap.put("adid", adtraceSessionSuccess.adid);
                        if (adtraceSessionSuccess.jsonResponse != null) {
                            adtraceSessionSuccessMap.put("jsonResponse", adtraceSessionSuccess.jsonResponse.toString());
                        }
                        if (channel != null) {
                            channel.invokeMethod(dartMethodName, adtraceSessionSuccessMap);
                        }
                    }
                });
            }
        }

        // Session failure callback.
        if (configMap.containsKey("sessionFailureCallback")) {
            final String dartMethodName = (String) configMap.get("sessionFailureCallback");
            if (dartMethodName != null) {
                adtraceConfig.setOnSessionTrackingFailedListener(new OnSessionTrackingFailedListener() {
                    @Override
                    public void onFinishedSessionTrackingFailed(AdTraceSessionFailure adtraceSessionFailure) {
                        HashMap<String, String> adtraceSessionFailureMap = new HashMap<String, String>();
                        adtraceSessionFailureMap.put("message", adtraceSessionFailure.message);
                        adtraceSessionFailureMap.put("timestamp", adtraceSessionFailure.timestamp);
                        adtraceSessionFailureMap.put("adid", adtraceSessionFailure.adid);
                        adtraceSessionFailureMap.put("willRetry", Boolean.toString(adtraceSessionFailure.willRetry));
                        if (adtraceSessionFailure.jsonResponse != null) {
                            adtraceSessionFailureMap.put("jsonResponse", adtraceSessionFailure.jsonResponse.toString());
                        }
                        if (channel != null) {
                            channel.invokeMethod(dartMethodName, adtraceSessionFailureMap);
                        }
                    }
                });
            }
        }

        // Event success callback.
        if (configMap.containsKey("eventSuccessCallback")) {
            final String dartMethodName = (String) configMap.get("eventSuccessCallback");
            if (dartMethodName != null) {
                adtraceConfig.setOnEventTrackingSucceededListener(new OnEventTrackingSucceededListener() {
                    @Override
                    public void onFinishedEventTrackingSucceeded(AdTraceEventSuccess adtraceEventSuccess) {
                        HashMap<String, String> adtraceEventSuccessMap = new HashMap<String, String>();
                        adtraceEventSuccessMap.put("message", adtraceEventSuccess.message);
                        adtraceEventSuccessMap.put("timestamp", adtraceEventSuccess.timestamp);
                        adtraceEventSuccessMap.put("adid", adtraceEventSuccess.adid);
                        adtraceEventSuccessMap.put("eventToken", adtraceEventSuccess.eventToken);
                        adtraceEventSuccessMap.put("callbackId", adtraceEventSuccess.callbackId);
                        if (adtraceEventSuccess.jsonResponse != null) {
                            adtraceEventSuccessMap.put("jsonResponse", adtraceEventSuccess.jsonResponse.toString());
                        }
                        if (channel != null) {
                            channel.invokeMethod(dartMethodName, adtraceEventSuccessMap);
                        }
                    }
                });
            }
        }

        // Event failure callback.
        if (configMap.containsKey("eventFailureCallback")) {
            final String dartMethodName = (String) configMap.get("eventFailureCallback");
            if (dartMethodName != null) {
                adtraceConfig.setOnEventTrackingFailedListener(new OnEventTrackingFailedListener() {
                    @Override
                    public void onFinishedEventTrackingFailed(AdTraceEventFailure adtraceEventFailure) {
                        HashMap<String, String> adtraceEventFailureMap = new HashMap<String, String>();
                        adtraceEventFailureMap.put("message", adtraceEventFailure.message);
                        adtraceEventFailureMap.put("timestamp", adtraceEventFailure.timestamp);
                        adtraceEventFailureMap.put("adid", adtraceEventFailure.adid);
                        adtraceEventFailureMap.put("eventToken", adtraceEventFailure.eventToken);
                        adtraceEventFailureMap.put("callbackId", adtraceEventFailure.callbackId);
                        adtraceEventFailureMap.put("willRetry", Boolean.toString(adtraceEventFailure.willRetry));
                        if (adtraceEventFailure.jsonResponse != null) {
                            adtraceEventFailureMap.put("jsonResponse", adtraceEventFailure.jsonResponse.toString());
                        }
                        if (channel != null) {
                            channel.invokeMethod(dartMethodName, adtraceEventFailureMap);
                        }
                    }
                });
            }
        }

        // Deferred deep link callback.
        if (configMap.containsKey("deferredDeeplinkCallback")) {
            final String dartMethodName = (String) configMap.get("deferredDeeplinkCallback");
            if (dartMethodName != null) {
                adtraceConfig.setOnDeeplinkResponseListener(new OnDeeplinkResponseListener() {
                    @Override
                    public boolean launchReceivedDeeplink(Uri uri) {
                        HashMap<String, String> uriParamsMap = new HashMap<String, String>();
                        uriParamsMap.put("uri", uri.toString());
                        if (channel != null) {
                            channel.invokeMethod(dartMethodName, uriParamsMap);
                        }
                        return launchDeferredDeeplink;
                    }
                });
            }
        }

        // Start SDK.
        AdTrace.onCreate(adtraceConfig);
        AdTrace.onResume();
        result.success(null);
    }

    private void trackEvent(final MethodCall call, final Result result) {
        Map eventMap = (Map) call.arguments;
        if (eventMap == null) {
            return;
        }

        // Event token.
        String eventToken = null;
        if (eventMap.containsKey("eventToken")) {
            eventToken = (String) eventMap.get("eventToken");
        }

        // Create event object.
        AdTraceEvent event = new AdTraceEvent(eventToken);

        // Revenue.
        if (eventMap.containsKey("revenue") || eventMap.containsKey("currency")) {
            double revenue = -1.0;
            String strRevenue = (String) eventMap.get("revenue");

            try {
                revenue = Double.parseDouble(strRevenue);
            } catch (NumberFormatException ignore) {}

            String currency = (String) eventMap.get("currency");
            event.setRevenue(revenue, currency);
        }

        // Revenue deduplication.
        if (eventMap.containsKey("transactionId")) {
            String orderId = (String) eventMap.get("transactionId");
            event.setOrderId(orderId);
        }

        // Product ID.
        if (eventMap.containsKey("productId")) {
            String productId = (String) eventMap.get("productId");
            event.setProductId(productId);
        }

        // Purchase token.
        if (eventMap.containsKey("purchaseToken")) {
            String purchaseToken = (String) eventMap.get("purchaseToken");
            event.setPurchaseToken(purchaseToken);
        }

        // Callback ID.
        if (eventMap.containsKey("callbackId")) {
            String callbackId = (String) eventMap.get("callbackId");
            event.setCallbackId(callbackId);
        }

        // Callback parameters.
        if (eventMap.containsKey("callbackParameters")) {
            String strCallbackParametersJson = (String) eventMap.get("callbackParameters");
            try {
                JSONObject jsonCallbackParameters = new JSONObject(strCallbackParametersJson);
                JSONArray callbackParametersKeys = jsonCallbackParameters.names();
                for (int i = 0; i < callbackParametersKeys.length(); ++i) {
                    String key = callbackParametersKeys.getString(i);
                    String value = jsonCallbackParameters.getString(key);
                    event.addCallbackParameter(key, value);
                }
            } catch (JSONException e) {
                Log.e(TAG, "Failed to parse event callback parameter! Details: " + e);
            }
        }

        // Event parameters.
        if (eventMap.containsKey("eventParameters")) {
            String strEventParametersJson = (String) eventMap.get("eventParameters");
            try {
                JSONObject jsonEventParameters = new JSONObject(strEventParametersJson);
                JSONArray eventParametersKeys = jsonEventParameters.names();
                for (int i = 0; i < eventParametersKeys.length(); ++i) {
                    String key = eventParametersKeys.getString(i);
                    String value = jsonEventParameters.getString(key);
                    event.addEventParameter(key, value);
                }
            } catch (JSONException e) {
                Log.e(TAG, "Failed to parse event parameter! Details: " + e);
            }
        }

        // Track event.
        AdTrace.trackEvent(event);
        result.success(null);
    }

    private void setOfflineMode(final MethodCall call, final Result result) {
        Map isOfflineParamsMap = (Map) call.arguments;
        boolean isOffline = (boolean) isOfflineParamsMap.get("isOffline");
        AdTrace.setOfflineMode(isOffline);
        result.success(null);
    }

    private void setPushToken(final MethodCall call, final Result result) {
        Map tokenParamsMap = (Map) call.arguments;
        String pushToken = null;
        if (tokenParamsMap.containsKey("pushToken")) {
            pushToken = tokenParamsMap.get("pushToken").toString();
        }
        AdTrace.setPushToken(pushToken, applicationContext);
        result.success(null);
    }

    private void setEnabled(final MethodCall call, final Result result) {
        Map isEnabledParamsMap = (Map) call.arguments;
        if (!isEnabledParamsMap.containsKey("isEnabled")) {
            result.error("0", "Arguments null or wrong (missing argument of 'isEnabled' method.", null);
            return;
        }

        boolean isEnabled = (boolean) isEnabledParamsMap.get("isEnabled");
        AdTrace.setEnabled(isEnabled);
        result.success(null);
    }

    private void appWillOpenUrl(final MethodCall call, final Result result) {
        Map urlParamsMap = (Map) call.arguments;
        String url = null;
        if (urlParamsMap.containsKey("url")) {
            url = urlParamsMap.get("url").toString();
        }
        AdTrace.appWillOpenUrl(Uri.parse(url), applicationContext);
        result.success(null);
    }

    // Exposed for handling deep linking from native layer of the example app.
    public static void appWillOpenUrl(Uri deeplink, Context context) {
        AdTrace.appWillOpenUrl(deeplink, context);
    }

    private void sendFirstPackages(final Result result) {
        AdTrace.sendFirstPackages();
        result.success(null);
    }

    private void onResume(final Result result) {
        AdTrace.onResume();
        result.success(null);
    }

    private void onPause(final Result result) {
        AdTrace.onPause();
        result.success(null);
    }

    private void isEnabled(final Result result) {
        result.success(AdTrace.isEnabled());
    }

    private void getAdid(final Result result) {
        result.success(AdTrace.getAdid());
    }

    private void getIdfa(final Result result) {
        result.success("Error. No IDFA on Android platform!");
    }

    private void getGoogleAdId(final Result result) {
        AdTrace.getGoogleAdId(applicationContext, new OnDeviceIdsRead() {
            @Override
            public void onGoogleAdIdRead(String googleAdId) {
                result.success(googleAdId);
            }
        });
    }

    private void getAmazonAdId(final Result result) {
        result.success(AdTrace.getAmazonAdId(applicationContext));
    }

    private void gdprForgetMe(final Result result) {
        AdTrace.gdprForgetMe(applicationContext);
        result.success(null);
    }

    private void disableThirdPartySharing(final Result result) {
        AdTrace.disableThirdPartySharing(applicationContext);
        result.success(null);
    }

    private void getAttribution(final Result result) {
        AdTraceAttribution adtraceAttribution = AdTrace.getAttribution();
        if (adtraceAttribution == null) {
            adtraceAttribution = new AdTraceAttribution();
        }

        HashMap<String, String> adtraceAttributionMap = new HashMap<String, String>();
        adtraceAttributionMap.put("trackerToken", adtraceAttribution.trackerToken);
        adtraceAttributionMap.put("trackerName", adtraceAttribution.trackerName);
        adtraceAttributionMap.put("network", adtraceAttribution.network);
        adtraceAttributionMap.put("campaign", adtraceAttribution.campaign);
        adtraceAttributionMap.put("adgroup", adtraceAttribution.adgroup);
        adtraceAttributionMap.put("creative", adtraceAttribution.creative);
        adtraceAttributionMap.put("clickLabel", adtraceAttribution.clickLabel);
        adtraceAttributionMap.put("adid", adtraceAttribution.adid);
        adtraceAttributionMap.put("costType", adtraceAttribution.costType);
        adtraceAttributionMap.put("costAmount", adtraceAttribution.costAmount != null ?
                adtraceAttribution.costAmount.toString() : "");
        adtraceAttributionMap.put("costCurrency", adtraceAttribution.costCurrency);
        adtraceAttributionMap.put("fbInstallReferrer", adtraceAttribution.fbInstallReferrer);
        result.success(adtraceAttributionMap);
    }

    private void getSdkVersion(final Result result) {
        result.success(AdTrace.getSdkVersion());
    }

    private void setReferrer(final MethodCall call, final Result result) {
        String referrer = null;
        if (call.hasArgument("referrer")) {
            referrer = (String) call.argument("referrer");
        }
        AdTrace.setReferrer(referrer, applicationContext);
        result.success(null);
    }

    private void addSessionCallbackParameter(final MethodCall call, final Result result) {
        String key = null;
        String value = null;
        if (call.hasArgument("key") && call.hasArgument("value")) {
            key = (String) call.argument("key");
            value = (String) call.argument("value");
        }
        AdTrace.addSessionCallbackParameter(key, value);
        result.success(null);
    }

    private void addSessionPartnerParameter(final MethodCall call, final Result result) {
        String key = null;
        String value = null;
        if (call.hasArgument("key") && call.hasArgument("value")) {
            key = (String) call.argument("key");
            value = (String) call.argument("value");
        }
        AdTrace.addSessionPartnerParameter(key, value);
        result.success(null);
    }

    private void removeSessionCallbackParameter(final MethodCall call, final Result result) {
        String key = null;
        if (call.hasArgument("key")) {
            key = (String) call.argument("key");
        }
        AdTrace.removeSessionCallbackParameter(key);
        result.success(null);
    }

    private void removeSessionPartnerParameter(final MethodCall call, final Result result) {
        String key = null;
        if (call.hasArgument("key")) {
            key = (String) call.argument("key");
        }
        AdTrace.removeSessionPartnerParameter(key);
        result.success(null);
    }

    private void resetSessionCallbackParameters(final Result result) {
        AdTrace.resetSessionCallbackParameters();
        result.success(null);
    }

    private void resetSessionPartnerParameters(final Result result) {
        AdTrace.resetSessionPartnerParameters();
        result.success(null);
    }

    private void trackAdRevenue(final MethodCall call, final Result result) {
        if (call.hasArgument("source") && call.hasArgument("payload")) {
            // Old (MoPub) API.
            String source = (String) call.argument("source");
            String payload = (String) call.argument("payload");

            try {
                JSONObject jsonPayload = new JSONObject(payload);
                AdTrace.trackAdRevenue(source, jsonPayload);
            } catch (JSONException err) {
                Log.e(TAG, "Given ad revenue payload is not a valid JSON string");
            }
        } 
        result.success(null);
    }

    private void trackAdRevenueNew(final MethodCall call, final Result result) {
        // New API.
        Map adRevenueMap = (Map) call.arguments;
        if (adRevenueMap == null) {
            return;
        }

        // Source.
        String source = null;
        if (adRevenueMap.containsKey("source")) {
            source = (String) adRevenueMap.get("source");
        }

        // Create ad revenue object.
        AdTraceAdRevenue adRevenue = new AdTraceAdRevenue(source);

        // Revenue.
        if (adRevenueMap.containsKey("revenue") || adRevenueMap.containsKey("currency")) {
            double revenue = -1.0;
            String strRevenue = (String) adRevenueMap.get("revenue");

            try {
                revenue = Double.parseDouble(strRevenue);
            } catch (NumberFormatException ignore) {}

            String currency = (String) adRevenueMap.get("currency");
            adRevenue.setRevenue(revenue, currency);
        }

        // Ad impressions count.
        if (adRevenueMap.containsKey("adImpressionsCount")) {
            String strAdImpressionsCount = (String) adRevenueMap.get("adImpressionsCount");
            int adImpressionsCount = Integer.parseInt(strAdImpressionsCount);
            adRevenue.setAdImpressionsCount(adImpressionsCount);
        }

        // Ad revenue network.
        if (adRevenueMap.containsKey("adRevenueNetwork")) {
            String adRevenueNetwork = (String) adRevenueMap.get("adRevenueNetwork");
            adRevenue.setAdRevenueNetwork(adRevenueNetwork);
        }

        // Ad revenue unit.
        if (adRevenueMap.containsKey("adRevenueUnit")) {
            String adRevenueUnit = (String) adRevenueMap.get("adRevenueUnit");
            adRevenue.setAdRevenueUnit(adRevenueUnit);
        }

        // Ad revenue placement.
        if (adRevenueMap.containsKey("adRevenuePlacement")) {
            String adRevenuePlacement = (String) adRevenueMap.get("adRevenuePlacement");
            adRevenue.setAdRevenuePlacement(adRevenuePlacement);
        }

        // Callback parameters.
        if (adRevenueMap.containsKey("callbackParameters")) {
            String strCallbackParametersJson = (String) adRevenueMap.get("callbackParameters");
            try {
                JSONObject jsonCallbackParameters = new JSONObject(strCallbackParametersJson);
                JSONArray callbackParametersKeys = jsonCallbackParameters.names();
                for (int i = 0; i < callbackParametersKeys.length(); ++i) {
                    String key = callbackParametersKeys.getString(i);
                    String value = jsonCallbackParameters.getString(key);
                    adRevenue.addCallbackParameter(key, value);
                }
            } catch (JSONException e) {
                Log.e(TAG, "Failed to parse ad revenue callback parameter! Details: " + e);
            }
        }

        // Partner parameters.
        if (adRevenueMap.containsKey("partnerParameters")) {
            String strPartnerParametersJson = (String) adRevenueMap.get("partnerParameters");
            try {
                JSONObject jsonPartnerParameters = new JSONObject(strPartnerParametersJson);
                JSONArray partnerParametersKeys = jsonPartnerParameters.names();
                for (int i = 0; i < partnerParametersKeys.length(); ++i) {
                    String key = partnerParametersKeys.getString(i);
                    String value = jsonPartnerParameters.getString(key);
                    adRevenue.addPartnerParameter(key, value);
                }
            } catch (JSONException e) {
                Log.e(TAG, "Failed to parse ad revenue partner parameter! Details: " + e);
            }
        }

        // Track ad revenue.
        AdTrace.trackAdRevenue(adRevenue);
        result.success(null);
    }

    private void trackAppStoreSubscription(final Result result) {
        result.success("Error. No App Store subscription tracking on Android platform!");
    }

    private void trackPlayStoreSubscription(final MethodCall call, final Result result) {
        Map subscriptionMap = (Map) call.arguments;
        if (subscriptionMap == null) {
            return;
        }

        // Price.
        long price = -1;
        if (subscriptionMap.containsKey("price")) {
            try {
                price = Long.parseLong(subscriptionMap.get("price").toString());
            } catch (NumberFormatException ignore) {}
        }

        // Currency.
        String currency = null;
        if (subscriptionMap.containsKey("currency")) {
            currency = (String) subscriptionMap.get("currency");
        }

        // SKU.
        String sku = null;
        if (subscriptionMap.containsKey("sku")) {
            sku = (String) subscriptionMap.get("sku");
        }

        // Order ID.
        String orderId = null;
        if (subscriptionMap.containsKey("orderId")) {
            orderId = (String) subscriptionMap.get("orderId");
        }

        // Signature.
        String signature = null;
        if (subscriptionMap.containsKey("signature")) {
            signature = (String) subscriptionMap.get("signature");
        }

        // Purchase token.
        String purchaseToken = null;
        if (subscriptionMap.containsKey("purchaseToken")) {
            purchaseToken = (String) subscriptionMap.get("purchaseToken");
        }

        // Create subscription object.
        AdTracePlayStoreSubscription subscription = new AdTracePlayStoreSubscription(
                price,
                currency,
                sku,
                orderId,
                signature,
                purchaseToken);

        // Purchase time.
        if (subscriptionMap.containsKey("purchaseTime")) {
            try {
                long purchaseTime = Long.parseLong(subscriptionMap.get("purchaseTime").toString());
                subscription.setPurchaseTime(purchaseTime);
            } catch (NumberFormatException ignore) {}
        }

        // Callback parameters.
        if (subscriptionMap.containsKey("callbackParameters")) {
            String strCallbackParametersJson = (String) subscriptionMap.get("callbackParameters");
            try {
                JSONObject jsonCallbackParameters = new JSONObject(strCallbackParametersJson);
                JSONArray callbackParametersKeys = jsonCallbackParameters.names();
                for (int i = 0; i < callbackParametersKeys.length(); ++i) {
                    String key = callbackParametersKeys.getString(i);
                    String value = jsonCallbackParameters.getString(key);
                    subscription.addCallbackParameter(key, value);
                }
            } catch (JSONException e) {
                Log.e(TAG, "Failed to parse subscription callback parameter! Details: " + e);
            }
        }

        // Partner parameters.
        if (subscriptionMap.containsKey("partnerParameters")) {
            String strPartnerParametersJson = (String) subscriptionMap.get("partnerParameters");
            try {
                JSONObject jsonPartnerParameters = new JSONObject(strPartnerParametersJson);
                JSONArray partnerParametersKeys = jsonPartnerParameters.names();
                for (int i = 0; i < partnerParametersKeys.length(); ++i) {
                    String key = partnerParametersKeys.getString(i);
                    String value = jsonPartnerParameters.getString(key);
                    subscription.addPartnerParameter(key, value);
                }
            } catch (JSONException e) {
                Log.e(TAG, "Failed to parse subscription partner parameter! Details: " + e);
            }
        }

        // Track subscription.
        AdTrace.trackPlayStoreSubscription(subscription);
        result.success(null);
    }

    private void requestTrackingAuthorizationWithCompletionHandler(final Result result) {
        result.success("Error. No requestTrackingAuthorizationWithCompletionHandler on Android platform!");
    }

    private void updateConversionValue(final Result result) {
        result.success("Error. No updateConversionValue on Android platform!");
    }

    private void trackThirdPartySharing(final MethodCall call, final Result result) {
        Map thirdPartySharingMap = (Map) call.arguments;
        if (thirdPartySharingMap == null) {
            return;
        }

        Boolean isEnabled = false;
        if (thirdPartySharingMap.containsKey("isEnabled")) {
            isEnabled = (Boolean) thirdPartySharingMap.get("isEnabled");
        }

        // Create third party sharing object.
        AdTraceThirdPartySharing thirdPartySharing = new AdTraceThirdPartySharing(isEnabled);

        // Granular options.
        if (thirdPartySharingMap.containsKey("granularOptions")) {
            String strGranularOptions = (String) thirdPartySharingMap.get("granularOptions");
            String[] arrayGranularOptions = strGranularOptions.split("__ADT__", -1);
            for (int i = 0; i < arrayGranularOptions.length; i += 3) {
                thirdPartySharing.addGranularOption(
                    arrayGranularOptions[i],
                    arrayGranularOptions[i+1],
                    arrayGranularOptions[i+2]);
            }
        }

        // Partner sharing settings.
        if (thirdPartySharingMap.containsKey("partnerSharingSettings")) {
            String strPartnerSharingSettings = (String) thirdPartySharingMap.get("partnerSharingSettings");
            String[] arrayPartnerSharingSettings = strPartnerSharingSettings.split("__ADT__", -1);
            for (int i = 0; i < arrayPartnerSharingSettings.length; i += 3) {
//                thirdPartySharing.addPartnerSharingSetting(
//                    arrayPartnerSharingSettings[i],
//                    arrayPartnerSharingSettings[i+1],
//                    Boolean.parseBoolean(arrayPartnerSharingSettings[i+2]));
            }
        }

        // Track third party sharing.
        AdTrace.trackThirdPartySharing(thirdPartySharing);
        result.success(null);
    }

    private void trackMeasurementConsent(final MethodCall call, final Result result) {
        Map measurementConsentMap = (Map) call.arguments;
        if (!measurementConsentMap.containsKey("measurementConsent")) {
            result.error("0", "Arguments null or wrong (missing argument of 'trackMeasurementConsent' method.", null);
            return;
        }

        boolean measurementConsent = (boolean) measurementConsentMap.get("measurementConsent");
        AdTrace.trackMeasurementConsent(measurementConsent);
        result.success(null);
    }

    private void checkForNewAttStatus(final MethodCall call, final Result result) {
        result.success("Error. No checkForNewAttStatus for Android platform!");
    }

    private void getAppTrackingAuthorizationStatus(final MethodCall call, final Result result) {
        result.success("Error. No getAppTrackingAuthorizationStatus for Android platform!");
    }

    private void getLastDeeplink(final MethodCall call, final Result result) {
        result.success("Error. No getLastDeeplink for Android platform!");
    }

    private void verifyPlayStorePurchase(final MethodCall call, final Result result) {
        Map purchaseMap = (Map) call.arguments;
        if (purchaseMap == null) {
            return;
        }

        // Product ID.
        String productId = null;
        if (purchaseMap.containsKey("productId")) {
            productId = (String) purchaseMap.get("productId");
        }

        // Purchase token.
        String purchaseToken = null;
        if (purchaseMap.containsKey("purchaseToken")) {
            purchaseToken = (String) purchaseMap.get("purchaseToken");
        }

        // Create purchase instance.
        AdTracePurchase purchase = new AdTracePurchase(productId, purchaseToken);

        // Verify purchase.
        AdTrace.verifyPurchase(purchase, new OnPurchaseVerificationFinishedListener() {
            @Override
            public void onVerificationFinished(AdTracePurchaseVerificationResult verificationResult) {
                HashMap<String, String> adtracePurchaseMap = new HashMap<String, String>();
                adtracePurchaseMap.put("code", String.valueOf(verificationResult.getCode()));
                adtracePurchaseMap.put("verificationStatus", verificationResult.getVerificationStatus());
                adtracePurchaseMap.put("message", verificationResult.getMessage());
                result.success(adtracePurchaseMap);
            }
        });
    }

    private void verifyAppStorePurchase(final MethodCall call, final Result result) {
        result.success("Error. No verifyAppStorePurchase for Android platform!");
    }

    private void setTestOptions(final MethodCall call, final Result result) {
        AdTraceTestOptions testOptions = new AdTraceTestOptions();
        Map testOptionsMap = (Map) call.arguments;

        if (testOptionsMap.containsKey("baseUrl")) {
            testOptions.baseUrl = (String) testOptionsMap.get("baseUrl");
        }
        if (testOptionsMap.containsKey("gdprUrl")) {
            testOptions.gdprUrl = (String) testOptionsMap.get("gdprUrl");
        }
        if (testOptionsMap.containsKey("subscriptionUrl")) {
            testOptions.subscriptionUrl = (String) testOptionsMap.get("subscriptionUrl");
        }
        if (testOptionsMap.containsKey("purchaseVerificationUrl")) {
            testOptions.purchaseVerificationUrl = (String) testOptionsMap.get("purchaseVerificationUrl");
        }
        if (testOptionsMap.containsKey("basePath")) {
            testOptions.basePath = (String) testOptionsMap.get("basePath");
        }
        if (testOptionsMap.containsKey("gdprPath")) {
            testOptions.gdprPath = (String) testOptionsMap.get("gdprPath");
        }
        if (testOptionsMap.containsKey("subscriptionPath")) {
            testOptions.subscriptionPath = (String) testOptionsMap.get("subscriptionPath");
        }
        if (testOptionsMap.containsKey("purchaseVerificationPath")) {
            testOptions.purchaseVerificationPath = (String) testOptionsMap.get("purchaseVerificationPath");
        }
        // Kept for the record. Not needed anymore with test options extraction.
        // if (testOptionsMap.containsKey("useTestConnectionOptions")) {
        //     testOptions.useTestConnectionOptions = testOptionsMap.get("useTestConnectionOptions").toString().equals("true");
        // }
        if (testOptionsMap.containsKey("noBackoffWait")) {
            testOptions.noBackoffWait = testOptionsMap.get("noBackoffWait").toString().equals("true");
        }
        if (testOptionsMap.containsKey("teardown")) {
            testOptions.teardown = testOptionsMap.get("teardown").toString().equals("true");
        }
        if (testOptionsMap.containsKey("tryInstallReferrer")) {
            testOptions.tryInstallReferrer = testOptionsMap.get("tryInstallReferrer").toString().equals("true");
        }
        if (testOptionsMap.containsKey("timerIntervalInMilliseconds")) {
            testOptions.timerIntervalInMilliseconds = Long.parseLong(testOptionsMap.get("timerIntervalInMilliseconds").toString());
        }
        if (testOptionsMap.containsKey("timerStartInMilliseconds")) {
            testOptions.timerStartInMilliseconds = Long.parseLong(testOptionsMap.get("timerStartInMilliseconds").toString());
        }
        if (testOptionsMap.containsKey("sessionIntervalInMilliseconds")) {
            testOptions.sessionIntervalInMilliseconds = Long.parseLong(testOptionsMap.get("sessionIntervalInMilliseconds").toString());
        }
        if (testOptionsMap.containsKey("subsessionIntervalInMilliseconds")) {
            testOptions.subsessionIntervalInMilliseconds = Long.parseLong(testOptionsMap.get("subsessionIntervalInMilliseconds").toString());
        }
        if (testOptionsMap.containsKey("deleteState")) {
            testOptions.context = applicationContext;
        }

        AdTrace.setTestOptions(testOptions);
    }
}
