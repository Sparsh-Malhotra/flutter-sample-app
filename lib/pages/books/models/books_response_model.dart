import 'package:com.jainyouthnoida.pathshala/core/models/api_error_model.dart';

class BooksResponseModel {
  final String status;
  final String message;
  final List<BookModel> data;
  final ApiError error;

  BooksResponseModel({
    required this.status,
    required this.message,
    required this.data,
    required this.error,
  });

  factory BooksResponseModel.fromJson(Map<String, dynamic> json) {
    return BooksResponseModel(
      status: json['status'],
      message: json['message'],
      data: BookModel.fromArray(json['data']),
      error: json['error'] ?? {},
    );
  }
}

class BookModel {
  final int id;
  final bool isActive;
  final String name;
  final String book;

  BookModel({
    required this.id,
    required this.isActive,
    required this.name,
    required this.book,
  });

  static List<BookModel> fromArray(List<Map<String, dynamic>> list) {
    return list.map((book) {
      return BookModel(
        id: book['id'],
        isActive: book['is_active'],
        name: book['name'],
        book: book['book'],
      );
    }).toList();
  }
}
