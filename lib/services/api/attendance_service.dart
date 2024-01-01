import 'package:com.jainyouthnoida.pathshala/pages/attendance/models/mark_attendance.dart';
import 'package:com.jainyouthnoida.pathshala/pages/attendance/models/student.dart';
import 'package:com.jainyouthnoida.pathshala/services/dio_client.dart';
import 'package:dio/dio.dart';

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

  Future<PresentAttendeesResponse> getPresentAttendees(
      String date, String bhaagClassSectionId) async {
    try {
      final response = await _dio.get('/attendance/', queryParameters: {
        'date': date,
        'bhaag_class_section_id': bhaagClassSectionId,
      });

      if (response.statusCode == 200) {
        return PresentAttendeesResponse.fromJson(response.data);
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
