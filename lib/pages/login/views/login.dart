import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pathshala/pages/login/controllers/login_controller.dart';
import 'package:pathshala/pages/login/views/mobile_input.dart';
import 'package:pathshala/utils/app_colors.dart';
import 'package:pathshala/utils/app_text_styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController _loginController = Get.put(LoginController());

  void handleSubmit() {
    _loginController.login();
  }

  void handleVerifyOtp() {
    Get.toNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.40,
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width,
                    child: Image.asset('assets/images/background_vector.png',
                        fit: BoxFit.fitWidth),
                  ),
                  Image.asset(
                    'assets/images/logo_white.png',
                    height: height * 0.5,
                    width: width * 0.5,
                  ),
                  Positioned(
                    bottom: 30,
                    child: Text(
                      'Sign In',
                      style: AppTextStyle.regularWhite30,
                    ),
                  ),
                ],
              ),
            ),
            // AnimatedSwitcher(
            //   duration: const Duration(milliseconds: 500),
            //   switchInCurve: Curves.easeIn,
            //   // switchOutCurve: Curves.easeOut,
            //   transitionBuilder: (child, animation) {
            //     return SlideTransition(
            //       position: Tween<Offset>(
            //               begin: const Offset(1, 0), end: const Offset(0, 0))
            //           .animate(animation),
            //       child: child,
            //     );
            //   },
            //   child: content,
            // ),
            MobileInput(onSubmit: handleSubmit)
          ],
        ),
      ),
    );
  }
}
