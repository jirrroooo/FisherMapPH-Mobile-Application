import 'package:fishermap_ph_mobileapp/features/auth/bloc/auth_bloc.dart';
import 'package:fishermap_ph_mobileapp/features/auth/screens/login_screen.dart';
import 'package:fishermap_ph_mobileapp/features/auth/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (BuildContext context) => AuthBloc(),
        ),
      ],
      child: MaterialApp(
        routes: {
          "/login": (BuildContext context) => const LoginScreen(),
          "/register": (BuildContext context) => const RegisterScreen(),
        },
        debugShowCheckedModeBanner: false,
        // theme: ThemeData.dark(useMaterial3: true),
        home: LoginScreen(),
      ),
    );
  }
}
