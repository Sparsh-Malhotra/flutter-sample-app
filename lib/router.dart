import 'package:get/get.dart';
import 'package:pathshala/pages/attendance/views/attendance.dart';
import 'package:pathshala/pages/home/views/home.dart';
import 'package:pathshala/pages/login/views/login.dart';
import 'package:pathshala/pages/register/views/register.dart';
import 'package:pathshala/splash_screen.dart';

class Routes {
  static String splashScreen = '/';
  static String loginScreen = '/login';
  static String registerScreen = '/register';
  static String homeScreen = '/home';
  static String attendanceScreen = '/attendance';
}

final getPages = [
  GetPage(
    name: Routes.splashScreen,
    page: () => const SplashScreen(),
  ),
  GetPage(
    name: Routes.loginScreen,
    page: () => const LoginScreen(),
  ),
  GetPage(
    name: Routes.registerScreen,
    page: () => const RegisterScreen(),
  ),
  GetPage(
    name: Routes.homeScreen,
    page: () => const HomeScreen(),
  ),
  GetPage(
    name: Routes.attendanceScreen,
    page: () => AttendanceScreen(),
  ),
];
