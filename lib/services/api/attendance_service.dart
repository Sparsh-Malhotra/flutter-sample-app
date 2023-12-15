import 'package:dio/dio.dart';
import 'package:pathshala/pages/attendance/models/mark_attendance.dart';
import 'package:pathshala/pages/attendance/models/student.dart';
import 'package:pathshala/services/dio_client.dart';

class AttendanceService {
  final Dio _dio = DioClient.instance;

  Future<SessionStudent> getStudents(String id) async {
    try {
      final response = await _dio.get('/students/', queryParameters: {
        'bhaag_class_section_id': id,
      });

      if (response.statusCode == 200) {
        return SessionStudent.fromJson(response.data);
      } else {
        throw DioException(
          response: response,
          requestOptions: RequestOptions(path: '/students/'),
        );
      }
    } catch (e) {
      throw DioException(
        error: e.toString(),
        requestOptions: RequestOptions(path: '/students/'),
      );
    }
  }

  Future<MarkAttendanceResponse> markAttendance(
      Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/attendance/', data: data);

      if (response.statusCode == 200) {
        return MarkAttendanceResponse.fromJson(response.data);
      } else {
        throw DioException(
          response: response,
          requestOptions: RequestOptions(path: '/attendance/'),
        );
      }
    } catch (e) {
      throw DioException(
        error: e.toString(),
        requestOptions: RequestOptions(path: '/attendance/'),
      );
    }
  }
}
