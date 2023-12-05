import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pathshala/pages/home/views/home.dart';
import 'package:pathshala/pages/login/views/login.dart';
import 'package:pathshala/pages/register/views/register.dart';
import 'package:pathshala/splash_screen.dart';

class CustomSlideTransition extends CustomTransitionPage<void> {
  CustomSlideTransition({super.key, required super.child})
      : super(
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (_, animation, __, child) {
            return SlideTransition(
              position: animation.drive(
                Tween(
                  begin: const Offset(1.5, 0),
                  end: Offset.zero,
                ).chain(
                  CurveTween(curve: Curves.ease),
                ),
              ),
              child: child,
            );
          },
        );
}

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: 'splash-screen',
      path: '/',
      pageBuilder: (ctx, state) => CustomSlideTransition(
        key: state.pageKey,
        child: const SplashScreen(),
      ),
    ),
    GoRoute(
      name: 'login',
      path: '/login',
      pageBuilder: (ctx, state) => CustomSlideTransition(
        key: state.pageKey,
        child: const LoginScreen(),
      ),
    ),
    GoRoute(
      name: 'register',
      path: '/register',
      pageBuilder: (ctx, state) => CustomSlideTransition(
        key: state.pageKey,
        child: const RegisterScreen(),
      ),
    ),
    GoRoute(
      name: 'home',
      path: '/home',
      pageBuilder: (ctx, state) => CustomSlideTransition(
        key: state.pageKey,
        child: HomeScreen(),
      ),
    ),
  ],
);
