import 'package:adtrace_sdk_flutter/adtrace_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Util {
  static const String EVENT_TOKEN_SIMPLE = 'd6wlpj';
  static const String EVENT_TOKEN_REVENUE = 'ou92ya';
  static const String EVENT_TOKEN_CALLBACK = '34vgg9';
  static const String EVENT_TOKEN_PARTNER = 'w788qs';

  static Widget buildRaisedButton(String text, Function action) {
    return new Align(
      alignment: const Alignment(0.0, -0.2),
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new ButtonBar(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new ElevatedButton(
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
    return new CupertinoButton(
      child: Text(text),
      color: CupertinoColors.activeBlue,
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 30.0),
      onPressed: action as void Function()?,
    );
  }

  static Widget buildRaisedButtonRow(String text, Function action) {
    return new Align(
      alignment: const Alignment(0.0, -0.2),
      child: new Container(
        child: new Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new ElevatedButton(
              child: Text(text),
              onPressed: () {
                action();
              },
            ),
          ],
        ),
        margin: new EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
        padding: new EdgeInsets.all(1.0),
        decoration:
            new BoxDecoration(border: new Border.all(color: Colors.black)),
      ),
    );
  }

  static AdTraceEvent buildSimpleEvent() {
    return new AdTraceEvent(EVENT_TOKEN_SIMPLE);
  }

  static AdTraceEvent buildRevenueEvent() {
    AdTraceEvent event = new AdTraceEvent(EVENT_TOKEN_REVENUE);
    event.setRevenue(100.0, 'IRR');
    event.transactionId = 'DummyTransactionId';
    return event;
  }

  static AdTraceEvent buildCallbackEvent() {
    AdTraceEvent event = new AdTraceEvent(EVENT_TOKEN_CALLBACK);
    event.addCallbackParameter('key1', 'value1');
    event.addCallbackParameter('key2', 'value2');
    return event;
  }

  static AdTraceEvent buildEventValueParams() {
    AdTraceEvent event = new AdTraceEvent(EVENT_TOKEN_PARTNER);
    event.addEventParameter('foo1', 'bar1');
    event.addEventParameter('foo2', 'bar2');
    return event;
  }

  static void showMessage(
      BuildContext context, String dialogText, String message) {
    showDialog<Null>(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text(dialogText),
              content: new Text(message),
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
          new SnackBar(
            content: new Text('You selected: $value'),
          ),
        );
      }
    });
  }
}
