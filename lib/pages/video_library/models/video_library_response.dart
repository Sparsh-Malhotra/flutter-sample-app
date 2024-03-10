import 'package:pathshala/core/models/api_error_model.dart';

class VideoLibraryResponse {
  String status;
  String message;
  VideoInfo data;
  ApiError error;

  VideoLibraryResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.error,
  });

  factory VideoLibraryResponse.fromJson(Map<String, dynamic> json) {
    return VideoLibraryResponse(
      status: json['status'],
      message: json['message'],
      data: VideoInfo.fromJson(json['data']),
      error: ApiError.fromJson(
        json['error'] ?? {},
      ),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class VideoInfo {
  int count;
  String? next;
  String? previous;
  List<Video> results;

  VideoInfo({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory VideoInfo.fromJson(Map<String, dynamic> json) {
    final results = <Video>[];
    if (json['results'] != null) {
      json['results'].forEach((v) {
        results.add(Video.fromJson(v));
      });
    }
    return VideoInfo(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: results,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Video {
  int id;
  bool isActive;
  String title;
  String url;
  String categories;
  List<int> bhaag;

  Video({
    required this.id,
    required this.isActive,
    required this.title,
    required this.url,
    required this.categories,
    required this.bhaag,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'],
      isActive: json['is_active'],
      title: json['title'],
      url: json['url'],
      categories: json['categories'],
      bhaag: List<int>.from(json['bhaag']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['is_active'] = isActive;
    data['title'] = title;
    data['url'] = url;
    data['categories'] = categories;
    data['bhaag'] = bhaag;
    return data;
  }
}
