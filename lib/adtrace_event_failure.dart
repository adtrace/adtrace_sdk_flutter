//
//  Created by Aref Hosseini on 7th October 2019.
//

class AdTraceEventFailure {
  String message;
  String timestamp;
  String adid;
  String eventToken;
  String callbackId;
  String jsonResponse;
  bool willRetry;

  static AdTraceEventFailure fromMap(dynamic map) {
    AdTraceEventFailure eventFailure = new AdTraceEventFailure();
    try {
      eventFailure.message = map['message'];
      eventFailure.timestamp = map['timestamp'];
      eventFailure.adid = map['adid'];
      eventFailure.eventToken = map['eventToken'];
      eventFailure.callbackId = map['callbackId'];
      eventFailure.jsonResponse = map['jsonResponse'];
      bool willRetry = map['willRetry'].toString().toLowerCase() == 'true';
      eventFailure.willRetry = willRetry;
    } catch (e) {
      print('[AdTraceFlutter]: Failed to create AdTraceEventFailure object from given map object. Details: ' + e.toString());
    }
    return eventFailure;
  }
}