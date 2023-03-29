/**
 *  AdTrace SDK for Flutter
 *  Developed by Nasser Amini on Mar 2021
 *  for more information visit https://adtrace.io
 */

class AdTraceThirdPartySharing {
  bool? _isEnabled;
  late List<String> _granularOptions;
  late List<String> _partnerSharingSettings;

  AdTraceThirdPartySharing(this._isEnabled) {
    _granularOptions = <String>[];
    _partnerSharingSettings = <String>[];
  }

  void addGranularOption(String partnerName, String key, String value) {
    _granularOptions.add(partnerName);
    _granularOptions.add(key);
    _granularOptions.add(value);
  }

  void addPartnerSharingSetting(String partnerName, String key, bool value) {
    _partnerSharingSettings.add(partnerName);
    _partnerSharingSettings.add(key);
    _partnerSharingSettings.add(value.toString());
  }

  Map<String, Object?> get toMap {
    Map<String, Object?> thirdPartySharingMap = {'isEnabled': _isEnabled};
    if (_granularOptions.length > 0) {
      thirdPartySharingMap['granularOptions'] =
          _granularOptions.join('__ADT__');
    }
    if (_partnerSharingSettings.length > 0) {
      thirdPartySharingMap['partnerSharingSettings'] =
          _partnerSharingSettings.join('__ADT__');
    }

    return thirdPartySharingMap;
  }
}
