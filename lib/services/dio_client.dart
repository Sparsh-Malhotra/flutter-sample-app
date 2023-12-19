import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pathshala/app_contants.dart';

class DioClient {
  static final Dio _dio = Dio(
    BaseOptions(baseUrl: baseUrl),
  );

  static Dio get instance => _dio;

  static void setup() {
    // Set up interceptors, headers, and any other common configurations
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Add authentication token to headers
        final String? authToken = GetStorage().read('access_token');
        if (authToken != null) {
          options.headers['Authorization'] = 'Bearer $authToken';
        }

        return handler.next(options);
      },
    ));
  }
}
