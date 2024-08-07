import 'package:fishermap_ph_mobileapp/features/auth/models/enum.dart';
import 'package:fishermap_ph_mobileapp/features/distress_call_page/bloc/distress_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DistressCallScreen extends StatefulWidget {
  const DistressCallScreen({super.key});

  @override
  State<DistressCallScreen> createState() => _DistressCallScreenState();
}

class _DistressCallScreenState extends State<DistressCallScreen> {
  TextEditingController emergencyTypeController = TextEditingController();
  TextEditingController distressMessageController = TextEditingController();
  var _selectedEmergencyType;
  var _distressMessage;

  @override
  void initState() {
    super.initState();

    _isVerified();
    context.read<DistressBloc>().add(SendDistressInitial());
  }

  void _isVerified() async {
    FlutterSecureStorage fst = FlutterSecureStorage();

    if (await fst.containsKey(key: "token") == false) {
      Navigator.popAndPushNamed(context, "/login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Send a Distress Call",
          style: TextStyle(
              fontFamily: "Readex Pro",
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () =>
                  {Navigator.pushNamed(context, '/distress-call-logs')},
              icon: Icon(Icons.assignment_outlined)),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: BlocBuilder<DistressBloc, DistressState>(
        builder: (context, state) {
          if (state is SendDistressSignalFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.error,
                      style: TextStyle(
                          fontFamily: "Readex Pro",
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () => {
                            context
                                .read<DistressBloc>()
                                .add(SendDistressInitial())
                          },
                      child: Text(
                        "Retry",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Readex Pro",
                            fontSize: 12),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              Color.fromRGBO(47, 51, 64, 1)),
                          shape:
                              MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ))))
                ],
              ),
            );
          }

          if (state is SendDistressSignalLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          if (state is SendDistressSignalSuccess) {
            emergencyTypeController.clear();
            distressMessageController.clear();

            return Padding(
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
                        child: Image.asset("assets/images/rescue.jpg"),
                        fit: BoxFit.fitWidth),
                  ),
                  Text(
                    "Sent Successfully. Help is on the way!",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Readex Pro"),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(15),
                        fixedSize: const Size(400, 65),
                        backgroundColor: Color.fromRGBO(0, 39, 68, 1),
                        shadowColor: Colors.transparent,
                      ),
                      child: const Text(
                        'Return',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 23,
                            color: Colors.white,
                            fontFamily: "Readex Pro"),
                      ),
                      onPressed: () => {
                            context
                                .read<DistressBloc>()
                                .add(SendDistressInitial())
                          }),
                ],
              ),
            );
          }

          if (state is DistressInitial) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Image.asset(
                        "assets/images/sos.png",
                        width: 250,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Emergency Type",
                      style: TextStyle(
                          fontFamily: "Readex Pro",
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: DropdownMenu<EmergencyType>(
                        width: 300,
                        leadingIcon: Icon(
                          Icons.sos,
                          color: Colors.red,
                        ),
                        enableSearch: true,
                        controller: emergencyTypeController,
                        enableFilter: false,
                        requestFocusOnTap: true,
                        hintText: "Enter Emergency Type",
                        onSelected: (EmergencyType? emergencyType) {
                          setState(() {
                            _selectedEmergencyType = emergencyType;
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
                        dropdownMenuEntries: EmergencyType.values
                            .map<DropdownMenuEntry<EmergencyType>>(
                          (EmergencyType emergencyType) {
                            return DropdownMenuEntry<EmergencyType>(
                                value: emergencyType,
                                label: emergencyType.label,
                                enabled: true);
                          },
                        ).toList(),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Distress Message",
                      style: TextStyle(
                          fontFamily: "Readex Pro",
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: distressMessageController,
                      maxLines: 7,
                      decoration: InputDecoration(
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
                        hintText: "Enter Distress Message",
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
                          'Send Distress Message',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Colors.white,
                              fontFamily: "Readex Pro"),
                        ),
                        onPressed: () => {
                              context.read<DistressBloc>().add(
                                  SendDistressSignal(
                                      type: emergencyTypeController.text,
                                      content: distressMessageController.text))
                            }),
                  ],
                ),
              ),
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Image.asset(
                      "assets/images/sos.png",
                      width: 250,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Emergency Type",
                    style: TextStyle(
                        fontFamily: "Readex Pro",
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: DropdownMenu<EmergencyType>(
                      width: 300,
                      leadingIcon: Icon(
                        Icons.sos,
                        color: Colors.red,
                      ),
                      enableSearch: true,
                      controller: emergencyTypeController,
                      enableFilter: false,
                      requestFocusOnTap: true,
                      hintText: "Enter Emergency Type",
                      onSelected: (EmergencyType? emergencyType) {
                        setState(() {
                          _selectedEmergencyType = emergencyType;
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
                      dropdownMenuEntries: EmergencyType.values
                          .map<DropdownMenuEntry<EmergencyType>>(
                        (EmergencyType emergencyType) {
                          return DropdownMenuEntry<EmergencyType>(
                              value: emergencyType,
                              label: emergencyType.label,
                              enabled: true);
                        },
                      ).toList(),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Distress Message",
                    style: TextStyle(
                        fontFamily: "Readex Pro",
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: distressMessageController,
                    maxLines: 7,
                    decoration: InputDecoration(
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
                      hintText: "Enter Distress Message",
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
                        'Send Distress Message',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.white,
                            fontFamily: "Readex Pro"),
                      ),
                      onPressed: () => {
                            context.read<DistressBloc>().add(SendDistressSignal(
                                type: emergencyTypeController.text,
                                content: distressMessageController.text))
                          }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
