import 'package:dio/dio.dart';
import 'package:pathshala/pages/books/models/books_response.dart';
import 'package:pathshala/services/dio_client.dart';

class ResourcesService {
  final Dio _dio = DioClient.instance;

  Future<BooksResponse> getBooks() async {
    try {
      final response = await _dio.get('/bhaag/');

      if (response.statusCode == 200) {
        return BooksResponse.fromJson(response.data);
      } else {
        return BooksResponse(
          status: 'error',
          message: '',
          data: [],
          error: response.data['error'] ?? {},
        );
      }
    } catch (e) {
      throw DioException(
        error: e.toString(),
        requestOptions: RequestOptions(path: '/bhaag/'),
      );
    }
  }
}
