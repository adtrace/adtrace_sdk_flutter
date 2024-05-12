import 'package:adtrace_sdk_flutter/adtrace_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Util {
  static const String EVENT_TOKEN_SIMPLE = 'd6wlpj';
  static const String EVENT_TOKEN_REVENUE = 'ou92ya';
  static const String EVENT_TOKEN_CALLBACK = '34vgg9';
  static const String EVENT_TOKEN_PARTNER = 'w788qs';

  static Widget buildRaisedButton(String text, Function action) {
    return Align(
      alignment: const Alignment(0.0, -0.2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ButtonBar(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ElevatedButton(
                child: Text(text),
                onPressed: () {
                  action();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget buildCupertinoButton(String text, Function action) {
    return CupertinoButton(
      child: Text(text),
      color: CupertinoColors.activeBlue,
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 30.0),
      onPressed: action as void Function()?,
    );
  }

  static Widget buildRaisedButtonRow(String text, Function action) {
    return Align(
      alignment: const Alignment(0.0, -0.2),
      child: Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ElevatedButton(
              child: Text(text),
              onPressed: () {
                action();
              },
            ),
          ],
        ),
        margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
        padding: EdgeInsets.all(1.0),
        decoration:
            BoxDecoration(border: Border.all(color: Colors.black)),
      ),
    );
  }

  static AdTraceEvent buildSimpleEvent() {
    return AdTraceEvent(EVENT_TOKEN_SIMPLE);
  }

  static AdTraceEvent buildRevenueEvent() {
    AdTraceEvent event = AdTraceEvent(EVENT_TOKEN_REVENUE);
    event.setRevenue(100.0, 'IRR');
    event.transactionId = 'DummyTransactionId';
    return event;
  }

  static AdTraceEvent buildCallbackEvent() {
    AdTraceEvent event = AdTraceEvent(EVENT_TOKEN_CALLBACK);
    event.addCallbackParameter('key1', 'value1');
    event.addCallbackParameter('key2', 'value2');
    return event;
  }

  static AdTraceEvent buildPartnerParamsEvent() {
    AdTraceEvent event = AdTraceEvent(EVENT_TOKEN_CALLBACK);
    event.addPartnerParameter('key1', 'value1');
    event.addPartnerParameter('key2', 'value2');
    return event;
  }

  static AdTraceEvent buildEventValueParams() {
    AdTraceEvent event = AdTraceEvent(EVENT_TOKEN_PARTNER);
    event.addEventParameter('foo1', 'bar1');
    event.addEventParameter('foo2', 'bar2');
    return event;
  }

  static void showMessage(
      BuildContext context, String dialogText, String message) {
    showDialog<Null>(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(dialogText),
              content: Text(message),
            ));
  }

  static void showDemoDialog<T>(
      {GlobalKey<ScaffoldState>? scaffoldKey,
      required BuildContext context,
      Widget? child}) {
    showDialog<T>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => child!,
    ).then<void>((T? value) {
      // The value passed to Navigator.pop() or null.
      if (scaffoldKey != null && value != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('You selected: $value'),
          ),
        );
      }
    });
  }
}
