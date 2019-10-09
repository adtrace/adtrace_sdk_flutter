//
//  Created by Aref Hosseini on 7th October 2019.
//

class AdTraceSessionFailure {
  String message;
  String timestamp;
  String adid;
  String jsonResponse;
  bool willRetry;

  static AdTraceSessionFailure fromMap(dynamic map) {
    AdTraceSessionFailure sessionFailure = new AdTraceSessionFailure();
    try {
      sessionFailure.message = map['message'];
      sessionFailure.timestamp = map['timestamp'];
      sessionFailure.adid = map['adid'];
      sessionFailure.jsonResponse = map['jsonResponse'];
      bool willRetry = map['willRetry'].toString().toLowerCase() == 'true';
      sessionFailure.willRetry = willRetry;
    } catch (e) {
      print('[AdTraceFlutter]: Failed to create AdTraceSessionFailure object from given map object. Details: ' + e.toString());
    }
    return sessionFailure;
  }
}