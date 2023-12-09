import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class DioClient {
  static final Dio _dio = Dio(
    BaseOptions(baseUrl: 'http://184.72.203.57:9000/pathshala'),
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