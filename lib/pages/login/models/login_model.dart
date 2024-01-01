import 'package:com.jainyouthnoida.pathshala/core/models/api_error_model.dart';

class LoginModel {
  late String status;
  late String message;
  late Data data;
  late ApiError error;

  LoginModel({
    required this.status,
    required this.message,
    required this.data,
    required this.error,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: Data.fromJson(json['data'] ?? {}),
      error: ApiError.fromJson(json['error'] ?? {}),
    );
  }
}

class Data {
  late String accessToken;
  late String refreshToken;

  Data({required this.accessToken, required this.refreshToken});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      accessToken: json['access_token'] ?? '',
      refreshToken: json['refresh_token'] ?? '',
    );
  }
}
