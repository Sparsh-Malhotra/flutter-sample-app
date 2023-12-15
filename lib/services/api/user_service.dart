import 'package:dio/dio.dart';
import 'package:pathshala/pages/home/models/session_model.dart';
import 'package:pathshala/pages/home/models/user_details_model.dart';
import 'package:pathshala/services/dio_client.dart';

class UserService {
  final Dio _dio = DioClient.instance;

  Future<UserDetailsModel> getUserDetails() async {
    try {
      final response = await _dio.get('/profile/');

      if (response.statusCode == 200) {
        return UserDetailsModel.fromJson(response.data['data']);
      } else {
        throw DioException(
          response: response,
          requestOptions: RequestOptions(path: '/profile/'),
        );
      }
    } catch (e) {
      throw DioException(
        error: e.toString(),
        requestOptions: RequestOptions(path: '/profile/'),
      );
    }
  }

  Future<List<SessionModel>> getSessions(String date) async {
    try {
      final response =
          await _dio.get('/session/', queryParameters: {'date': date});

      if (response.statusCode == 200) {
        final data = response.data['data'] as List<dynamic>;
        final List<SessionModel> sessionArray = [];

        data.forEach((element) {
          sessionArray.add(SessionModel.fromJson(element));
        });

        return sessionArray;
      } else {
        throw DioException(
          response: response,
          requestOptions: RequestOptions(path: '/session/'),
        );
      }
    } catch (e) {
      throw DioException(
        error: e.toString(),
        requestOptions: RequestOptions(path: '/session/'),
      );
    }
  }
}
