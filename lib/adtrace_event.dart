/**
 *  AdTrace SDK for Flutter
 *  Developed by Nasser Amini on Mar 2021
 *  for more information visit https://adtrace.io
 */

import 'dart:convert';

class AdTraceEvent {
  String _eventToken;
  num? _revenue;
  String? _currency;
  Map<String, String>? _callbackParameters;
  Map<String, String>? _eventParameters;

  String? transactionId;
  String? callbackId;

  AdTraceEvent(this._eventToken) {
    _callbackParameters = new Map<String, String>();
    _eventParameters = new Map<String, String>();
  }

  void setRevenue(num revenue, String currency) {
    _revenue = revenue;
    _currency = currency;
  }

  void addCallbackParameter(String key, String value) {
    _callbackParameters![key] = value;
  }

  void addEventParameter(String key, String value) {
    _eventParameters![key] = value;
  }

  Map<String, String?> get toMap {
    Map<String, String?> eventMap = {'eventToken': _eventToken};

    if (_revenue != null) {
      eventMap['revenue'] = _revenue.toString();
    }
    if (_currency != null) {
      eventMap['currency'] = _currency;
    }
    if (transactionId != null) {
      eventMap['transactionId'] = transactionId;
    }
    if (callbackId != null) {
      eventMap['callbackId'] = callbackId;
    }
    if (_callbackParameters!.length > 0) {
      eventMap['callbackParameters'] = json.encode(_callbackParameters);
    }
    if (_eventParameters!.length > 0) {
      eventMap['eventParameters'] = json.encode(_eventParameters);
    }

    return eventMap;
  }
}
