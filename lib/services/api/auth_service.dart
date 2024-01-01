import 'package:com.jainyouthnoida.pathshala/core/models/api_error_model.dart';
import 'package:com.jainyouthnoida.pathshala/core/models/generic_response.dart';
import 'package:com.jainyouthnoida.pathshala/pages/login/models/login_model.dart';
import 'package:com.jainyouthnoida.pathshala/pages/register/models/register_model.dart';
import 'package:com.jainyouthnoida.pathshala/services/dio_client.dart';
import 'package:dio/dio.dart';

class AuthService {
  final Dio _dio = DioClient.instance;

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
        const errorMessage = 'Invalid credentials.';
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

  Future<RegisterModel> register(FormData formData) async {
    try {
      final response = await _dio.post(
        '/register/',
        data: formData,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return RegisterModel.fromJson(response.data);
      } else {
        return RegisterModel(
          status: 'error',
          message: '',
          data: {},
          error: ApiError.fromJson(response.data['error'] ?? {}),
        );
      }
    } on DioException catch (e) {
      // Handle Dio errors separately
      if (e.response?.statusCode == 401) {
        const errorMessage = 'Invalid credentials.';
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

  Future<GenericApiResponse> logout(String refreshToken) async {
    try {
      final response = await _dio.post(
        '/logout/',
        data: {
          'refresh_token': refreshToken,
        },
      );

      if (response.statusCode == 200) {
        return GenericApiResponse.fromJson(response.data);
      } else {
        return GenericApiResponse(
          status: 'error',
          message: '',
          data: Data(accessToken: '', refreshToken: ''),
          error: ApiError.fromJson(response.data['error'] ?? {}),
        );
      }
    } on DioException catch (e) {
      String errorMessage = '${e.response?.statusMessage}';
      throw Exception(errorMessage);
    } catch (e) {
      // Handle other exceptions
      const errorMessage = 'Unexpected error occurred';
      throw Exception(errorMessage);
    }
  }
}
