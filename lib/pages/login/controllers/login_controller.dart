import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pathshala/pages/login/models/login_model.dart';
import 'package:pathshala/services/auth_service.dart';

class LoginController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  final RxBool isLoading = false.obs;

  Future<void> login() async {
    final String username = usernameController.text;
    final String password = passwordController.text;

    try {
      isLoading.toggle();
      final LoginModel loginResponse =
          await _authService.login(username, password);

      if (loginResponse.status == 'success') {
        GetStorage().write('access_token', loginResponse.data.accessToken);
        GetStorage().write('refresh_token', loginResponse.data.refreshToken);
        Get.offNamed('/home');
      } else {
        final errorMessage = loginResponse.error?.message ?? 'Unknown error';
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
      duration: const Duration(milliseconds: 2000),
      margin: const EdgeInsets.all(15),
    );
  }
}
