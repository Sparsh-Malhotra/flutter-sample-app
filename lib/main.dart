import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pathshala/router.dart';
import 'package:pathshala/utils/app_colors.dart';
import 'package:pathshala/services/dio_client.dart';

void main() async {
  await GetStorage.init();
  DioClient.setup();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: AppColors.primarySwatch,
      ),
      debugShowCheckedModeBanner: true,
      initialRoute: Routes.splashScreen,
      getPages: getPages,
    );
  }
}
