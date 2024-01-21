import 'package:get/get.dart';
import 'package:pathshala/pages/attendance/views/attendance.dart';
import 'package:pathshala/pages/books/views/books.dart';
import 'package:pathshala/pages/home/views/home.dart';
import 'package:pathshala/pages/read_text/views/read_text.dart';
import 'package:pathshala/pages/login/views/login.dart';
import 'package:pathshala/pages/register/views/register.dart';
import 'package:pathshala/pages/resources/views/resources.dart';
import 'package:pathshala/pages/video_library/views/video_library.dart';
import 'package:pathshala/splash_screen.dart';

class Routes {
  static String splashScreen = '/';
  static String loginScreen = '/login';
  static String registerScreen = '/register';
  static String homeScreen = '/home';
  static String attendanceScreen = '/attendance';
  static String booksScreen = '/books';
  static String videoLibraryScreen = '/video-library';
  static String resourcesScreen = '/resources';
  static String readTextScreen = '/read_text';
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
  GetPage(
    name: Routes.booksScreen,
    page: () => const BooksScreen(),
  ),
  GetPage(
    name: Routes.videoLibraryScreen,
    page: () => VideoLibraryScreen(),
  ),
  GetPage(
    name: Routes.resourcesScreen,
    page: () => ResourcesScreen(),
  ),
  GetPage(
    name: Routes.readTextScreen,
    page: () => ReadTextScreen(text: 'Error 404', title: "Error 404",),
  ),
];
