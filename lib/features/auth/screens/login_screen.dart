import 'package:fishermap_ph_mobileapp/features/auth/bloc/auth_bloc.dart';
import 'package:fishermap_ph_mobileapp/features/auth/widgets/auth_field.dart';
import 'package:fishermap_ph_mobileapp/features/prompt_page/error_screen.dart';
import 'package:fishermap_ph_mobileapp/features/prompt_page/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isHide = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.error,
                ),
              ),
            );
          }

          if (state is AuthLoginSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Successful Login!"),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const LoadingScreen();
          } else if (state is AuthSocketException) {
            return const ErrorScreen();
          }
          return SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                Image(
                  image: AssetImage("assets/images/FisherMapPH.png"),
                  height: 200,
                ),
                SizedBox(height: 10),
                const Text('Welcome to FisherMap PH!',
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'Readex Pro',
                      fontWeight: FontWeight.w800,
                    )),
                const Text(
                  'Our goal is to provide an organized platform that increases the security and broaden the linkages among the fisherfolk in the Philippines.',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Readex Pro',
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 35),
                AuthField(
                  hintText: 'Enter your Email Address',
                  controller: emailController,
                ),
                SizedBox(height: 20),
                // AuthField(
                //   hintText: 'Enter Password',
                //   controller: passwordController,
                // ),
                TextFormField(
                  obscureText: isHide,
                  controller: passwordController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.vpn_key),
                    suffixIcon: IconButton(
                        icon: isHide
                            ? Icon(Icons.remove_red_eye)
                            : Icon(Icons.visibility_off),
                        onPressed: () => {
                              setState(() {
                                isHide = !isHide;
                              })
                            }),
                    contentPadding: const EdgeInsets.all(25),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(59, 58, 69, 1),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(0, 0, 0, 0.498),
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: "Enter Password",
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                ElevatedButton(
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
                          fontFamily: "Readex Pro"),
                    ),
                    onPressed: () => {
                          context.read<AuthBloc>().add(
                                AuthLoginRequested(
                                  email_address: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                ),
                              )
                        }),

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
                        icon: Icon(Icons.keyboard_arrow_right),
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
          ));
        },
      ),
    );
  }
}
