## Summary

This is the Flutter SDK of AdTrace. You can read more about AdTrace at [adtrace.io].

## Table of contents

### Quick start

* [Example apps](#qs-example-apps)
* [Getting started](#qs-getting-started)
    * [Add the SDK to your project](#qs-add-sdk)
    * [[Android] Add Google Play Services](#qs-gps)
    * [[Android] Add permissions](#qs-permissions)
    * [[Android] Proguard settings](#qs-proguard)
    * [[Android] Install referrer](#qs-install-referrer)
        * [[Android] Google Play Referrer API](#qs-gpr-api)
        * [[Android] Google Play Store intent](#qs-gps-intent)
        * [[Android] Huawei Referrer API](#qs-hr-api)
        * [[iOS] Link additional frameworks](#qs-ios-frameworks)
* [Integrate the SDK into your app](#qs-integrate-sdk)
    * [Basic setup](#qs-basic-setup)
    * [Session tracking](#qs-session-tracking)
        * [Session tracking in Android](#qs-session-tracking-android)
    * [SDK signature](#qs-sdk-signature)
    * [AdTrace logging](#qs-adtrace-logging)
    * [Build your app](#qs-build-the-app)

### Deep linking

* [Deep linking](#dl)
* [Standard deep linking scenario](#dl-standard)
* [Deferred deep linking scenario](#dl-deferred)
* [Deep linking handling in Android app](#dl-app-android)
* [Deep linking handling in iOS app](#dl-app-ios)

### Event tracking

* [Track event](#et-tracking)
* [Track revenue](#et-revenue)

### Custom parameters

* [Event parameters](#cp-event-parameters)
    * [Event callback parameters](#cp-event-callback-parameters)
    * [Event value parameters](#cp-event-value-parameters)
    * [Event callback identifier](#cp-event-callback-id)
* [Session parameters](#cp-session-parameters)
    * [Session callback parameters](#cp-session-callback-parameters)
    * [Delay start](#cp-delay-start)

### Additional features

* [SKAdNetwork framework](#af-skadn-framework)
    * [Update SKAdNetwork conversion value](#af-skadn-update-conversion-value)
    * [Conversion value updated callback](#af-skadn-cv-updated-callback)
* [Push token (uninstall tracking)](#af-push-token)
* [Attribution callback](#af-attribution-callback)
* [Session and event callbacks](#af-session-event-callbacks)
* [User attribution](#af-user-attribution)
* [Device IDs](#af-device-ids)
    * [iOS advertising identifier](#af-idfa)
    * [Google Play Services advertising identifier](#af-gps-adid)
    * [AdTrace device identifier](#af-adid)
* [Set external device ID](#set-external-device-id)
* [Offline mode](#af-offline-mode)
* [Disable tracking](#af-disable-tracking)
* [Event buffering](#af-event-buffering)
* [Background tracking](#af-background-tracking)



### License


## Quick start

### <a id="qs-example-apps"></a>Example apps

There are example Flutter app inside the [`example` directory][example-app]. In there you can check how the AdTrace SDK can be integrated.

### <a id="qs-getting-started"></a>Getting started

These are the minimal steps required to integrate the AdTrace SDK into your Flutter app.

### <a id="qs-add-sdk"></a>Add the SDK to your project

You can add AdTrace SDK to your Flutter app by adding following to your `pubspec.yaml` file:

```yaml
dependencies:
  adtrace_sdk_flutter: ^1.1.1
```

Then navigate to your project in the terminal and run:

```
flutter packages get
```

**Note**: If you are using Visual Studio Code to develop your app, upon editing `pubspec.yaml`, it will automatically run this command, so you don't need to run it manually.

### <a id="qs-gps"></a>[Android] Add Google Play Services

Since the 1st of August of 2014, apps in the Google Play Store must use the [Google Advertising ID][google-ad-id] to uniquely identify devices. To allow the AdTrace SDK to use the Google Advertising ID, you must integrate the [Google Play Services][google-play-services]. If you haven't done this yet, please add dependency to Google Play Services library by adding following dependecy to your `dependencies` block of app's `build.gradle` file for Android platform:

```gradle
implementation 'com.google.android.gms:play-services-ads-identifier:18.0.1'
```

**Note**: The AdTrace SDK is not tied to any specific version of the `play-services-ads-identifier` part of the Google Play Services library. You can use the latest version of the library, or any other version you need.

### <a id="qs-permissions"></a>[Android] Add permissions

Please add the following permissions, which the AdTrace SDK needs, if they are not already present in your `AndroidManifest.xml` file for Android platform:

```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
```

If you are **not targeting the Google Play Store**, please also add the following permission:

```xml
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE"/>
```

#### <a id="gps-adid-permission"></a>Add permission to gather Google advertising ID

If you are targeting Android 12 and above (API level 31), you need to add the `com.google.android.gms.AD_ID` permission to read the device's advertising ID. Add the following line to your `AndroidManifest.xml` to enable the permission.

```xml
<uses-permission android:name="com.google.android.gms.permission.AD_ID"/>
```

For more information, see [Google's `AdvertisingIdClient.Info` documentation](https://developers.google.com/android/reference/com/google/android/gms/ads/identifier/AdvertisingIdClient.Info#public-string-getid).

### <a id="qs-proguard"></a>[Android] Proguard settings

If you are using Proguard, add these lines to your Proguard file:

```
-keep class io.adtrace.sdk.** { *; }
-keep class com.google.android.gms.common.ConnectionResult {
    int SUCCESS;
}
-keep class com.google.android.gms.ads.identifier.AdvertisingIdClient {
    com.google.android.gms.ads.identifier.AdvertisingIdClient$Info getAdvertisingIdInfo(android.content.Context);
}
-keep class com.google.android.gms.ads.identifier.AdvertisingIdClient$Info {
    java.lang.String getId();
    boolean isLimitAdTrackingEnabled();
}
-keep public class com.android.installreferrer.** { *; }
```

If you are **not publishing your app in the Google Play Store**, you can leave just `io.adtrace.sdk` package rules:

```
-keep public class io.adtrace.sdk.** { *; }
```

### <a id="qs-install-referrer"></a>[Android] Install referrer

In order to correctly attribute an install of your app to its source, AdTrace needs information about the **install referrer**. This can be obtained by using the **Google Play Referrer API** or by catching the **Google Play Store intent** with a broadcast receiver.

**Important**: The Google Play Referrer API is newly introduced by Google with the express purpose of providing a more reliable and secure way of obtaining install referrer information and to aid attribution providers in the fight against click injection. It is **strongly advised** that you support this in your application. The Google Play Store intent is a less secure way of obtaining install referrer information. It will continue to exist in parallel with the new Google Play Referrer API temporarily, but it is set to be deprecated in future.

### <a id="qs-gpr-api"></a>[Android] Google Play Referrer API

In order to support this in your app, please make sure to add following dependency to your app's `build.gradle` file for Android platform:

```
implementation 'com.android.installreferrer:installreferrer:1.0'
```

Also, make sure that you have paid attention to the [Proguard settings](#qs-proguard) chapter and that you have added all the rules mentioned in it, especially the one needed for this feature:

```
-keep public class com.android.installreferrer.** { *; }
```

### <a id="qs-gps-intent"></a>[Android] Google Play Store intent

The Google Play Store `INSTALL_REFERRER` intent should be captured with a broadcast receiver. If you are **not using your own broadcast receiver** to receive the `INSTALL_REFERRER` intent, add the following `receiver` tag inside the `application` tag in your `AndroidManifest.xml` file for Android platform.

```xml
<receiver
    android:name="io.adtrace.sdk.AdTraceReferrerReceiver"
    android:permission="android.permission.INSTALL_PACKAGES"
    android:exported="true" >
    <intent-filter>
        <action android:name="com.android.vending.INSTALL_REFERRER" />
    </intent-filter>
</receiver>
```

We use this broadcast receiver to retrieve the install referrer and pass it to our backend.

If you are already using a different broadcast receiver for the `INSTALL_REFERRER` intent, follow [these instructions][multiple-receivers] to add the AdTrace broadcast receiver.

#### <a id="qs-hr-api"></a>[Android] Huawei Referrer API

As of v2.0.2, the AdTrace SDK supports install tracking on Huawei devices with Huawei App Gallery version 10.4 and higher. No additional integration steps are needed to start using the Huawei Referrer API.

#### <a id="qs-ios-frameworks"></a>[iOS] Link additional frameworks

Make sure that following iOS frameworks are linked with your iOS app:

* `iAd.framework` - in case you are running iAd campaigns
* `AdServices.framework` - in case you are running iAd campaigns
* `AdSupport.framework` - for reading iOS Advertising Id (IDFA)
* `CoreTelephony.framework` - for reading MCC and MNC information
* `StoreKit.framework` - for communication with SKAdNetwork framework
* `AppTrackingTransparency.framework` - to ask for user's consent to be tracked and obtain status of that consent

All of these frameworks are enabling certain SDK features, but they are not mandatory for SDK to work normally. With this in mind, you can set **Status** of each one of these frameworks to **Optional** in your **Project Settings → Build Phases → Link Binary With Libraries** section.

### <a id="qs-integrate-sdk"></a>Integrate the SDK into your app

To start with, we'll set up basic session tracking.

### <a id="qs-basic-setup"></a>Basic setup

Make sure to initialise AdTrace SDK as soon as possible in your Flutter app (upon loading first widget in your app). You can initialise AdTrace SDK like described below:

```dart
AdTraceConfig config = new AdTraceConfig('{YourAppToken}', AdTraceEnvironment.sandbox);
AdTrace.start(config);
```

Replace `{YourAppToken}` with your app token. You can find this in your [dashboard].

Depending on whether you are building your app for testing or for production, you must set `environment` with one of these values:

```dart
AdTraceEnvironment.sandbox;
AdTraceEnvironment.production;
```

**Important:** This value should be set to `AdTraceEnvironment.sandbox` if and only if you or someone else is testing your app. Make sure to set the environment to `AdTraceEnvironment.production` before you publish the app. Set it back to `AdTraceEnvironment.sandbox` when you start developing and testing it again.

We use this environment to distinguish between real traffic and test traffic from test devices. It is imperative that you keep this value meaningful at all times!

### <a id="qs-session-tracking"></a>Session tracking

**Note**: This step is **really important** and please **make sure that you implement it properly in your app**. By implementing it, you will enable proper session tracking by the AdTrace SDK in your app.

Session tracking for iOS platform is supported out of the box, but in order to perform it properly on Android platform, it requires a bit of additional work described in chapter below.

### <a id="qs-session-tracking-android"></a>Session tracking in Android

On Android platform, it is important for you to hook up into app activity lifecycle methods and make a call to `AdTrace.onResume()` when ever app enters foreground and a call to `AdTrace.onPause()` when ever app leaves foreground. You can do this globally or per widget (call these method upon each transition from one widget to another). For example:

```dart
class AdTraceExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'AdTrace Flutter Example App',
      home: new MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  State createState() => new MainScreenState();
}

class MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initPlatformState(); // <-- Initialise SDK in here.
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.resumed:
        AdTrace.onResume();
        break;
      case AppLifecycleState.paused:
        AdTrace.onPause();
        break;
      case AppLifecycleState.suspending:
        break;
    }
  }
}
```

### <a id="qs-sdk-signature"></a>SDK signature

An account manager must activate the AdTrace SDK signature. Contact AdTrace support (support@adtrace.com) if you are interested in using this feature.

If the SDK signature has already been enabled on your account and you have access to App Secrets in your AdTrace Dashboard, please use the method below to integrate the SDK signature into your app.

An App Secret is set by calling `setAppSecret` on your config instance:

```dart
AdTraceConfig adtraceConfig = new AdTraceConfig(yourAppToken, environment);
adtraceConfig.setAppSecret(secretId, info1, info2, info3, info4);
AdTrace.start(adtraceConfig);
```

### <a id="qs-adtrace-logging"></a>AdTrace logging

You can increase or decrease the amount of logs that you see during testing by setting `logLevel` member on your config instance with one of the following parameters:

```java
adtraceConfig.logLevel = AdTraceLogLevel.verbose; // enable all logs
adtraceConfig.logLevel = AdTraceLogLevel.debug; // disable verbose logs
adtraceConfig.logLevel = AdTraceLogLevel.info; // disable debug logs (default)
adtraceConfig.logLevel = AdTraceLogLevel.warn; // disable info logs
adtraceConfig.logLevel = AdTraceLogLevel.error; // disable warning logs
adtraceConfig.logLevel = AdTraceLogLevel.suppress; // disable all logs
```

### <a id="qs-build-the-app"></a>Build your app

Build and run your Flutter app. In your Android/iOS log you can check for logs coming from AdTrace SDK and in there you should see message: `Install tracked`.

## Deep linking

### <a id="dl"></a>Deep linking

If you are using an AdTrace tracker URL with the option to deep link into your app, there is the possibility to get information about the deep link URL and its content. Hitting the URL can happen when the user has your app already installed (standard deep linking scenario) or if they don't have the app on their device (deferred deep linking scenario). In the standard deep linking scenario, the Android platform natively offers the possibility for you to get the information about the deep link content. The deferred deep linking scenario is something which the Android platform doesn't support out of the box, and, in this case, the AdTrace SDK will offer you the mechanism you need to get the information about the deep link content.

You need to set up deep linking handling in your app **on native level** - in your generated Xcode project (for iOS) and Android Studio (for Android).

### <a id="dl-standard"></a>Standard deep linking scenario

Unfortunately, in this scenario the information about the deep link can not be delivered to you in your Dart code. Once you enable your app to handle deep linking, you will get information about the deep link on native level. For more information check our chapters below on how to enable deep linking for Android and iOS apps.

### <a id="dl-deferred"></a>Deferred deep linking scenario

In order to get information about the URL content in a deferred deep linking scenario, you should set a callback method on the config object which will receive one `string` parameter where the content of the URL will be delivered. You should set this method on the config object by assigning the `deferredDeeplinkCallback` member:

```dart
AdTraceConfig adtraceConfig = new AdTraceConfig(yourAppToken, environment);
adtraceConfig.deferredDeeplinkCallback = (String uri) {
  print('[AdTrace]: Received deferred deeplink: ' + uri);
};
AdTrace.start(adtraceConfig);
```

In deferred deep linking scenario, there is one additional setting which can be set on the config object. Once the AdTrace SDK gets the deferred deep link information, we offer you the possibility to choose whether our SDK should open this URL or not. You can choose to set this option by assigning the `launchDeferredDeeplink` member of the config instance:

```dart
AdTraceConfig adtraceConfig = new AdTraceConfig(yourAppToken, environment);
adtraceConfig.launchDeferredDeeplink = true;
adtraceConfig.deferredDeeplinkCallback = (String uri) {
  print('[AdTrace]: Received deferred deeplink: ' + uri);
};
AdTrace.start(adtraceConfig);
```

If nothing is set, **the AdTrace SDK will always try to launch the URL by default**.

To enable your apps to support deep linking, you should set up schemes for each supported platform.

### <a id="dl-app-android"></a>Deep linking handling in Android app

**This should be done in native Android Studio / Eclipse project.**

To set up your Android app to handle deep linking on native level, please follow our [guide][android-deeplinking] in the official Android SDK README.

### <a id="dl-app-ios"></a>Deep linking handling in iOS app

**This should be done in native Xcode project.**

To set up your iOS app (`Runner` project) to handle deep linking on native level, please follow our [guide][ios-deeplinking] in the official iOS SDK README.


## Event tracking

### <a id="et-tracking"></a>Track event

You can use adtrace to track any event in your app. Suppose you want to track every tap on a button. You would have to create a new event token in your [dashboard]. Let's say that event token is `abc123`. In your button's click handler method you could then add the following lines to track the click:

```dart
AdTraceEvent adtraceEvent = new AdTraceEvent('abc123');
AdTrace.trackEvent(adtraceEvent);
```

### <a id="et-revenue"></a>Track revenue

If your users can generate revenue by tapping on advertisements or making in-app purchases you can track those revenues with events. Lets say a tap is worth one Euro cent. You could then track the revenue event like this:

```dart
AdTraceEvent adtraceEvent = new AdTraceEvent('abc123');
adtraceEvent.setRevenue(6, 'Toman');
AdTrace.trackEvent(adtraceEvent);
```

This can be combined with callback parameters of course.

When you set a currency token, AdTrace will automatically convert the incoming revenues into a reporting revenue of your choice. Read more about [currency conversion here][currency-conversion].

You can read more about revenue and event tracking in the [event tracking guide][event-tracking].

## Custom parameters

### <a id="cp"></a>Custom parameters

In addition to the data points that AdTrace SDK collects by default, you can use the AdTrace SDK to track and add to the event/session as many custom values as you need (user IDs, product IDs, etc.). Custom parameters are only available as raw data (i.e., they won't appear in the AdTrace dashboard).

You should use **callback parameters** for the values that you collect for your own internal use, and **partner parameters** for those that you wish to share with external partners. If a value (e.g. product ID) is tracked both for internal use and to forward it to external partners, the best practice would be to track it both as callback and partner parameters.


### <a id="cp-event-parameters"></a>Event parameters

### <a id="cp-event-callback-parameters"></a>Event callback parameters

You can register a callback URL for your events in your [dashboard]. We will send a GET request to that URL whenever the event is tracked. You can add callback parameters to that event by calling `addCallbackParameter` to the event instance before tracking it. We will then append these parameters to your callback URL.

For example, suppose you have registered the URL `https://www.adtrace.com/callback` then track an event like this:

```dart
AdTraceEvent adtraceEvent = new AdTraceEvent('abc123');
adtraceEvent.addCallbackParameter('key', 'value');
adtraceEvent.addCallbackParameter('foo', 'bar');
AdTrace.trackEvent(adtraceEvent);
```

In that case we would track the event and send a request to:

```
https://www.adtrace.com/callback?key=value&foo=bar
```

It should be mentioned that we support a variety of placeholders like `{gps_adid}` that can be used as parameter values. In the resulting callback this placeholder would be replaced with the Google Play Services ID of the current device. Also note that we don't store any of your custom parameters, but only append them to your callbacks. If you haven't registered a callback for an event, these parameters won't even be read.

You can read more about using URL callbacks, including a full list of available values, in our [callbacks guide][callbacks-guide].

### <a id="cp-event-value-parameters"></a>Event value parameters

You can also add parameters to be transmitted with the event, which have been activated in your AdTrace dashboard.

```dart
AdTraceEvent adtraceEvent = new AdTraceEvent('abc123');
adtraceEvent.addEventParameter('key', 'value');
adtraceEvent.addEventParameter('foo', 'bar');
AdTrace.trackEvent(adtraceEvent);
```


### <a id="cp-event-callback-id"></a>Event callback identifier

You can also add custom string identifier to each event you want to track. This identifier will later be reported in event success and/or event failure callbacks to enable you to keep track on which event was successfully tracked or not. You can set this identifier by assigning the `callbackId` member of your event instance:

```dart
AdTraceEvent adtraceEvent = new AdTraceEvent('abc123');
adtraceEvent.callbackId = '{CallbackId}';
AdTrace.trackEvent(adtraceEvent);
```

### <a id="cp-session-parameters"></a>Session parameters

Some parameters are saved to be sent in every **event** and **session** of the AdTrace SDK. Once you have added any of these parameters, you don't need to add them every time, since they will be saved locally. If you add the same parameter twice, there will be no effect.

These session parameters can be called before the AdTrace SDK is launched to make sure they are sent even on install. If you need to send them with an install, but can only obtain the needed values after launch, it's possible to [delay](#delay-start) the first launch of the AdTrace SDK to allow this behaviour.

### <a id="cp-session-callback-parameters"></a>Session callback parameters

The same callback parameters that are registered for [events](#event-callback-parameters) can be also saved to be sent in every  event or session of the AdTrace SDK.

The session callback parameters have a similar interface to the event callback parameters. Instead of adding the key and it's value to an event, it's added through a call to `AdTrace.addSessionCallbackParameter(String key, String value)`:

```dart
AdTrace.addSessionCallbackParameter('foo', 'bar');
```

The session callback parameters will be merged with the callback parameters added to an event. The callback parameters added to an event have precedence over the session callback parameters. Meaning that, when adding a callback parameter to an event with the same key to one added from the session, the value that prevails is the callback parameter added to the event.

It's possible to remove a specific session callback parameter by passing the desiring key to the method `AdTrace.removeSessionCallbackParameter(String key)`.

```dart
AdTrace.removeSessionCallbackParameter('foo');
```

If you wish to remove all keys and their corresponding values from the session callback parameters, you can reset it with the method `AdTrace.resetSessionCallbackParameters()`.

```dart
AdTrace.resetSessionCallbackParameters();
```

### <a id="cp-delay-start"></a>Delay start

Delaying the start of the AdTrace SDK allows your app some time to obtain session parameters, such as unique identifiers, to be sent on install.

Set the initial delay time in seconds with the `delayStart` member of the config instance:

```dart
adtraceConfig.delayStart = 5.5;
```

In this case, this will make the AdTrace SDK not send the initial install session and any event created for 5.5 seconds. After this time is expired or if you call `AdTrace.sendFirstPackages()` in the meanwhile, every session parameter will be added to the delayed install session and events and the AdTrace SDK will resume as usual.

**The maximum delay start time of the adtrace SDK is 10 seconds**.


## Additional features

### <a id="af"></a> Additional features

Once you have integrated the AdTrace SDK into your project, you can take advantage of the following features.




### <a id="af-skadn-framework"></a>SKAdNetwork framework

**Note**: This feature exists only in iOS platform.

If you have implemented the AdTrace SDK v4.23.0 or above and your app is running on iOS 14 and above, the communication with SKAdNetwork will be set on by default, although you can choose to turn it off. When set on, AdTrace automatically registers for SKAdNetwork attribution when the SDK is initialized. If events are set up in the AdTrace dashboard to receive conversion values, the AdTrace backend sends the conversion value data to the SDK. The SDK then sets the conversion value. After AdTrace receives the SKAdNetwork callback data, it is then displayed in the dashboard.

In case you don't want the AdTrace SDK to automatically communicate with SKAdNetwork, you can disable that by calling the following method on configuration object:

```dart
adtraceConfig.deactivateSKAdNetworkHandling();
```

### <a id="af-skadn-update-conversion-value"></a>Update SKAdNetwork conversion value

**Note**: This feature exists only in iOS platform.

You can use AdTrace SDK wrapper method `updateConversionValue` to update SKAdNetwork conversion value for your user:

```dart
AdTrace.updateConversionValue(6);
```


### <a id="af-push-token"></a>Push token (uninstall tracking)

Push tokens are used for Audience Builder and client callbacks, and they are required for uninstall and reinstall tracking.

To send us the push notification token, add the following call to AdTrace once you have obtained your token or when ever it's value is changed:

```dart
AdTrace.setPushToken('{PushNotificationsToken}');
```

### <a id="af-attribution-callback"></a>Attribution callback

You can register a callback to be notified of tracker attribution changes. Due to the different sources considered for attribution, this information can not be provided synchronously.

Please make sure to consider our [applicable attribution data policies][attribution-data].

With the config instance, before starting the SDK, add the attribution callback:

```dart
AdTraceConfig adtraceConfig = new AdTraceConfig(yourAppToken, environment);
config.attributionCallback = (AdTraceAttribution attributionChangedData) {
  print('[AdTrace]: Attribution changed!');

  if (attributionChangedData.trackerToken != null) {
    print('[AdTrace]: Tracker token: ' + attributionChangedData.trackerToken);
  }
  if (attributionChangedData.trackerName != null) {
    print('[AdTrace]: Tracker name: ' + attributionChangedData.trackerName);
  }
  if (attributionChangedData.campaign != null) {
    print('[AdTrace]: Campaign: ' + attributionChangedData.campaign);
  }
  if (attributionChangedData.network != null) {
    print('[AdTrace]: Network: ' + attributionChangedData.network);
  }
  if (attributionChangedData.creative != null) {
    print('[AdTrace]: Creative: ' + attributionChangedData.creative);
  }
  if (attributionChangedData.adgroup != null) {
    print('[AdTrace]: Adgroup: ' + attributionChangedData.adgroup);
  }
  if (attributionChangedData.clickLabel != null) {
    print('[AdTrace]: Click label: ' + attributionChangedData.clickLabel);
  }
  if (attributionChangedData.adid != null) {
    print('[AdTrace]: Adid: ' + attributionChangedData.adid);
  }
};
AdTrace.start(adtraceConfig);
```

The callback function will be called after the SDK receives the final attribution data. Within the callback function you have access to the `attribution` parameter. Here is a quick summary of its properties:

- `trackerToken` the tracker token string of the current attribution.
- `trackerName` the tracker name string of the current attribution.
- `network` the network grouping level string of the current attribution.
- `campaign` the campaign grouping level string of the current attribution.
- `adgroup` the ad group grouping level string of the current attribution.
- `creative` the creative grouping level string of the current attribution.
- `clickLabel` the click label string of the current attribution.
- `adid` the AdTrace device identifier string.
- `costType` the cost type string
- `costAmount` the cost amount
- `costCurrency` the cost currency string

**Note**: The cost data - `costType`, `costAmount` & `costCurrency` are only available when configured in `AdTraceConfig` by setting `needsCost` member to `true`. If not configured or configured, but not being part of the attribution, these fields will have value `null`. This feature is available in SDK v4.26.0 and later.

### <a id="af-session-event-callbacks"></a>Session and event callbacks

You can register a callback to be notified when events or sessions are tracked. There are four callbacks: one for tracking successful events, one for tracking failed events, one for tracking successful sessions and one for tracking failed sessions. You can add any number of callbacks after creating the config object:

```dart
AdTraceConfig adtraceConfig = new AdTraceConfig(yourAppToken, environment);

// Set session success tracking delegate.
config.sessionSuccessCallback = (AdTraceSessionSuccess sessionSuccessData) {
  print('[AdTrace]: Session tracking success!');

  if (sessionSuccessData.message != null) {
    print('[AdTrace]: Message: ' + sessionSuccessData.message);
  }
  if (sessionSuccessData.timestamp != null) {
    print('[AdTrace]: Timestamp: ' + sessionSuccessData.timestamp);
  }
  if (sessionSuccessData.adid != null) {
    print('[AdTrace]: Adid: ' + sessionSuccessData.adid);
  }
  if (sessionSuccessData.jsonResponse != null) {
    print('[AdTrace]: JSON response: ' + sessionSuccessData.jsonResponse);
  }
};

// Set session failure tracking delegate.
config.sessionFailureCallback = (AdTraceSessionFailure sessionFailureData) {
  print('[AdTrace]: Session tracking failure!');

  if (sessionFailureData.message != null) {
    print('[AdTrace]: Message: ' + sessionFailureData.message);
  }
  if (sessionFailureData.timestamp != null) {
    print('[AdTrace]: Timestamp: ' + sessionFailureData.timestamp);
  }
  if (sessionFailureData.adid != null) {
    print('[AdTrace]: Adid: ' + sessionFailureData.adid);
  }
  if (sessionFailureData.willRetry != null) {
    print('[AdTrace]: Will retry: ' + sessionFailureData.willRetry.toString());
  }
  if (sessionFailureData.jsonResponse != null) {
    print('[AdTrace]: JSON response: ' + sessionFailureData.jsonResponse);
  }
};

// Set event success tracking delegate.
config.eventSuccessCallback = (AdTraceEventSuccess eventSuccessData) {
  print('[AdTrace]: Event tracking success!');

  if (eventSuccessData.eventToken != null) {
    print('[AdTrace]: Event token: ' + eventSuccessData.eventToken);
  }
  if (eventSuccessData.message != null) {
    print('[AdTrace]: Message: ' + eventSuccessData.message);
  }
  if (eventSuccessData.timestamp != null) {
    print('[AdTrace]: Timestamp: ' + eventSuccessData.timestamp);
  }
  if (eventSuccessData.adid != null) {
    print('[AdTrace]: Adid: ' + eventSuccessData.adid);
  }
  if (eventSuccessData.callbackId != null) {
    print('[AdTrace]: Callback ID: ' + eventSuccessData.callbackId);
  }
  if (eventSuccessData.jsonResponse != null) {
    print('[AdTrace]: JSON response: ' + eventSuccessData.jsonResponse);
  }
};

// Set event failure tracking delegate.
config.eventFailureCallback = (AdTraceEventFailure eventFailureData) {
  print('[AdTrace]: Event tracking failure!');

  if (eventFailureData.eventToken != null) {
    print('[AdTrace]: Event token: ' + eventFailureData.eventToken);
  }
  if (eventFailureData.message != null) {
    print('[AdTrace]: Message: ' + eventFailureData.message);
  }
  if (eventFailureData.timestamp != null) {
    print('[AdTrace]: Timestamp: ' + eventFailureData.timestamp);
  }
  if (eventFailureData.adid != null) {
    print('[AdTrace]: Adid: ' + eventFailureData.adid);
  }
  if (eventFailureData.callbackId != null) {
    print('[AdTrace]: Callback ID: ' + eventFailureData.callbackId);
  }
  if (eventFailureData.willRetry != null) {
    print('[AdTrace]: Will retry: ' + eventFailureData.willRetry.toString());
  }
  if (eventFailureData.jsonResponse != null) {
    print('[AdTrace]: JSON response: ' + eventFailureData.jsonResponse);
  }
};

AdTrace.start(adtraceConfig);
```

The callback function will be called after the SDK tries to send a package to the server. Within the callback function you have access to a response data object specifically for the callback. Here is a quick summary of the success session response data object fields:

- `message` message string from the server or the error logged by the SDK.
- `timestamp` timestamp string from the server.
- `adid` a unique string device identifier provided by AdTrace.
- `jsonResponse` the JSON object with the reponse from the server.

Both event response data objects contain:

- `eventToken` the event token string, if the package tracked was an event.
- `callbackId` the custom defined [callback ID](#cp-event-callback-id) string set on event object.

And both event and session failed objects also contain:

- `willRetry` boolean which indicates whether there will be an attempt to resend the package at a later time.

### <a id="af-user-attribution"></a>User attribution

Like described in [attribution callback section](#af-attribution-callback), this callback get triggered providing you info about new attribution when ever it changes. In case you want to access info about your user's current attribution whenever you need it, you can make a call to following method of the `AdTrace` instance:

```dart
AdTraceAttribution attribution = AdTrace.getAttribution();
```

**Note**: Information about current attribution is available after app installation has been tracked by the AdTrace backend and attribution callback has been initially triggered. From that moment on, AdTrace SDK has information about your user's attribution and you can access it with this method. So, **it is not possible** to access user's attribution value before the SDK has been initialized and attribution callback has been initially triggered.

### <a id="af-device-ids"></a>Device IDs

The AdTrace SDK offers you possibility to obtain some of the device identifiers.

### <a id="af-idfa"></a>iOS Advertising Identifier

To obtain the IDFA, call the `getIdfa` method of the `AdTrace` instance:

```dart
AdTrace.getIdfa().then((idfa) {
  // Use idfa string value.
});
```

### <a id="af-gps-adid"></a>Google Play Services advertising identifier

The Google Play Services Advertising Identifier (Google advertising ID) is a unique identifier for a device. Users can opt out of sharing their Google advertising ID by toggling the "Opt out of Ads Personalization" setting on their device. When a user has enabled this setting, the AdTrace SDK returns a string of zeros when trying to read the Google advertising ID.

> **Important**: If you are targeting Android 12 and above (API level 31), you need to add the [`com.google.android.gms.AD_ID` permission](#gps-adid-permission) to your app. If you do not add this permission, you will not be able to read the Google advertising ID even if the user has not opted out of sharing their ID.

Certain services (such as Google Analytics) require you to coordinate Device and Client IDs in order to prevent duplicate reporting.

To obtain the device Google Advertising identifier, it's necessary to pass a callback function to `AdTrace.getGoogleAdId` that will receive the Google Advertising ID in it's argument, like this:

```dart
AdTrace.getGoogleAdId().then((googleAdId) {
  // Use googleAdId string value.
});
```


### <a id="af-adid"></a>AdTrace device identifier

For each device with your app installed on it, AdTrace backend generates unique **AdTrace device identifier** (**adid**). In order to obtain this identifier, you can make a call the `getAdid` method of the `AdTrace` instance:

```dart
AdTrace.getAdid().then((adid) {
  // Use adid string value.
});
```

**Note**: Information about **adid** is available after app installation has been tracked by the AdTrace backend. From that moment on, AdTrace SDK has information about your device **adid** and you can access it with this method. So, **it is not possible** to access **adid** value before the SDK has been initialised and installation of your app was tracked successfully.

### <a id="set-external-device-id"></a>Set external device ID

> **Note** If you want to use external device IDs, please contact your AdTrace representative. They will talk you through the best approach for your use case.

An external device identifier is a custom value that you can assign to a device or user. They can help you to recognize users across sessions and platforms. They can also help you to deduplicate installs by user so that a user isn't counted as multiple new installs.

You can also use an external device ID as a custom identifier for a device. This can be useful if you use these identifiers elsewhere and want to keep continuity.

Check out our [external device identifiers article](https://adtrace.io) for more information.

> **Note** This setting requires AdTrace SDK v2.0.2 or later.

To set an external device ID, assign the identifier to the `externalDeviceId` property of your config instance. Do this before you initialize the AdTrace SDK.

```dart
adtraceConfig.externalDeviceId = '{Your-External-Device-Id}';
```

> **Important**: You need to make sure this ID is **unique to the user or device** depending on your use-case. Using the same ID across different users or devices could lead to duplicated data. Talk to your AdTrace representative for more information.

If you want to use the external device ID in your business analytics, you can pass it as a session callback parameter. See the section on [session callback parameters](#cp-session-callback-parameters) for more information.

You can import existing external device IDs into AdTrace. This ensures that the backend matches future data to your existing device records. If you want to do this, please contact your AdTrace representative.


### <a id="af-offline-mode"></a>Offline mode

You can put the AdTrace SDK in offline mode to suspend transmission to our servers, while retaining tracked data to be sent later. While in offline mode, all information is saved in a file, so be careful not to trigger too many events while in offline mode.

You can activate offline mode by calling `setOfflineMode` with the parameter `true`.

```dart
AdTrace.setOfflineMode(true);
```

Conversely, you can deactivate offline mode by calling `setOfflineMode` with `false`. When the AdTrace SDK is put back in online mode, all saved information is sent to our servers with the correct time information.

Unlike disabling tracking, this setting is **not remembered** between sessions. This means that the SDK is in online mode whenever it is started, even if the app was terminated in offline mode.

### <a id="af-disable-tracking"></a>Disable tracking

You can disable the AdTrace SDK from tracking any activities of the current device by calling `setEnabled` with parameter `false`. **This setting is remembered between sessions**.

```dart
AdTrace.setEnabled(false);
```

You can check if the AdTrace SDK is currently enabled by calling the function `isEnabled`. It is always possible to activatе the AdTrace SDK by invoking `setEnabled` with the enabled parameter as `true`.

### <a id="af-event-buffering"></a>Event buffering

If your app makes heavy use of event tracking, you might want to delay some HTTP requests in order to send them in one batch every minute. You can enable event buffering with your config instance:

```dart
adtraceConfig.eventBufferingEnabled = true;
```

### <a id="af-background-tracking"></a>Background tracking

The default behaviour of the AdTrace SDK is to pause sending HTTP requests while the app is in the background. You can change this in your config instance:

```dart
adtraceConfig.sendInBackground = true;
```



[dashboard]:  https://adtrace.io
[adtrace.io]: https://adtrace.io

[example-app]: example

[multiple-receivers]:             https://github.com/adtrace/adtrace_sdk_android/blob/master/doc/english/multiple-receivers.md
[google-ad-id]:                   https://support.google.com/googleplay/android-developer/answer/6048248?hl=en
[ios-deeplinking]:                https://github.com/adtrace/ios_sdk/#deep-linking
[new-referrer-api]:               https://developer.android.com/google/play/installreferrer/library.html
[android-deeplinking]:            https://github.com/adtrace/android_sdk#deep-linking
[android-launch-modes]:           https://developer.android.com/guide/topics/manifest/activity-element.html
[google-play-services]:           https://developer.android.com/google/play-services/setup.html


## <a id="license"></a>License

The AdTrace SDK is licensed under the MIT License.

Copyright (c) AdTrace, https://www.adtrace.io

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
