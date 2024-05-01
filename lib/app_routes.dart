import 'package:fishermap_ph_mobileapp/data/secure_storage.dart';
import 'package:fishermap_ph_mobileapp/features/alert_page/screens/alert_log_screen.dart';
import 'package:fishermap_ph_mobileapp/features/auth/screens/login_screen.dart';
import 'package:fishermap_ph_mobileapp/features/auth/screens/register_screen.dart';
import 'package:fishermap_ph_mobileapp/features/distress_call_page/screens/distress_call_logs_screen.dart';
import 'package:fishermap_ph_mobileapp/features/location_page/screens/location_log_screen.dart';
import 'package:fishermap_ph_mobileapp/features/notification/screens/notification_screen.dart';
import 'package:fishermap_ph_mobileapp/features/profile/screens/profile_screen.dart';
import 'package:fishermap_ph_mobileapp/features/prompt_page/error_screen.dart';
import 'package:fishermap_ph_mobileapp/features/prompt_page/loading_screen.dart';
import 'package:fishermap_ph_mobileapp/features/prompt_page/register_success_screen.dart';
import 'package:fishermap_ph_mobileapp/features/settings/screens/settings_page.dart';
import 'package:fishermap_ph_mobileapp/features/static_pages/screens/about.dart';
import 'package:fishermap_ph_mobileapp/features/static_pages/screens/credits.dart';
import 'package:fishermap_ph_mobileapp/features/static_pages/screens/privacy_policy.dart';
import 'package:fishermap_ph_mobileapp/features/weather/screens/weather_page.dart';
import 'package:fishermap_ph_mobileapp/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppRoutes {
  SecureStorage secureStorage = new SecureStorage();

  FlutterSecureStorage sT = FlutterSecureStorage();

  getRoutes() {
    return {
      "/login": (BuildContext context) => const LoginScreen(),
      "/register": (BuildContext context) => const RegisterScreen(),
      "/register-success": (BuildContext context) =>
          const RegisterSuccessScreen(),
      "/loading": (BuildContext context) => const LoadingScreen(),
      "/error": (BuildContext context) => const ErrorScreen(),
      "/homepage": (BuildContext context) => const Homepage(),
      "/alerts": (BuildContext context) => const AlertLogPage(),
      "/location": (BuildContext context) => const LocationLogPage(),
      "/distress-call-logs": (BuildContext context) =>
          const DistressCallLogsScreen(),
      "/profile": (BuildContext context) => const ProfileScreen(),
      "/notification": (BuildContext context) => const NotificationScreen(),
      "/weather": (BuildContext context) => const WeatherScreen(),
      "/settings": (BuildContext context) => const SettingsScreen(),
      "/credits": (BuildContext context) => const CreditsPage(),
      "/about": (BuildContext context) => const AboutPage(),
      "/privacy-policy": (BuildContext context) => const PrivacyPolicyPage(),
    };
  }

  Future<Widget> getInitialRoute() async {
    if (await sT.containsKey(key: "token")) {
      return Homepage();
    }

    return LoginScreen();
  }
}
