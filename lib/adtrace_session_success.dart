//
//  Created by Aref Hosseini on 7th October 2019.
//

class AdTraceSessionSuccess {
  String message;
  String timestamp;
  String adid;
  String jsonResponse;

  static AdTraceSessionSuccess fromMap(dynamic map) {
    AdTraceSessionSuccess sessionSuccess = new AdTraceSessionSuccess();
    try {
      sessionSuccess.message = map['message'];
      sessionSuccess.timestamp = map['timestamp'];
      sessionSuccess.adid = map['adid'];
      sessionSuccess.jsonResponse = map['jsonResponse'];
    } catch (e) {
      print('[AdTraceFlutter]: Failed to create AdTraceSessionSuccess object from given map object. Details: ' + e.toString());
    }
    return sessionSuccess;
  }
}