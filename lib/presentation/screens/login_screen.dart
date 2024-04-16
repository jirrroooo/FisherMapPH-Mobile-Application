import 'package:fishermap_ph_mobileapp/presentation/widgets/auth_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100),
            const Text('Welcome to',
                style: TextStyle(
                  fontSize: 50,
                  fontFamily: 'Readex Pro',
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(0, 39, 68, 1),
                )),
            const Text('FisherMap PH',
                style: TextStyle(
                  fontSize: 50,
                  fontFamily: 'Readex Pro',
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(0, 39, 68, 1),
                )),
            SizedBox(height: 50),
            AuthField(
              hintText: 'Enter Email Address',
              controller: emailController,
            ),
            SizedBox(height: 20),
            AuthField(
              hintText: 'Enter Password',
              controller: passwordController,
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () => {},
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(15),
                fixedSize: const Size(400, 65),
                backgroundColor: Color.fromRGBO(0, 39, 68, 1),
                shadowColor: Colors.transparent,
              ),
              child: const Text(
                'Login',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 23,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('No account yet? Register here',
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Readex Pro',
                        color: Colors.black)),
                // Text('here',
                //     style: TextStyle(
                //         fontSize: 14,
                //         fontFamily: 'Readex Pro',
                //         color: Color.fromRGBO(171, 83, 50, 1))),
                // Icon(Icons.keyboard_arrow_right,
                //     color: Color.fromRGBO(171, 83, 50, 1))
                IconButton(
                    style: IconButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size(30, 10),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    icon: Icon(Icons.keyboard_arrow_right,
                        color: Color.fromRGBO(171, 83, 50, 1)),
                    onPressed: () =>
                        {Navigator.pushNamed(context, '/register')}),
              ],
            ),
            SizedBox(
              height: 185,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Read the Privacy Policy here',
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Readex Pro',
                        color: Colors.black)),
                // TextButton(
                //   style: TextButton.styleFrom(
                //     padding: EdgeInsets.zero,
                //     minimumSize: Size(50, 30),
                //   ),
                //   onPressed: () => {},
                //   child: const Text('here',
                //       style: TextStyle(
                //           fontSize: 14,
                //           fontFamily: 'Readex Pro',
                //           color: Color.fromRGBO(171, 83, 50, 1))),
                // ),
                IconButton(
                    style: IconButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size(30, 10),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    icon: Icon(Icons.keyboard_arrow_right,
                        color: Color.fromRGBO(171, 83, 50, 1)),
                    onPressed: () => {}),
                // Icon(Icons.keyboard_arrow_right,
                //     color: Color.fromRGBO(171, 83, 50, 1))
              ],
            ),
          ],
        ),
      )),
    );
  }
}
