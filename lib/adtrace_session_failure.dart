/**
 *  AdTrace SDK for Flutter
 *  Developed by Nasser Amini on Mar 2021
 *  for more information visit https://adtrace.io
 */

class AdTraceSessionFailure {
  final String? message;
  final String? timestamp;
  final String? adid;
  final String? jsonResponse;
  final bool? willRetry;

  AdTraceSessionFailure({
    required this.message,
    required this.timestamp,
    required this.adid,
    required this.jsonResponse,
    required this.willRetry,
  });

  factory AdTraceSessionFailure.fromMap(dynamic map) {
    try {
      return AdTraceSessionFailure(
        message: map['message'],
        timestamp: map['timestamp'],
        adid: map['adid'],
        jsonResponse: map['jsonResponse'],
        willRetry: map['willRetry']?.toString().toLowerCase() == 'true',
      );
    } catch (e) {
      throw Exception(
          '[AdTraceFlutter]: Failed to create AdTraceSessionFailure object from given map object. Details: ' +
              e.toString());
    }
  }
}
