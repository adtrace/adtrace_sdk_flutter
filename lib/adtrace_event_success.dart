
class AdTraceEventSuccess {
  final String? message;
  final String? timestamp;
  final String? adid;
  final String? eventToken;
  final String? callbackId;
  final String? jsonResponse;

  AdTraceEventSuccess({
    required this.message,
    required this.timestamp,
    required this.adid,
    required this.eventToken,
    required this.callbackId,
    required this.jsonResponse,
  });

  factory AdTraceEventSuccess.fromMap(dynamic map) {
    try {
      return AdTraceEventSuccess(
        message: map['message'],
        timestamp: map['timestamp'],
        adid: map['adid'],
        eventToken: map['eventToken'],
        callbackId: map['callbackId'],
        jsonResponse: map['jsonResponse'],
      );
    } catch (e) {
      throw Exception(
          '[AdTraceFlutter]: Failed to create AdTraceEventSuccess object from given map object. Details: ' +
              e.toString());
    }
  }
}
