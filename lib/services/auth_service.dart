import 'package:dio/dio.dart';
import 'package:pathshala/core/models/api_error_model.dart';
import 'package:pathshala/pages/login/models/login_model.dart';

class AuthService {
  final Dio _dio = Dio(
    BaseOptions(baseUrl: 'http://184.72.203.57:9000/pathshala'),
  );

  Future<LoginModel> login(String username, String password) async {
    try {
      final response = await _dio.post(
        '/login/',
        data: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        return LoginModel.fromJson(response.data);
      } else {
        return LoginModel(
          status: 'error',
          message: '',
          data: Data(accessToken: '', refreshToken: ''),
          error: ApiError.fromJson(response.data['error'] ?? {}),
        );
      }
    } on DioException catch (e) {
      // Handle Dio errors separately
      if (e.response?.statusCode == 401) {
        const errorMessage = 'Invalid credentials. Please try again.';
        throw Exception(errorMessage);
      } else {
        const errorMessage = 'Unexpected error occurred';
        throw Exception(errorMessage);
      }
    } catch (e) {
      // Handle other exceptions
      const errorMessage = 'Unexpected error occurred';
      throw Exception(errorMessage);
    }
  }
}
