import 'package:fishermap_ph_mobileapp/features/auth/bloc/auth_bloc.dart';
import 'package:fishermap_ph_mobileapp/features/auth/models/enum.dart';
import 'package:fishermap_ph_mobileapp/features/auth/widgets/auth_field.dart';
import 'package:fishermap_ph_mobileapp/features/prompt_page/error_screen.dart';
import 'package:fishermap_ph_mobileapp/features/prompt_page/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final contactNumberController = TextEditingController();
  final addressController = TextEditingController();
  final birthdayController = TextEditingController();
  final civilStatusController = TextEditingController();
  final fishingVesselTypeController = TextEditingController();
  final sexController = TextEditingController();
  final passwordController1 = TextEditingController();
  final passwordController2 = TextEditingController();

  bool isHide1 = true;
  bool isHide2 = true;

  @override
  Widget build(BuildContext context) {
    DateTime? pickedDate;

    var _selectedVesselType;
    var _selectedCivilStatus;
    var _selectedSex;

    const fieldGap = 15.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register an Account',
          style: TextStyle(
            fontSize: 22,
            fontFamily: 'Readex Pro',
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(0, 39, 68, 1),
          ),
        ),
      ),
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

          if (state is AuthRegisterSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Successful Registration!"),
              ),
            );

            // Future.delayed(const Duration(seconds: 1), () {});

            Navigator.popAndPushNamed(context, '/register-success');
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
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(height: 10),
              AuthField(
                hintText: 'Enter First Name',
                controller: firstNameController,
              ),
              SizedBox(height: fieldGap),
              AuthField(
                hintText: 'Enter Last Name',
                controller: lastNameController,
              ),
              SizedBox(height: fieldGap),
              DropdownMenu<Sex>(
                width: 380,
                leadingIcon: Icon(Icons.assignment_ind),
                enableSearch: true,
                controller: sexController,
                enableFilter: false,
                requestFocusOnTap: true,
                hintText: "Enter Sex Assigned at Birth",
                onSelected: (Sex? sex) {
                  setState(() {
                    _selectedSex = sex;
                  });
                },
                inputDecorationTheme: InputDecorationTheme(
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: const EdgeInsets.all(27),
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
                ),
                dropdownMenuEntries: Sex.values.map<DropdownMenuEntry<Sex>>(
                  (Sex sex) {
                    return DropdownMenuEntry<Sex>(
                        value: sex, label: sex.label, enabled: true);
                  },
                ).toList(),
              ),
              SizedBox(height: fieldGap),
              AuthField(
                hintText: 'Enter Email Address',
                controller: emailController,
              ),
              SizedBox(height: fieldGap),
              AuthField(
                hintText: 'Enter Contact Number',
                controller: contactNumberController,
              ),
              SizedBox(height: fieldGap),
              AuthField(
                hintText: 'Enter Address',
                controller: addressController,
              ),
              SizedBox(height: fieldGap),
              TextFormField(
                keyboardType: TextInputType.datetime,
                controller: birthdayController,
                onTap: () async => {
                  pickedDate = await showDatePicker(
                    context: context,
                    lastDate: DateTime.now(),
                    firstDate: DateTime(1930),
                    initialDate: DateTime.now(),
                  ),
                  // if (pickedDate == null) return;
                  birthdayController.text =
                      DateFormat('yyyy-MM-dd').format(pickedDate!)
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.perm_contact_calendar),
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
                  hintText: "Enter your Birthday",
                ),
              ),
              SizedBox(height: fieldGap),
              DropdownMenu<CivilStatus>(
                width: 380,
                leadingIcon: Icon(Icons.assignment),
                enableSearch: true,
                controller: civilStatusController,
                enableFilter: false,
                requestFocusOnTap: true,
                hintText: "Enter Civil Status",
                onSelected: (CivilStatus? civilStatus) {
                  setState(() {
                    _selectedCivilStatus = civilStatus;
                  });
                },
                inputDecorationTheme: InputDecorationTheme(
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: const EdgeInsets.all(27),
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
                ),
                dropdownMenuEntries:
                    CivilStatus.values.map<DropdownMenuEntry<CivilStatus>>(
                  (CivilStatus civilStatus) {
                    return DropdownMenuEntry<CivilStatus>(
                        value: civilStatus,
                        label: civilStatus.label,
                        enabled: true);
                  },
                ).toList(),
              ),
              SizedBox(height: fieldGap),
              DropdownMenu<VesselType>(
                width: 380,
                leadingIcon: Icon(Icons.directions_boat),
                enableSearch: true,
                controller: fishingVesselTypeController,
                enableFilter: false,
                requestFocusOnTap: true,
                hintText: "Enter Vessel Type",
                onSelected: (VesselType? vesselType) {
                  setState(() {
                    _selectedVesselType = vesselType;
                  });
                },
                inputDecorationTheme: InputDecorationTheme(
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: const EdgeInsets.all(27),
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
                ),
                dropdownMenuEntries:
                    VesselType.values.map<DropdownMenuEntry<VesselType>>(
                  (VesselType vesselType) {
                    return DropdownMenuEntry<VesselType>(
                        value: vesselType,
                        label: vesselType.label,
                        enabled: true);
                  },
                ).toList(),
              ),
              SizedBox(height: fieldGap),
              TextFormField(
                obscureText: isHide1,
                controller: passwordController1,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.vpn_key),
                  suffixIcon: IconButton(
                      icon: isHide1
                          ? Icon(Icons.remove_red_eye)
                          : Icon(Icons.visibility_off),
                      onPressed: () => {
                            setState(() {
                              isHide1 = !isHide1;
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
              SizedBox(height: fieldGap),
              TextFormField(
                obscureText: isHide2,
                controller: passwordController2,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.vpn_key),
                  suffixIcon: IconButton(
                      icon: isHide2
                          ? Icon(Icons.remove_red_eye)
                          : Icon(Icons.visibility_off),
                      onPressed: () => {
                            setState(() {
                              isHide2 = !isHide2;
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
                  hintText: "Confirm Password",
                ),
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
                    'Register',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 23,
                        color: Colors.white,
                        fontFamily: "Readex Pro"),
                  ),
                  onPressed: () => {
                        context.read<AuthBloc>().add(AuthRegisterRequested(
                            first_name: firstNameController.text.trim(),
                            last_name: lastNameController.text.trim(),
                            sex: sexController.text.trim().toLowerCase(),
                            email_address: emailController.text.trim(),
                            contact_number: contactNumberController.text.trim(),
                            address: addressController.text.trim(),
                            birthday: serializeBirthday(
                                birthdayController.text.trim()),
                            civil_status:
                                civilStatusController.text.trim().toLowerCase(),
                            fishing_vessel_type: fishingVesselTypeController
                                .text
                                .trim()
                                .toLowerCase(),
                            user_type: 'user',
                            password: passwordController1.text.trim(),
                            confirm_password: passwordController2.text.trim()))
                      }),

              // SizedBox(height: 30),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     const Text('Read the Privacy Policy here',
              //         style: TextStyle(
              //             fontSize: 12,
              //             fontFamily: 'Readex Pro',
              //             color: Colors.black)),
              //     IconButton(
              //         style: IconButton.styleFrom(
              //           padding: EdgeInsets.zero,
              //           minimumSize: Size(30, 10),
              //           tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              //         ),
              //         icon: Icon(Icons.keyboard_arrow_right,
              //             color: Color.fromRGBO(171, 83, 50, 1)),
              //         onPressed: () => {}),
              //   ],
              // ),
            ]),
          ));
        },
      ),
    );
  }

  DateTime serializeBirthday(String text) {
    var data = text.split('-');

    return DateTime(int.parse(data[0]), int.parse(data[1]), int.parse(data[2]));
  }
}
