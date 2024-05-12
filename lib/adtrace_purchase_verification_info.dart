
class AdTracePurchaseVerificationInfo {
  final num? code;
  final String? message;
  final String? verificationStatus;

  AdTracePurchaseVerificationInfo(this.code, this.message, this.verificationStatus);

  factory AdTracePurchaseVerificationInfo.fromMap(dynamic map) {
    try {
      int parsedCode = -1;
      try {
        if (map['code'] != null) {
          parsedCode = int.parse(map['code']);
        }
      } catch (ex) {}

      return AdTracePurchaseVerificationInfo(parsedCode, map['message'], map['verificationStatus']);
    } catch (e) {
      throw Exception(
          '[AdTraceFlutter]: Failed to create AdTracePurchaseVerificationInfo object from given map object. Details: ' +
              e.toString());
    }
  }

  Map<String, String?> get toMap {
    Map<String, String?> verificationInfoMap = new Map<String, String?>();

    if (code != null) {
      verificationInfoMap['code'] = code.toString();
    }
    if (message != null) {
      verificationInfoMap['message'] = message;
    }
    if (verificationStatus != null) {
      verificationInfoMap['verificationStatus'] = verificationStatus;
    }

    return verificationInfoMap;
  }
}
