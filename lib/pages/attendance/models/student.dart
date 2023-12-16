import 'package:pathshala/core/models/api_error_model.dart';

class SessionStudent {
  String status;
  String message;
  List<SessionStudentData> data;
  ApiError error;

  SessionStudent({
    required this.status,
    required this.message,
    required this.data,
    required this.error,
  });

  factory SessionStudent.fromJson(Map<String, dynamic> json) {
    List<SessionStudentData> dataList = [];
    if (json['data'] != null) {
      dataList = (json['data'] as List)
          .map((data) => SessionStudentData.fromJson(data))
          .toList();
    }

    return SessionStudent(
      status: json['status'],
      message: json['message'],
      data: dataList,
      error: ApiError.fromJson(json['error'] ?? {}),
    );
  }
}

class SessionStudentData {
  int id;
  Map<dynamic, dynamic> profile;

  SessionStudentData({
    required this.id,
    required this.profile,
  });

  factory SessionStudentData.fromJson(Map<String, dynamic> json) {
    return SessionStudentData(
      id: json['id'],
      profile: json['profile'],
    );
  }
}

class PresentAttendeesResponse {
  String status;
  String message;
  List<dynamic> data;
  ApiError error;

  PresentAttendeesResponse(
      {required this.status,
      required this.message,
      required this.data,
      required this.error});

  factory PresentAttendeesResponse.fromJson(Map<String, dynamic> json) {
    return PresentAttendeesResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'],
      error: ApiError.fromJson(json['error'] ?? {}),
    );
  }
}
