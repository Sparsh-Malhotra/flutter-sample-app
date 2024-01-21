import 'package:dio/dio.dart';
import 'package:pathshala/pages/books/models/books_response.dart';
import 'package:pathshala/pages/read_text/models/resource_response.dart';
import 'package:pathshala/pages/resources/models/resources_response.dart';
import 'package:pathshala/pages/video_library/models/video_library_response.dart';
import 'package:pathshala/services/dio_client.dart';


class ResourcesService {
  final Dio _dio = DioClient.instance;

  Future<ResourcesResponse> getResources() async {
    try {
      final response = await _dio.get('/resources/');

      if (response.statusCode == 200) {
        return ResourcesResponse.fromJson(response.data);
      } else {
        return ResourcesResponse(
          status: 'error',
          message: '',
          data: [],
          error: response.data['error'] ?? {},
        );
      }
    } catch (e) {
      throw DioException(
        error: e.toString(),
        requestOptions: RequestOptions(path: '/resources/'),
      );
    }
  }


  Future<TextResourceResponse> getTextResource(id) async {
    try {
      Map<String, dynamic>? data = {"id":id};
      final response = await _dio.get('/resource/', queryParameters: data);

      if (response.statusCode == 200) {
        return TextResourceResponse.fromJson(response.data);
      } else {
        return TextResourceResponse(
          status: 'error',
          message: '',
          data: [],
          error: response.data['error'] ?? {},
        );
      }
    } catch (e) {
      throw DioException(
        error: e.toString(),
        requestOptions: RequestOptions(path: '/resource/'),
      );
    }
  }


  // Future<ResourcesResponse> getResource() async {
  //   try {
  //     final response = await _dio.get('/resource/');

  //     if (response.statusCode == 200) {
  //       return ResourcesResponse.fromJson(response.data);
  //     } else {
  //       return ResourcesResponse(
  //         status: 'error',
  //         message: '',
  //         data: [],
  //         error: response.data['error'] ?? {},
  //       );
  //     }
  //   } catch (e) {
  //     throw DioException(
  //       error: e.toString(),
  //       requestOptions: RequestOptions(path: '/resource/'),
  //     );
  //   }
  // }

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
