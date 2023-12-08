import 'package:pathshala/core/models/api_error_model.dart';

class RegisterModel {
  late String status;
  late String message;
  late Map<dynamic, dynamic> data;
  late ApiError error;

  RegisterModel({
    required this.status,
    required this.message,
    required this.data,
    required this.error,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: {},
      error: ApiError.fromJson(json['error'] ?? {}),
    );
  }
}
