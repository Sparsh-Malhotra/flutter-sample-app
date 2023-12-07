import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RegisterController extends GetxController {
  RxString firstName = ''.obs;
  RxString middleName = ''.obs;
  RxString lastName = ''.obs;
  RxString dob = DateFormat('dd/MM/yyyy').format(DateTime.now()).obs;
  RxString phone = ''.obs;
  RxString email = ''.obs;
  RxString username = ''.obs;
  Rxn<String> role = Rxn<String>(null);
}
