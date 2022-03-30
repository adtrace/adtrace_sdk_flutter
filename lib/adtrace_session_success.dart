/**
 *  AdTrace SDK for Flutter
 *  Developed by Nasser Amini on Mar 2021
 *  for more information visit https://adtrace.io
 */

class AdTraceSessionSuccess {
  final String? message;
  final String? timestamp;
  final String? adid;
  final String? jsonResponse;

  AdTraceSessionSuccess({
    required this.message,
    required this.timestamp,
    required this.adid,
    required this.jsonResponse,
  });

  factory AdTraceSessionSuccess.fromMap(dynamic map) {
    try {
      return AdTraceSessionSuccess(
        message: map['message'],
        timestamp: map['timestamp'],
        adid: map['adid'],
        jsonResponse: map['jsonResponse'],
      );
    } catch (e) {
      throw Exception(
          '[AdTraceFlutter]: Failed to create AdTraceSessionSuccess object from given map object. Details: ' +
              e.toString());
    }
  }
}
