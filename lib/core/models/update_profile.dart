import 'package:pathshala/core/models/api_error_model.dart';

class UpdateProfileResponse {
  String status;
  String message;
  dynamic data;
  ApiError error;

  UpdateProfileResponse(
      {required this.status,
      required this.message,
      required this.data,
      required this.error});

  factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) {
    return UpdateProfileResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'],
      error: ApiError.fromJson(json['error'] ?? {}),
    );
  }
}
