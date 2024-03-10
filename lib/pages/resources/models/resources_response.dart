import 'package:pathshala/core/models/api_error_model.dart';

class ResourcesResponse {
  String status;
  String message;
  List<TextResource> data;
  ApiError error;

  ResourcesResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.error,
  });

  factory ResourcesResponse.fromJson(Map<String, dynamic> json) {
    final temp = <TextResource>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        temp.add(TextResource.fromJson(v));
      });
    }
    return ResourcesResponse(
      status: json['status'],
      message: json['message'],
      data: temp,
      error: ApiError.fromJson(json['error'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TextResource {
  int? id;
  String? name;

  TextResource({this.id, this.name});

  factory TextResource.fromJson(Map<String, dynamic> json) {
    return TextResource(
      id: json['id'],
      name: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
