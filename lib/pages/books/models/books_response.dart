import 'package:pathshala/core/models/api_error_model.dart';

class BooksResponse {
  String status;
  String message;
  List<Book> data;
  ApiError error;

  BooksResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.error,
  });

  factory BooksResponse.fromJson(Map<String, dynamic> json) {
    final temp = <Book>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        temp.add(Book.fromJson(v));
      });
    }
    return BooksResponse(
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

class Book {
  int? id;
  bool? isActive;
  String? name;
  String? book;

  Book({this.id, this.isActive, this.name, this.book});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      isActive: json['is_active'],
      name: json['name'],
      book: json['book'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['is_active'] = isActive;
    data['name'] = name;
    data['book'] = book;
    return data;
  }
}
