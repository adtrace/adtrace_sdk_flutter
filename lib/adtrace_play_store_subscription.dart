/**
 *  AdTrace SDK for Flutter
 *  Developed by Nasser Amini on Mar 2021
 *  for more information visit https://adtrace.io
 */

import 'dart:convert';

class AdTracePlayStoreSubscription {
  String? _price;
  String? _currency;
  String? _sku;
  String? _orderId;
  String? _signature;
  String? _purchaseToken;
  String? _billingStore;
  String? _purchaseTime;
  Map<String, String>? _callbackParameters;
  Map<String, String>? _partnerParameters;

  AdTracePlayStoreSubscription(this._price, this._currency, this._sku,
      this._orderId, this._signature, this._purchaseToken) {
    _billingStore = "GooglePlay";
    _callbackParameters = new Map<String, String>();
    _partnerParameters = new Map<String, String>();
  }

  void setPurchaseTime(String purchaseTime) {
    _purchaseTime = purchaseTime;
  }

  void addCallbackParameter(String key, String value) {
    _callbackParameters![key] = value;
  }

  void addPartnerParameter(String key, String value) {
    _partnerParameters![key] = value;
  }

  Map<String, String?> get toMap {
    Map<String, String?> subscriptionMap = new Map<String, String?>();

    if (_price != null) {
      subscriptionMap['price'] = _price;
    }
    if (_currency != null) {
      subscriptionMap['currency'] = _currency;
    }
    if (_sku != null) {
      subscriptionMap['sku'] = _sku;
    }
    if (_orderId != null) {
      subscriptionMap['orderId'] = _orderId;
    }
    if (_signature != null) {
      subscriptionMap['signature'] = _signature;
    }
    if (_purchaseToken != null) {
      subscriptionMap['purchaseToken'] = _purchaseToken;
    }
    if (_billingStore != null) {
      subscriptionMap['billingStore'] = _billingStore;
    }
    if (_purchaseTime != null) {
      subscriptionMap['purchaseTime'] = _purchaseTime;
    }
    if (_callbackParameters!.length > 0) {
      subscriptionMap['callbackParameters'] = json.encode(_callbackParameters);
    }
    if (_partnerParameters!.length > 0) {
      subscriptionMap['partnerParameters'] = json.encode(_partnerParameters);
    }

    return subscriptionMap;
  }
}
