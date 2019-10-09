//
//  Created by Aref Hosseini on 7th October 2019.
//

class AdTraceEventSuccess {
  String message;
  String timestamp;
  String adid;
  String eventToken;
  String callbackId;
  String jsonResponse;

  static AdTraceEventSuccess fromMap(dynamic map) {
    AdTraceEventSuccess eventSuccess = new AdTraceEventSuccess();
    try {
      eventSuccess.message = map['message'];
      eventSuccess.timestamp = map['timestamp'];
      eventSuccess.adid = map['adid'];
      eventSuccess.eventToken = map['eventToken'];
      eventSuccess.callbackId = map['callbackId'];
      eventSuccess.jsonResponse = map['jsonResponse'];
    } catch (e) {
      print('[AdTraceFlutter]: Failed to create AdTraceEventSuccess object from given map object. Details: ' + e.toString());
    }
    return eventSuccess;
  }
}