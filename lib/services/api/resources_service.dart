import 'package:dio/dio.dart';
import 'package:pathshala/pages/books/models/books_response.dart';
import 'package:pathshala/pages/video_library/models/video_library_response.dart';
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

  Future<VideoLibraryResponse> getVideos(Map<String, dynamic> params) async {
    try {
      final response =
          await _dio.get('/video_library/', queryParameters: params);

      if (response.statusCode == 200) {
        return VideoLibraryResponse.fromJson(response.data);
      } else {
        return VideoLibraryResponse(
          status: 'error',
          message: '',
          data: VideoInfo.fromJson({
            'count': 0,
            'next': null,
            'previous': null,
            'results': [],
          }),
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
