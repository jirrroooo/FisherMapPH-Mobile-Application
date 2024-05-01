import 'package:fishermap_ph_mobileapp/app_routes.dart';
import 'package:fishermap_ph_mobileapp/features/auth/bloc/auth_bloc.dart';
import 'package:fishermap_ph_mobileapp/home/bloc/home_bloc.dart';
import 'package:fishermap_ph_mobileapp/home/repository/home_repository.dart';
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
        BlocProvider<HomeBloc>(
          create: (BuildContext context) => HomeBloc(HomeRepository()),
        ),
      ],
      child: MaterialApp(
          routes: appRoutes.getRoutes(),
          debugShowCheckedModeBanner: false,
          // theme: ThemeData.dark(useMaterial3: true),
          home: FutureBuilder<Widget>(
              future: appRoutes.getInitialRoute(),
              builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                if (!snapshot.hasData) {
                  // while data is loading:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  // data loaded:
                  return snapshot.data!;
                }
              })),
    );
  }
}
