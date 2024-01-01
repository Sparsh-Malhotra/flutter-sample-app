import 'package:com.jainyouthnoida.pathshala/pages/home/models/session_model.dart';
import 'package:com.jainyouthnoida.pathshala/pages/home/models/user_details_model.dart';
import 'package:com.jainyouthnoida.pathshala/services/dio_client.dart';
import 'package:dio/dio.dart';

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
        final onlineData = response.data['data']['online'] as List<dynamic>;
        final offlineData = response.data['data']['offline'] as List<dynamic>;
        final List<SessionModel> sessionArray = [];

        onlineData.forEach((element) {
          sessionArray.add(SessionModel.fromJson({
            ...element,
            'mode': 'online',
          }));
        });

        offlineData.forEach((element) {
          sessionArray.add(SessionModel.fromJson({
            ...element,
            'mode': 'offline',
          }));
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

  Future<UserDetailsModel> updateProfile(Map<String, dynamic> data) async {
    try {
      FormData formData = FormData.fromMap(data);
      final response = await _dio.patch('/profile/', data: formData);

      if (response.statusCode == 200) {
        return UserDetailsModel.fromJson(response.data);
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
