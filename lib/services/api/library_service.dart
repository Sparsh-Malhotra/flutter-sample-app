import 'package:dio/dio.dart';
import 'package:pathshala/core/models/api_error_model.dart';
import 'package:pathshala/pages/books/models/books_response_model.dart';
import 'package:pathshala/services/dio_client.dart';

class LibraryService {
  final Dio _dio = DioClient.instance;

  Future<BooksResponseModel> getBooks() async {
    try {
      final response = await _dio.put(
        '/bhaag/',
      );
      if (response.statusCode == 200) {
        return BooksResponseModel.fromJson(response.data);
      } else {
        return BooksResponseModel(
          status: 'error',
          message: '',
          data: [],
          error: ApiError.fromJson(response.data['error'] ?? {}),
        );
      }
    } on DioException catch (e) {
      final errorMessage = e.message;
      throw Exception(errorMessage);
    } catch (e) {
      // Handle other exceptions
      const errorMessage = 'Unexpected error occurred';
      throw Exception(errorMessage);
    }
  }
}
