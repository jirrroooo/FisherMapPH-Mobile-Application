import 'package:fishermap_ph_mobileapp/features/auth/screens/login_screen.dart';
import 'package:fishermap_ph_mobileapp/features/auth/screens/register_screen.dart';
import 'package:fishermap_ph_mobileapp/features/prompt/error_screen.dart';
import 'package:fishermap_ph_mobileapp/features/prompt/loading_screen.dart';
import 'package:fishermap_ph_mobileapp/features/prompt/register_success_screen.dart';
import 'package:fishermap_ph_mobileapp/home/home.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  getRoutes() {
    return {
      "/login": (BuildContext context) => const LoginScreen(),
      "/register": (BuildContext context) => const RegisterScreen(),
      "/register-success": (BuildContext context) =>
          const RegisterSuccessScreen(),
      "/loading": (BuildContext context) => const LoadingScreen(),
      "/error": (BuildContext context) => const ErrorScreen(),
      "/homepage": (BuildContext context) => const Homepage(),
    };
  }

  getInitialRoute() {
    return Homepage();
  }
}
