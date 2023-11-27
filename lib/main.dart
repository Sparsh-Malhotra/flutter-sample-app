import 'package:flutter/material.dart';
import 'package:pathshala/splash_screen.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromRGBO(29, 158, 241, 1));

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
      ),
      home: const SplashScreen(),
    );
  }
}
