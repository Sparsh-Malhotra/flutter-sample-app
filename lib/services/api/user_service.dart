import 'package:dio/dio.dart';
import 'package:pathshala/pages/home/models/user_details_model.dart';
import 'package:pathshala/services/dio_client.dart'; // Adjust the import path

class UserService {
  final Dio _dio = DioClient.instance;

  Future<UserDetailsModel> getUserDetails() async {
    final response = await _dio.get('/profile/'); // Adjust the API endpoint

    if (response.statusCode == 200) {
      return UserDetailsModel.fromJson(response.data['data']);
    } else {
      throw Exception('Failed to load user details');
    }
  }
}
