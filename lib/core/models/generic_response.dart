import 'package:pathshala/core/models/api_error_model.dart';

class GenericApiResponse {
  String status;
  String message;
  dynamic data;
  ApiError error;

  GenericApiResponse(
      {required this.status,
      required this.message,
      required this.data,
      required this.error});

  factory GenericApiResponse.fromJson(Map<String, dynamic> json) {
    return GenericApiResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'],
      error: ApiError.fromJson(json['error'] ?? {}),
    );
  }
}
