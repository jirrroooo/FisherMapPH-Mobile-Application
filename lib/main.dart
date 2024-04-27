import 'package:fishermap_ph_mobileapp/app_routes.dart';
import 'package:fishermap_ph_mobileapp/features/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppRoutes appRoutes = AppRoutes();

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (BuildContext context) => AuthBloc(),
        ),
      ],
      child: MaterialApp(
          routes: appRoutes.getRoutes(),
          debugShowCheckedModeBanner: false,
          // theme: ThemeData.dark(useMaterial3: true),
          home: appRoutes.getInitialRoute()),
    );
  }
}
