import 'package:fishermap_ph_mobileapp/app_routes.dart';
import 'package:fishermap_ph_mobileapp/features/alert_page/bloc/alert_bloc.dart';
import 'package:fishermap_ph_mobileapp/features/alert_page/repository/alert_repository.dart';
import 'package:fishermap_ph_mobileapp/features/auth/bloc/auth_bloc.dart';
import 'package:fishermap_ph_mobileapp/features/distress_call_page/bloc/distress_bloc.dart';
import 'package:fishermap_ph_mobileapp/features/distress_call_page/repository/ditress_repository.dart';
import 'package:fishermap_ph_mobileapp/features/location_page/bloc/location_bloc.dart';
import 'package:fishermap_ph_mobileapp/features/location_page/repository/location_repository.dart';
import 'package:fishermap_ph_mobileapp/features/profile/bloc/profile_bloc.dart';
import 'package:fishermap_ph_mobileapp/features/profile/repository/profile_repository.dart';
import 'package:fishermap_ph_mobileapp/features/sea_map/bloc/sea_map_bloc.dart';
import 'package:fishermap_ph_mobileapp/features/sea_map/repository/sea_map_repository.dart';
import 'package:fishermap_ph_mobileapp/features/settings/bloc/setting_bloc.dart';
import 'package:fishermap_ph_mobileapp/features/settings/repository/setting_repository.dart';
import 'package:fishermap_ph_mobileapp/home/bloc/home_bloc.dart';
import 'package:fishermap_ph_mobileapp/home/repository/home_repository.dart';
import 'package:fishermap_ph_mobileapp/services/notification/local_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotification.init();
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
        BlocProvider<AlertBloc>(
          create: (BuildContext context) => AlertBloc(AlertRepository()),
        ),
        BlocProvider<LocationBloc>(
          create: (BuildContext context) => LocationBloc(LocationRepository()),
        ),
        BlocProvider<DistressBloc>(
          create: (BuildContext context) => DistressBloc(DistressRepository()),
        ),
        BlocProvider<ProfileBloc>(
          create: (BuildContext context) => ProfileBloc(ProfileRepository()),
        ),
        BlocProvider<SettingBloc>(
          create: (BuildContext context) => SettingBloc(SettingRepository()),
        ),
        BlocProvider<SeaMapBloc>(
          create: (BuildContext context) => SeaMapBloc(SeaMapRepository()),
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
