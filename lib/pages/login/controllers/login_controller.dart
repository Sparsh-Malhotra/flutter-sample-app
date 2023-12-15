import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pathshala/pages/login/models/login_model.dart';
import 'package:pathshala/services/api/auth_service.dart';
import 'package:pathshala/utils/functions.dart';

class LoginController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  final RxBool isLoading = false.obs;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
}
