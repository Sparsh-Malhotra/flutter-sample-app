import 'package:com.jainyouthnoida.pathshala/core/models/api_error_model.dart';
import 'package:com.jainyouthnoida.pathshala/core/models/generic_response.dart';
import 'package:com.jainyouthnoida.pathshala/services/dio_client.dart';
import 'package:dio/dio.dart';

class SessionService {
  final Dio _dio = DioClient.instance;

  Future<GenericApiResponse> editSession(Map<String, dynamic> data) async {
    try {
      final response = await _dio.put(
        '/session/',
        data: data,
      );

      if (response.statusCode == 200) {
        return GenericApiResponse.fromJson(response.data);
      } else {
        return GenericApiResponse(
          status: 'error',
          message: '',
          data: '',
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
