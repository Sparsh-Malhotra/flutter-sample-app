import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pathshala/router.dart';
import 'package:pathshala/utils/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: AppColors.primarySwatch,
      ),
      initialRoute: Routes.splashScreen,
      getPages: getPages,
    );
  }
}
