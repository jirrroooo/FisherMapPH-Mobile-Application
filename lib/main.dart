import 'package:fishermap_ph_mobileapp/presentation/screens/login_screen.dart';
import 'package:fishermap_ph_mobileapp/presentation/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/login": (BuildContext context) => const LoginScreen(),
        "/register": (BuildContext context) => const RegisterScreen(),
      },
      debugShowCheckedModeBanner: false,
      // theme: ThemeData.dark(useMaterial3: true),
      home: LoginScreen(),
    );
  }
}
