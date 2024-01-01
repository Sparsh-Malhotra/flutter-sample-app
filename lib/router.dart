import 'package:get/get.dart';
import 'package:com.jainyouthnoida.pathshala/pages/attendance/views/attendance.dart';
import 'package:com.jainyouthnoida.pathshala/pages/books/views/books.dart';
import 'package:com.jainyouthnoida.pathshala/pages/home/views/home.dart';
import 'package:com.jainyouthnoida.pathshala/pages/login/views/login.dart';
import 'package:com.jainyouthnoida.pathshala/pages/register/views/register.dart';
import 'package:com.jainyouthnoida.pathshala/pages/video_library/views/video_library.dart';
import 'package:com.jainyouthnoida.pathshala/splash_screen.dart';

class Routes {
  static String splashScreen = '/';
  static String loginScreen = '/login';
  static String registerScreen = '/register';
  static String homeScreen = '/home';
  static String attendanceScreen = '/attendance';
  static String booksScreen = '/books';
  static String videoLibraryScreen = '/video-library';
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
    page: () => const VideoLibraryScreen(),
  ),
];
