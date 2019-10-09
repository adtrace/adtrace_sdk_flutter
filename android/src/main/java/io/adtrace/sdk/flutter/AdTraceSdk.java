//
//  Created by Aref Hosseini on 7th October 2019.
//


package io.adtrace.sdk.flutter;

import android.content.Context;
import android.net.Uri;
import android.util.Log;

import io.adtrace.sdk.AdTrace;
import io.adtrace.sdk.AdTraceAttribution;
import io.adtrace.sdk.AdTraceConfig;
import io.adtrace.sdk.AdTraceEvent;
import io.adtrace.sdk.AdTraceEventFailure;
import io.adtrace.sdk.AdTraceEventSuccess;
import io.adtrace.sdk.AdTraceSessionFailure;
import io.adtrace.sdk.AdTraceSessionSuccess;
import io.adtrace.sdk.AdTraceTestOptions;
import io.adtrace.sdk.LogLevel;
import io.adtrace.sdk.OnAttributionChangedListener;
import io.adtrace.sdk.OnDeeplinkResponseListener;
import io.adtrace.sdk.OnDeviceIdsRead;
import io.adtrace.sdk.OnEventTrackingFailedListener;
import io.adtrace.sdk.OnEventTrackingSucceededListener;
import io.adtrace.sdk.OnSessionTrackingFailedListener;
import io.adtrace.sdk.OnSessionTrackingSucceededListener;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import static io.adtrace.sdk.flutter.AdTraceUtils.*;

public class AdTraceSdk implements MethodCallHandler {
    private static String TAG = "AdTraceBridge";
    private static boolean launchDeferredDeeplink = true;
    private MethodChannel channel;
    private Context applicationContext;

    AdTraceSdk(MethodChannel channel, Context applicationContext) {
        this.channel = channel;
        this.applicationContext = applicationContext;
    }

    // Plugin registration.
    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "io.adtrace.sdk/api");
        channel.setMethodCallHandler(new AdTraceSdk(channel, registrar.context()));
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
            if (logLevel.equals("suppress")) {
                isLogLevelSuppress = true;
            }
        }

        // Create configuration object.
        AdTraceConfig adTraceConfig = new AdTraceConfig(applicationContext, appToken, environment, isLogLevelSuppress);

        // SDK prefix.
        if (configMap.containsKey("sdkPrefix")) {
            String sdkPrefix = (String) configMap.get("sdkPrefix");
            adTraceConfig.setSdkPrefix(sdkPrefix);
        }

        // Log level.
        if (configMap.containsKey("logLevel")) {
            logLevel = (String) configMap.get("logLevel");
            if (logLevel.equals("verbose")) {
                adTraceConfig.setLogLevel(LogLevel.VERBOSE);
            } else if (logLevel.equals("debug")) {
                adTraceConfig.setLogLevel(LogLevel.DEBUG);
            } else if (logLevel.equals("info")) {
                adTraceConfig.setLogLevel(LogLevel.INFO);
            } else if (logLevel.equals("warn")) {
                adTraceConfig.setLogLevel(LogLevel.WARN);
            } else if (logLevel.equals("error")) {
                adTraceConfig.setLogLevel(LogLevel.ERROR);
            } else if (logLevel.equals("assert")) {
                adTraceConfig.setLogLevel(LogLevel.ASSERT);
            } else if (logLevel.equals("suppress")) {
                adTraceConfig.setLogLevel(LogLevel.SUPRESS);
            } else {
                adTraceConfig.setLogLevel(LogLevel.INFO);
            }
        }

        // Event buffering.
        if (configMap.containsKey("eventBufferingEnabled")) {
            String eventBufferingEnabledString = (String) configMap.get("eventBufferingEnabled");
            boolean eventBufferingEnabled = Boolean.valueOf(eventBufferingEnabledString);
            adTraceConfig.setEventBufferingEnabled(eventBufferingEnabled);
        }

        // Main process name.
        if (configMap.containsKey("processName")) {
            String processName = (String) configMap.get("processName");
            adTraceConfig.setProcessName(processName);
        }

        // Default tracker.
        if (configMap.containsKey("defaultTracker")) {
            String defaultTracker = (String) configMap.get("defaultTracker");
            adTraceConfig.setDefaultTracker(defaultTracker);
        }

        // User agent.
        if (configMap.containsKey("userAgent")) {
            String userAgent = (String) configMap.get("userAgent");
            adTraceConfig.setUserAgent(userAgent);
        }

        // Background tracking.
        if (configMap.containsKey("sendInBackground")) {
            String strSendInBackground = (String) configMap.get("sendInBackground");
            boolean sendInBackground = Boolean.valueOf(strSendInBackground);
            adTraceConfig.setSendInBackground(sendInBackground);
        }

        // Set device known.
        if (configMap.containsKey("isDeviceKnown")) {
            String strIsDeviceKnown = (String) configMap.get("isDeviceKnown");
            boolean isDeviceKnown = Boolean.valueOf(strIsDeviceKnown);
            adTraceConfig.setDeviceKnown(isDeviceKnown);
        }

        // Delayed start.
        if (configMap.containsKey("delayStart")) {
            String strDelayStart = (String) configMap.get("delayStart");
            if (isNumber(strDelayStart)) {
                double delayStart = Double.valueOf(strDelayStart);
                adTraceConfig.setDelayStart(delayStart);
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
                adTraceConfig.setAppSecret(secretId, info1, info2, info3, info4);
            } catch (NumberFormatException ignore) {}
        }

        // Launch deferred deep link.
        if (configMap.containsKey("launchDeferredDeeplink")) {
            String strLaunchDeferredDeeplink = (String) configMap.get("launchDeferredDeeplink");
            this.launchDeferredDeeplink = strLaunchDeferredDeeplink.equals("true");
        }

        // Attribution callback.
        if (configMap.containsKey("attributionCallback")) {
            final String dartMethodName = (String) configMap.get("attributionCallback");
            adTraceConfig.setOnAttributionChangedListener(new OnAttributionChangedListener() {
                @Override
                public void onAttributionChanged(AdTraceAttribution adTraceAttribution) {
                    HashMap<String, String> adTraceAttributionMap = new HashMap<String, String>();
                    adTraceAttributionMap.put("trackerToken", adTraceAttribution.trackerToken);
                    adTraceAttributionMap.put("trackerName", adTraceAttribution.trackerName);
                    adTraceAttributionMap.put("network", adTraceAttribution.network);
                    adTraceAttributionMap.put("campaign", adTraceAttribution.campaign);
                    adTraceAttributionMap.put("adgroup", adTraceAttribution.adgroup);
                    adTraceAttributionMap.put("creative", adTraceAttribution.creative);
                    adTraceAttributionMap.put("clickLabel", adTraceAttribution.clickLabel);
                    adTraceAttributionMap.put("adid", adTraceAttribution.adid);
                    channel.invokeMethod(dartMethodName, adTraceAttributionMap);
                }
            });
        }

        // Session success callback.
        if (configMap.containsKey("sessionSuccessCallback")) {
            final String dartMethodName = (String) configMap.get("sessionSuccessCallback");
            adTraceConfig.setOnSessionTrackingSucceededListener(new OnSessionTrackingSucceededListener() {
                @Override
                public void onFinishedSessionTrackingSucceeded(AdTraceSessionSuccess adTraceSessionSuccess) {
                    HashMap<String, String> adTraceSessionSuccessMap = new HashMap<String, String>();
                    adTraceSessionSuccessMap.put("message", adTraceSessionSuccess.message);
                    adTraceSessionSuccessMap.put("timestamp", adTraceSessionSuccess.timestamp);
                    adTraceSessionSuccessMap.put("adid", adTraceSessionSuccess.adid);
                    if (adTraceSessionSuccess.jsonResponse != null) {
                        adTraceSessionSuccessMap.put("jsonResponse", adTraceSessionSuccess.jsonResponse.toString());
                    }
                    channel.invokeMethod(dartMethodName, adTraceSessionSuccessMap);
                }
            });
        }

        // Session failure callback.
        if (configMap.containsKey("sessionFailureCallback")) {
            final String dartMethodName = (String) configMap.get("sessionFailureCallback");
            adTraceConfig.setOnSessionTrackingFailedListener(new OnSessionTrackingFailedListener() {
                @Override
                public void onFinishedSessionTrackingFailed(AdTraceSessionFailure adTraceSessionFailure) {
                    HashMap<String, String> adTraceSessionFailureMap = new HashMap<String, String>();
                    adTraceSessionFailureMap.put("message", adTraceSessionFailure.message);
                    adTraceSessionFailureMap.put("timestamp", adTraceSessionFailure.timestamp);
                    adTraceSessionFailureMap.put("adid", adTraceSessionFailure.adid);
                    adTraceSessionFailureMap.put("willRetry", Boolean.toString(adTraceSessionFailure.willRetry));
                    if (adTraceSessionFailure.jsonResponse != null) {
                        adTraceSessionFailureMap.put("jsonResponse", adTraceSessionFailure.jsonResponse.toString());
                    }
                    channel.invokeMethod(dartMethodName, adTraceSessionFailureMap);
                }
            });
        }

        // Event success callback.
        if (configMap.containsKey("eventSuccessCallback")) {
            final String dartMethodName = (String) configMap.get("eventSuccessCallback");
            adTraceConfig.setOnEventTrackingSucceededListener(new OnEventTrackingSucceededListener() {
                @Override
                public void onFinishedEventTrackingSucceeded(AdTraceEventSuccess adTraceEventSuccess) {
                    HashMap<String, String> adTraceEventSuccessMap = new HashMap<String, String>();
                    adTraceEventSuccessMap.put("message", adTraceEventSuccess.message);
                    adTraceEventSuccessMap.put("timestamp", adTraceEventSuccess.timestamp);
                    adTraceEventSuccessMap.put("adid", adTraceEventSuccess.adid);
                    adTraceEventSuccessMap.put("eventToken", adTraceEventSuccess.eventToken);
                    adTraceEventSuccessMap.put("callbackId", adTraceEventSuccess.callbackId);
                    if (adTraceEventSuccess.jsonResponse != null) {
                        adTraceEventSuccessMap.put("jsonResponse", adTraceEventSuccess.jsonResponse.toString());
                    }
                    channel.invokeMethod(dartMethodName, adTraceEventSuccessMap);
                }
            });
        }

        // Event failure callback.
        if (configMap.containsKey("eventFailureCallback")) {
            final String dartMethodName = (String) configMap.get("eventFailureCallback");
            adTraceConfig.setOnEventTrackingFailedListener(new OnEventTrackingFailedListener() {
                @Override
                public void onFinishedEventTrackingFailed(AdTraceEventFailure adTraceEventFailure) {
                    HashMap<String, String> adTraceEventFailureMap = new HashMap<String, String>();
                    adTraceEventFailureMap.put("message", adTraceEventFailure.message);
                    adTraceEventFailureMap.put("timestamp", adTraceEventFailure.timestamp);
                    adTraceEventFailureMap.put("adid", adTraceEventFailure.adid);
                    adTraceEventFailureMap.put("eventToken", adTraceEventFailure.eventToken);
                    adTraceEventFailureMap.put("callbackId", adTraceEventFailure.callbackId);
                    adTraceEventFailureMap.put("willRetry", Boolean.toString(adTraceEventFailure.willRetry));
                    if (adTraceEventFailure.jsonResponse != null) {
                        adTraceEventFailureMap.put("jsonResponse", adTraceEventFailure.jsonResponse.toString());
                    }
                    channel.invokeMethod(dartMethodName, adTraceEventFailureMap);
                }
            });
        }

        // Deferred deep link callback.
        if (configMap.containsKey("deferredDeeplinkCallback")) {
            final String dartMethodName = (String) configMap.get("deferredDeeplinkCallback");
            adTraceConfig.setOnDeeplinkResponseListener(new OnDeeplinkResponseListener() {
                @Override
                public boolean launchReceivedDeeplink(Uri uri) {
                    HashMap<String, String> uriParamsMap = new HashMap<String, String>();
                    uriParamsMap.put("uri", uri.toString());
                    channel.invokeMethod(dartMethodName, uriParamsMap);
                    return launchDeferredDeeplink;
                }
            });
        }

        // Start SDK.
        AdTrace.onCreate(adTraceConfig);
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

        // Partner parameters.
        if (eventMap.containsKey("partnerParameters")) {
            String strPartnerParametersJson = (String) eventMap.get("partnerParameters");
            try {
                JSONObject jsonPartnerParameters = new JSONObject(strPartnerParametersJson);
                JSONArray partnerParametersKeys = jsonPartnerParameters.names();
                for (int i = 0; i < partnerParametersKeys.length(); ++i) {
                    String key = partnerParametersKeys.getString(i);
                    String value = jsonPartnerParameters.getString(key);
                    event.addPartnerParameter(key, value);
                }
            } catch (JSONException e) {
                Log.e(TAG, "Failed to parse event partner parameter! Details: " + e);
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
        result.error("0", "Error. No IDFA for Android plaftorm!", null);
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

    private void getAttribution(final Result result) {
        AdTraceAttribution adTraceAttribution = AdTrace.getAttribution();
        if (adTraceAttribution == null) {
            adTraceAttribution = new AdTraceAttribution();
        }

        HashMap<String, String> adTraceAttributionMap = new HashMap<String, String>();
        adTraceAttributionMap.put("trackerToken", adTraceAttribution.trackerToken);
        adTraceAttributionMap.put("trackerName", adTraceAttribution.trackerName);
        adTraceAttributionMap.put("network", adTraceAttribution.network);
        adTraceAttributionMap.put("campaign", adTraceAttribution.campaign);
        adTraceAttributionMap.put("adgroup", adTraceAttribution.adgroup);
        adTraceAttributionMap.put("creative", adTraceAttribution.creative);
        adTraceAttributionMap.put("clickLabel", adTraceAttribution.clickLabel);
        adTraceAttributionMap.put("adid", adTraceAttribution.adid);
        result.success(adTraceAttributionMap);
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

    private void setTestOptions(final MethodCall call, final Result result) {
        AdTraceTestOptions testOptions = new AdTraceTestOptions();
        Map testOptionsMap = (Map) call.arguments;

        if (testOptionsMap.containsKey("baseUrl")) {
            testOptions.baseUrl = (String) testOptionsMap.get("baseUrl");
        }
        if (testOptionsMap.containsKey("gdprUrl")) {
            testOptions.gdprUrl = (String) testOptionsMap.get("gdprUrl");
        }
        if (testOptionsMap.containsKey("basePath")) {
            testOptions.basePath = (String) testOptionsMap.get("basePath");
        }
        if (testOptionsMap.containsKey("gdprPath")) {
            testOptions.gdprPath = (String) testOptionsMap.get("gdprPath");
        }
        if (testOptionsMap.containsKey("useTestConnectionOptions")) {
            testOptions.useTestConnectionOptions = testOptionsMap.get("useTestConnectionOptions").toString().equals("true");
        }
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
