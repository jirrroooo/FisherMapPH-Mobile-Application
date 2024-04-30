import 'package:fishermap_ph_mobileapp/features/auth/screens/login_screen.dart';
import 'package:fishermap_ph_mobileapp/features/auth/screens/register_screen.dart';
import 'package:fishermap_ph_mobileapp/features/distress_call_page/screens/distress_call_logs_screen.dart';
import 'package:fishermap_ph_mobileapp/features/prompt/error_screen.dart';
import 'package:fishermap_ph_mobileapp/features/prompt/loading_screen.dart';
import 'package:fishermap_ph_mobileapp/features/prompt/register_success_screen.dart';
import 'package:fishermap_ph_mobileapp/features/static_pages/screens/about.dart';
import 'package:fishermap_ph_mobileapp/features/static_pages/screens/credits.dart';
import 'package:fishermap_ph_mobileapp/features/static_pages/screens/privacy_policy.dart';
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
      "/distress-call-logs": (BuildContext context) =>
          const DistressCallLogsScreen(),
      "/credits": (BuildContext context) => const CreditsPage(),
      "/about": (BuildContext context) => const AboutPage(),
      "/privacy-policy": (BuildContext context) => const PrivacyPolicyPage(),
    };
  }

  getInitialRoute() {
    return Homepage();
  }
}
