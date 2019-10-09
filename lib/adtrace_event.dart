//
//  Created by Aref Hosseini on 7th October 2019.
//

import 'dart:convert';

class AdTraceEvent {
  num _revenue;
  String _currency;
  String _eventToken;
  Map<String, String> _callbackParameters;
  Map<String, String> _partnerParameters;

  String transactionId;
  String callbackId;

  AdTraceEvent(this._eventToken) {
    _callbackParameters = new Map<String, String>();
    _partnerParameters = new Map<String, String>();
  }

  void setRevenue(num revenue, String currency) {
    _revenue = revenue;
    _currency = currency;
  }

  void addCallbackParameter(String key, String value) {
    _callbackParameters[key] = value;
  }

  void addPartnerParameter(String key, String value) {
    _partnerParameters[key] = value;
  }

  Map<String, String> get toMap {
    Map<String, String> eventMap = {
      'eventToken': _eventToken
    };

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
    if (_callbackParameters.length > 0) {
      eventMap['callbackParameters'] = json.encode(_callbackParameters);
    }
    if (_partnerParameters.length > 0) {
      eventMap['partnerParameters'] = json.encode(_partnerParameters);
    }

    return eventMap;
  }
}