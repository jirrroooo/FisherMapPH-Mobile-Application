import 'package:fishermap_ph_mobileapp/features/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SizedBox(
            //   height: 20,
            // ),
            Container(
              height: 250,
              width: 350,
              child: FittedBox(
                  child: Image.asset("assets/images/error.jpg"),
                  fit: BoxFit.fitWidth),
            ),
            // Image(
            //   image: AssetImage("assets/images/error.jpg"),
            //   height: 500,
            //   width: 300,
            //   alignment: Alignment.center,
            // ),
            Text(
              "404 ERROR",
              style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Readex Pro"),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(15),
                  fixedSize: const Size(400, 65),
                  backgroundColor: Color.fromRGBO(0, 39, 68, 1),
                  shadowColor: Colors.transparent,
                ),
                child: const Text(
                  'Retry',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 23,
                      color: Colors.white,
                      fontFamily: "Readex Pro"),
                ),
                onPressed: () => {
                      context.read<AuthBloc>().add(
                            AppStarted(),
                          ),
                    }),
          ],
        ),
      ),
    );
  }
}
