import 'package:get/get.dart';
import 'package:com.jainyouthnoida.pathshala/pages/attendance/models/attendee.dart';

class AttendanceController extends GetxController {
  final Rx<List<Attendee>> students = Rx<List<Attendee>>([]);
}
