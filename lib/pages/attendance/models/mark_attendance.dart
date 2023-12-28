import 'package:pathshala/core/models/api_error_model.dart';

class MarkAttendanceRequest {
  int sessionId;
  List<int> studentsIds;

  MarkAttendanceRequest({required this.sessionId, required this.studentsIds});
}

class MarkAttendanceResponse {
  String status;
  String message;
  String data;
  ApiError error;

  MarkAttendanceResponse(
      {required this.status,
      required this.message,
      required this.data,
      required this.error});

  factory MarkAttendanceResponse.fromJson(Map<String, dynamic> json) {
    return MarkAttendanceResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'],
      error: ApiError.fromJson(json['error'] ?? {}),
    );
  }
}
