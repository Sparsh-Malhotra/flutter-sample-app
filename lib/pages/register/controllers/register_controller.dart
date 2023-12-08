import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData;
import 'package:intl/intl.dart';
import 'package:pathshala/pages/register/models/register_model.dart';
import 'package:pathshala/services/auth_service.dart';

class RegisterController extends GetxController {
  RxString firstName = ''.obs;
  RxString middleName = ''.obs;
  RxString lastName = ''.obs;
  RxString dob = DateFormat('dd/MM/yyyy').format(DateTime.now()).obs;
  RxString phone = ''.obs;
  RxString email = ''.obs;
  RxString username = ''.obs;
  RxString password = ''.obs;
  Rxn<int> role = Rxn<int>(null);
  Rxn<String> bloodGroup = Rxn<String>(null);

  final AuthService _authService = AuthService();
  final RxBool isLoading = false.obs;

  Future<void> register() async {
    final FormData formData = FormData.fromMap({
      'username': username.value,
      'password': password.value,
      'profile.first_name': firstName.value,
      'profile.middle_name': middleName.value,
      'profile.last_name': lastName.value,
      'profile.groups': role.value,
      'profile.dob': DateFormat('yyyy-MM-dd').format(
        DateFormat('dd/MM/yyyy').parse(dob.value),
      ),
      'profile.phone': phone.value,
      'profile.email': email.value,
      'profile.blood_group': bloodGroup.value,
    });

    try {
      final RegisterModel registerResponse =
          await _authService.register(formData);

      if (registerResponse.status == 'success') {
        Get.offNamed('/login');
      } else {
        final errorMessage = registerResponse.error?.message ?? 'Unknown error';
        showErrorMessage(errorMessage);
      }
    } on Exception catch (e) {
      showErrorMessage(e.toString());
    } finally {
      isLoading.toggle();
    }
  }

  void showErrorMessage(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(15),
    );
  }
}
