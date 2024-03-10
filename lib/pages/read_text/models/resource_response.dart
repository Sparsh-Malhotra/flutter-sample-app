import 'package:pathshala/core/models/api_error_model.dart';

class TextResourceResponse {
  String status;
  String message;
  List<TextResource> data;
  ApiError error;

  TextResourceResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.error,
  });

  factory TextResourceResponse.fromJson(Map<String, dynamic> json) {
    final temp = <TextResource>[];
    if (json['data'] != null) {
        temp.add(TextResource.fromJson(json['data']));
    }
    return TextResourceResponse(
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
  String? id;
  String? title;
  String? text;

  TextResource({this.id, this.title, this.text});

  factory TextResource.fromJson(Map<String, dynamic> json) {
    return TextResource(
      id: json['id'],
      title: json['title'],
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['text'] = text;
    return data;
  }
}
