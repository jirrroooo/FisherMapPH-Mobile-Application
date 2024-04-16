import 'package:fishermap_ph_mobileapp/presentation/widgets/auth_field.dart';
import 'package:flutter/material.dart';

enum VesselType {
  small("Small"),
  medium("Medium"),
  large("Large");

  const VesselType(this.label);
  final String label;
}

enum CivilStatus {
  married("Married"),
  single("Single"),
  widowed("Widowed"),
  separated("Legally Separated");

  const CivilStatus(this.label);
  final String label;
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();
    final emailController = TextEditingController();
    final contactNumberController = TextEditingController();
    final addressController = TextEditingController();
    final birthdayController = TextEditingController();
    final civilStatusController = TextEditingController();
    final fishingVesselTypeController = TextEditingController();
    final passwordController = TextEditingController();

    var _selectedVesselType;
    var _selectedCivilStatus;

    const fieldGap = 15.0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Register an Account',
            style: TextStyle(
              fontSize: 25,
              fontFamily: 'Readex Pro',
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(0, 39, 68, 1),
            )),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            AuthField(
              hintText: 'Enter Birthday',
              controller: birthdayController,
            ),
            SizedBox(height: fieldGap),
            ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 400,
                ),
                child: Material(
                  elevation: 5.0,
                  shadowColor: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: DropdownMenu<CivilStatus>(
                    width: 380,
                    controller: civilStatusController,
                    enableFilter: false,
                    requestFocusOnTap: true,
                    hintText: "Enter Civil Status",
                    inputDecorationTheme: InputDecorationTheme(
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: const EdgeInsets.all(27),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(52, 51, 67, 1),
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromRGBO(172, 76, 42, 0.612),
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onSelected: (CivilStatus? civilStatus) {
                      setState(() {
                        _selectedCivilStatus = civilStatus;
                      });
                    },
                    dropdownMenuEntries:
                        CivilStatus.values.map<DropdownMenuEntry<CivilStatus>>(
                      (CivilStatus civilStatus) {
                        return DropdownMenuEntry<CivilStatus>(
                          value: civilStatus,
                          label: civilStatus.label,
                        );
                      },
                    ).toList(),
                  ),
                )),
            SizedBox(height: fieldGap),
            ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 400,
                ),
                child: Material(
                  elevation: 5.0,
                  shadowColor: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: DropdownMenu<VesselType>(
                    width: 380,
                    controller: fishingVesselTypeController,
                    enableFilter: false,
                    requestFocusOnTap: true,
                    hintText: "Enter Vessel Type",
                    inputDecorationTheme: InputDecorationTheme(
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: const EdgeInsets.all(27),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(52, 51, 67, 1),
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromRGBO(172, 76, 42, 0.612),
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onSelected: (VesselType? vesselType) {
                      setState(() {
                        _selectedVesselType = vesselType;
                      });
                    },
                    dropdownMenuEntries:
                        VesselType.values.map<DropdownMenuEntry<VesselType>>(
                      (VesselType vesselType) {
                        return DropdownMenuEntry<VesselType>(
                          value: vesselType,
                          label: vesselType.label,
                        );
                      },
                    ).toList(),
                  ),
                )),
            SizedBox(height: fieldGap),
            AuthField(
              hintText: 'Enter Password',
              controller: passwordController,
            ),
            SizedBox(
              height: 50,
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
                'Register',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 23,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 30),
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
