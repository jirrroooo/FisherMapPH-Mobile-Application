import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetImage("assets/images/loading.gif"),
            height: 300,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Loading...",
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
                fontFamily: "Readex Pro"),
          )
        ],
      ),
    );
  }
}
