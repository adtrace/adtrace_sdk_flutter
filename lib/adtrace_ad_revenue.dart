/**
 *  AdTrace SDK for Flutter
 *  Developed by Nasser Amini on Mar 2021
 *  for more information visit https://adtrace.io
 */

import 'dart:convert';

class AdTraceAdRevenue {
  String _source;
  num? _revenue;
  String? _currency;
  num? adImpressionsCount;
  String? adRevenueNetwork;
  String? adRevenueUnit;
  String? adRevenuePlacement;
  Map<String, String>? _callbackParameters;
  Map<String, String>? _partnerParameters;

  AdTraceAdRevenue(this._source) {
    _callbackParameters = new Map<String, String>();
    _partnerParameters = new Map<String, String>();
  }

  void setRevenue(num revenue, String currency) {
    _revenue = revenue;
    _currency = currency;
  }

  void addCallbackParameter(String key, String value) {
    _callbackParameters![key] = value;
  }

  void addPartnerParameter(String key, String value) {
    _partnerParameters![key] = value;
  }

  Map<String, String?> get toMap {
    Map<String, String?> adRevenueMap = {'source': _source};

    if (_revenue != null) {
      adRevenueMap['revenue'] = _revenue.toString();
    }
    if (_currency != null) {
      adRevenueMap['currency'] = _currency;
    }
    if (adImpressionsCount != null) {
      adRevenueMap['adImpressionsCount'] = adImpressionsCount.toString();
    }
    if (adRevenueNetwork != null) {
      adRevenueMap['adRevenueNetwork'] = adRevenueNetwork;
    }
    if (adRevenueUnit != null) {
      adRevenueMap['adRevenueUnit'] = adRevenueUnit;
    }
    if (adRevenuePlacement != null) {
      adRevenueMap['adRevenuePlacement'] = adRevenuePlacement;
    }
    if (_callbackParameters!.length > 0) {
      adRevenueMap['callbackParameters'] = json.encode(_callbackParameters);
    }
    if (_partnerParameters!.length > 0) {
      adRevenueMap['partnerParameters'] = json.encode(_partnerParameters);
    }

    return adRevenueMap;
  }
}
