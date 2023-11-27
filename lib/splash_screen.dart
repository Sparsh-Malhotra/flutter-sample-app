import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pathshala/pages/home.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen(
      duration: const Duration(milliseconds: 2500),
      backgroundColor: Theme.of(context).primaryColorDark,
      nextScreen: const HomeScreen(),
      splashScreenBody: Center(
        child: Lottie.asset(
          'assets/lottie/splash_screen.json',
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
