import 'package:flutter/material.dart';

class RegisterSuccessScreen extends StatelessWidget {
  const RegisterSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 70),
            Image(
              image: AssetImage("assets/images/success.jpg"),
              height: 450,
            ),
            Text(
              "Account Successfully Created!",
              style: TextStyle(
                  fontFamily: "Readex Pro",
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "You can now login to your newly created FisherMap PH account. Be reminded to verify your identity on the profile page inside the application.",
              style: TextStyle(
                fontFamily: "Readex Pro",
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(15),
                  fixedSize: const Size(400, 65),
                  backgroundColor: Color.fromRGBO(0, 39, 68, 1),
                  shadowColor: Colors.transparent,
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 23,
                      color: Colors.white,
                      fontFamily: "Readex Pro"),
                ),
                onPressed: () =>
                    {Navigator.popAndPushNamed(context, "/login")}),
          ],
        ),
      ),
    );
  }
}
