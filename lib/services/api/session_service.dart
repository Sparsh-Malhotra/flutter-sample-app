import 'package:dio/dio.dart';
import 'package:pathshala/core/models/api_error_model.dart';
import 'package:pathshala/core/models/generic_response.dart';
import 'package:pathshala/services/dio_client.dart';

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
      const errorMessage = 'Unexpected error occurred';
      throw Exception(errorMessage);
    } catch (e) {
      // Handle other exceptions
      const errorMessage = 'Unexpected error occurred';
      throw Exception(errorMessage);
    }
  }
}
