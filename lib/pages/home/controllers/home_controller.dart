import 'package:get/get.dart';
import 'package:pathshala/pages/home/models/session_model.dart';

class HomeController extends GetxController {
  Rx<DateTime> selectedDate = DateTime.now().obs;
  Rx<List<SessionModel>> sessions = Rx<List<SessionModel>>([]);
}
