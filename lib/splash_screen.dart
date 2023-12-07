import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pathshala/utils/app_colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 2500)).then((value) =>
        GetStorage().hasData('access_token')
            ? Get.toNamed('/home')
            : Get.toNamed('/login'));

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SizedBox(
        height: height,
        width: width,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Image.asset(
              'assets/images/background_vector.png',
            ),
            Image.asset(
              'assets/images/logo_white.png',
              height: 250,
              width: 250,
            ),
          ],
        ),
      ),
    );
  }
}
