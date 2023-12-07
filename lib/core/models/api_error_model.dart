class ApiError {
  final String code;
  final String message;
  final String details;

  ApiError({
    required this.code,
    required this.message,
    required this.details,
  });

  factory ApiError.fromJson(Map<String, dynamic> json) {
    return ApiError(
      code: json['code'] ?? '',
      message: json['message'] ?? '',
      details: json['details'] ?? '',
    );
  }
}
