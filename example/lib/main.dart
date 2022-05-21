import 'package:adtrace_sdk_flutter/adtrace.dart';
import 'package:adtrace_sdk_flutter/adtrace_attribution.dart';
import 'package:adtrace_sdk_flutter/adtrace_config.dart';
import 'package:adtrace_sdk_flutter/adtrace_event_failure.dart';
import 'package:adtrace_sdk_flutter/adtrace_event_success.dart';
import 'package:adtrace_sdk_flutter/adtrace_session_failure.dart';
import 'package:adtrace_sdk_flutter/adtrace_session_success.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'util.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  bool _isSdkEnabled = true;

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initPlatformState();
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
      case AppLifecycleState.detached:
        break;
    }
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    AdTraceConfig config =
        AdTraceConfig('09eu7dllf7md', AdTraceEnvironment.sandbox);
    config.logLevel = AdTraceLogLevel.verbose;

    config.attributionCallback = (AdTraceAttribution attributionChangedData) {
      print('[AdTrace]: Attribution changed!');

      if (attributionChangedData.trackerToken != null) {
        print('[AdTrace]: Tracker token: ' +
            attributionChangedData.trackerToken!);
      }
      if (attributionChangedData.trackerName != null) {
        print(
            '[AdTrace]: Tracker name: ' + attributionChangedData.trackerName!);
      }
      if (attributionChangedData.campaign != null) {
        print('[AdTrace]: Campaign: ' + attributionChangedData.campaign!);
      }
      if (attributionChangedData.network != null) {
        print('[AdTrace]: Network: ' + attributionChangedData.network!);
      }
      if (attributionChangedData.creative != null) {
        print('[AdTrace]: Creative: ' + attributionChangedData.creative!);
      }
      if (attributionChangedData.adgroup != null) {
        print('[AdTrace]: Adgroup: ' + attributionChangedData.adgroup!);
      }
      if (attributionChangedData.clickLabel != null) {
        print('[AdTrace]: Click label: ' + attributionChangedData.clickLabel!);
      }
      if (attributionChangedData.adid != null) {
        print('[AdTrace]: Adid: ' + attributionChangedData.adid!);
      }
      if (attributionChangedData.costType != null) {
        print('[AdTrace]: Cost type: ' + attributionChangedData.costType!);
      }
      if (attributionChangedData.costAmount != null) {
        print('[AdTrace]: Cost amount: ' +
            attributionChangedData.costAmount!.toString());
      }
      if (attributionChangedData.costCurrency != null) {
        print('[AdTrace]: Cost currency: ' +
            attributionChangedData.costCurrency!);
      }
    };

    config.sessionSuccessCallback = (AdTraceSessionSuccess sessionSuccessData) {
      print('[AdTrace]: Session tracking success!');

      if (sessionSuccessData.message != null) {
        print('[AdTrace]: Message: ' + sessionSuccessData.message!);
      }
      if (sessionSuccessData.timestamp != null) {
        print('[AdTrace]: Timestamp: ' + sessionSuccessData.timestamp!);
      }
      if (sessionSuccessData.adid != null) {
        print('[AdTrace]: Adid: ' + sessionSuccessData.adid!);
      }
      if (sessionSuccessData.jsonResponse != null) {
        print('[AdTrace]: JSON response: ' + sessionSuccessData.jsonResponse!);
      }
    };

    config.sessionFailureCallback = (AdTraceSessionFailure sessionFailureData) {
      print('[AdTrace]: Session tracking failure!');

      if (sessionFailureData.message != null) {
        print('[AdTrace]: Message: ' + sessionFailureData.message!);
      }
      if (sessionFailureData.timestamp != null) {
        print('[AdTrace]: Timestamp: ' + sessionFailureData.timestamp!);
      }
      if (sessionFailureData.adid != null) {
        print('[AdTrace]: Adid: ' + sessionFailureData.adid!);
      }
      if (sessionFailureData.willRetry != null) {
        print('[AdTrace]: Will retry: ' +
            sessionFailureData.willRetry.toString());
      }
      if (sessionFailureData.jsonResponse != null) {
        print('[AdTrace]: JSON response: ' + sessionFailureData.jsonResponse!);
      }
    };

    config.eventSuccessCallback = (AdTraceEventSuccess eventSuccessData) {
      print('[AdTrace]: Event tracking success!');

      if (eventSuccessData.eventToken != null) {
        print('[AdTrace]: Event token: ' + eventSuccessData.eventToken!);
      }
      if (eventSuccessData.message != null) {
        print('[AdTrace]: Message: ' + eventSuccessData.message!);
      }
      if (eventSuccessData.timestamp != null) {
        print('[AdTrace]: Timestamp: ' + eventSuccessData.timestamp!);
      }
      if (eventSuccessData.adid != null) {
        print('[AdTrace]: Adid: ' + eventSuccessData.adid!);
      }
      if (eventSuccessData.callbackId != null) {
        print('[AdTrace]: Callback ID: ' + eventSuccessData.callbackId!);
      }
      if (eventSuccessData.jsonResponse != null) {
        print('[AdTrace]: JSON response: ' + eventSuccessData.jsonResponse!);
      }
    };

    config.eventFailureCallback = (AdTraceEventFailure eventFailureData) {
      print('[AdTrace]: Event tracking failure!');

      if (eventFailureData.eventToken != null) {
        print('[AdTrace]: Event token: ' + eventFailureData.eventToken!);
      }
      if (eventFailureData.message != null) {
        print('[AdTrace]: Message: ' + eventFailureData.message!);
      }
      if (eventFailureData.timestamp != null) {
        print('[AdTrace]: Timestamp: ' + eventFailureData.timestamp!);
      }
      if (eventFailureData.adid != null) {
        print('[AdTrace]: Adid: ' + eventFailureData.adid!);
      }
      if (eventFailureData.callbackId != null) {
        print('[AdTrace]: Callback ID: ' + eventFailureData.callbackId!);
      }
      if (eventFailureData.willRetry != null) {
        print(
            '[AdTrace]: Will retry: ' + eventFailureData.willRetry.toString());
      }
      if (eventFailureData.jsonResponse != null) {
        print('[AdTrace]: JSON response: ' + eventFailureData.jsonResponse!);
      }
    };

    config.deferredDeeplinkCallback = (String? uri) {
      print('[AdTrace]: Received deferred deeplink: ' + uri!);
    };

    config.conversionValueUpdatedCallback = (num? conversionValue) {
      print('[AdTrace]: Received conversion value update: ' +
          conversionValue!.toString());
    };

    // Add session callback parameters.
    AdTrace.addSessionCallbackParameter('scp_foo_1', 'scp_bar');
    AdTrace.addSessionCallbackParameter('scp_foo_2', 'scp_value');

    // Add session Partner parameters.
    AdTrace.addSessionPartnerParameter('spp_foo_1', 'spp_bar');
    AdTrace.addSessionPartnerParameter('spp_foo_2', 'spp_value');

    // Remove session callback parameters.
    AdTrace.removeSessionCallbackParameter('scp_foo_1');
    AdTrace.removeSessionPartnerParameter('spp_foo_1');

    // Clear all session callback parameters.
    AdTrace.resetSessionCallbackParameters();

    // Clear all session partner parameters.
    AdTrace.resetSessionPartnerParameters();

    // Start SDK.
    AdTrace.start(config);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      shrinkWrap: true,
      slivers: <Widget>[
        SliverPadding(
          padding: const EdgeInsets.all(20.0),
          sliver: SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                const Padding(padding: EdgeInsets.all(7.0)),

                Util.buildCupertinoButton(
                    'Is Enabled ?', () => _showIsSdkEnabled()),
                const Padding(padding: EdgeInsets.all(7.0)),

                // Track simple event button.
                Util.buildCupertinoButton('Track Simple Event',
                    () => AdTrace.trackEvent(Util.buildSimpleEvent())),
                const Padding(padding: EdgeInsets.all(7.0)),

                // Track revenue event button.
                Util.buildCupertinoButton('Track Revenue Event',
                    () => AdTrace.trackEvent(Util.buildRevenueEvent())),
                const Padding(padding: EdgeInsets.all(7.0)),

                // Track callback event button.
                Util.buildCupertinoButton('Track Callback Event',
                    () => AdTrace.trackEvent(Util.buildCallbackEvent())),
                const Padding(padding: EdgeInsets.all(7.0)),

                // Track value event button.
                Util.buildCupertinoButton('Track Event Value',
                    () => AdTrace.trackEvent(Util.buildEventValueParams())),
                const Padding(padding: EdgeInsets.all(7.0)),

                // Get Google Advertising Id.
                Util.buildCupertinoButton(
                    'Get Google AdId',
                    () => AdTrace.getGoogleAdId().then((googleAdid) {
                          _showDialogMessage('Get Google Advertising Id',
                              'Received Google Advertising Id: $googleAdid');
                        })),
                const Padding(padding: EdgeInsets.all(7.0)),

                // Get AdTrace identifier.
                Util.buildCupertinoButton(
                    'Get AdTrace identifier',
                    () => AdTrace.getAdid().then((adid) {
                          _showDialogMessage('AdTrace identifier',
                              'Received AdTrace identifier: $adid');
                        })),
                const Padding(padding: EdgeInsets.all(7.0)),

                // Get IDFA.
                Util.buildCupertinoButton(
                    'Get IDFA',
                    () => AdTrace.getIdfa().then((idfa) {
                          _showDialogMessage('IDFA', 'Received IDFA: $idfa');
                        })),
                const Padding(padding: EdgeInsets.all(7.0)),

                // Get attribution.
                Util.buildCupertinoButton(
                    'Get attribution',
                    () => AdTrace.getAttribution().then((attribution) {
                          _showDialogMessage('Attribution',
                              'Received attribution: ${attribution.toString()}');
                        })),
                const Padding(padding: EdgeInsets.all(7.0)),

                // Enable / disable SDK.
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    // Is SDK enabled switch.
                    Text(
                      _isSdkEnabled ? 'Enabled' : 'Disabled',
                      style: _isSdkEnabled
                          ? TextStyle(fontSize: 32.0, color: Colors.green)
                          : TextStyle(fontSize: 32.0, color: Colors.red),
                    ),
                    CupertinoSwitch(
                      value: _isSdkEnabled,
                      onChanged: (bool value) {
                        setState(() {
                          AdTrace.setEnabled(value);
                          _isSdkEnabled = value;
                          print('Switch state = $_isSdkEnabled');
                        });
                      },
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.all(7.0)),

                // end
              ],
            ),
          ),
        ),
      ],
    );
  }

  _showIsSdkEnabled() {
    try {
      AdTrace.isEnabled().then((isEnabled) {
        _isSdkEnabled = isEnabled;
        _showDialogMessage('SDK Enabled?', 'AdTrace is enabled = $isEnabled');
      });
    } on PlatformException {
      _showDialogMessage(
          'SDK Enabled?', 'No such method found in plugin: isEnabled');
    }
  }

  void _showDialogMessage(String title, String text,
      [bool printToConsoleAlso = true]) {
    if (printToConsoleAlso) {
      print(text);
    }

    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(text),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context, 'OK');
              },
            )
          ],
        );
      },
    );
  }
}
