import 'package:fishermap_ph_mobileapp/features/auth/models/enum.dart';
import 'package:fishermap_ph_mobileapp/features/profile/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  DateTime? pickedDate;
  var _selectedCivilStatus;
  var _selectedVesselType;

  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  TextEditingController civilStatusController = TextEditingController();
  TextEditingController fishingVesselTypeController = TextEditingController();

  bool isEdit = false;

  final DateFormat formatter = DateFormat('MMMM d, y');
  final DateFormat formatter2 = DateFormat('y-MM-d');

  @override
  void initState() {
    super.initState();

    _isVerified();
    context.read<ProfileBloc>().add(ProfileFetched());
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
          "Profile",
          style: TextStyle(
              fontFamily: "Readex Pro",
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => {Navigator.pop(context)},
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileFetchedFailure) {
            return Center(
              child: Text(state.error),
            );
          }

          if (state is ProfileUpdateFailed) {
            return Center(
              child: Text(state.error),
            );
          }

          if (state is ProfileFetchedLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          if (state is ProfileUpdateSuccess) {
            isEdit = false;

            context.read<ProfileBloc>().add(ProfileFetched());
          }

          if (state is! ProfileFetchedSuccess) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          var data = state.profileModel;

          emailController.text = data.email_address;
          contactController.text = data.contact_number;
          addressController.text = data.address;
          birthdayController.text = formatter2.format(data.birthday);
          civilStatusController.text =
              toBeginningOfSentenceCase(data.civil_status)!;
          fishingVesselTypeController.text =
              toBeginningOfSentenceCase(data.fishing_vessel_type)!;

          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(75.0)),
                      color: Color.fromRGBO(90, 205, 224, 1),
                    ),
                    child: Image.asset(
                      'assets/images/fisherman.png',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${data.first_name} ${data.last_name}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        fontFamily: "Readex Pro"),
                  ),
                  Text("Member Since ${formatter.format(data.createdAt)}",
                      style: TextStyle(fontSize: 12, fontFamily: "Readex Pro")),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.verified,
                        color: data.isAuthenticated ? Colors.blue : Colors.grey,
                        size: 18,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(data.isAuthenticated ? "Verified" : "Not Verified",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Readex Pro"))
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(5),
                        fixedSize: const Size(120, 20),
                        backgroundColor: Color.fromRGBO(37, 142, 190, 1),
                        shadowColor: Colors.transparent,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 15,
                          ),
                          Text(
                            'Edit Profile',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: Colors.white,
                                fontFamily: "Readex Pro"),
                          ),
                        ],
                      ),
                      onPressed: () => {
                            setState(() {
                              isEdit = !isEdit;
                            })
                          }),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    enabled: isEdit,
                    controller: emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
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
                      hintText: "Enter Email Address",
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    enabled: isEdit,
                    controller: contactController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.call),
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
                      hintText: "Enter Contact Number",
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    enabled: isEdit,
                    controller: addressController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_on),
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
                      hintText: "Enter Address",
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    enabled: isEdit,
                    keyboardType: TextInputType.datetime,
                    controller: birthdayController,
                    onTap: () async => {
                      pickedDate = await showDatePicker(
                        context: context,
                        lastDate: DateTime.now(),
                        firstDate: DateTime(1930),
                        initialDate: DateTime.now(),
                      ),
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
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: DropdownMenu<CivilStatus>(
                      enabled: isEdit,
                      width: 300,
                      leadingIcon: Icon(Icons.assignment),
                      enableSearch: true,
                      controller: civilStatusController,
                      enableFilter: false,
                      requestFocusOnTap: true,
                      hintText: "Enter Civil Status",
                      onSelected: (CivilStatus? civilStatus) {
                        setState(() {
                          _selectedCivilStatus = civilStatus;
                          civilStatusController.text = _selectedCivilStatus;
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
                      dropdownMenuEntries: CivilStatus.values
                          .map<DropdownMenuEntry<CivilStatus>>(
                        (CivilStatus civilStatus) {
                          return DropdownMenuEntry<CivilStatus>(
                              value: civilStatus,
                              label: civilStatus.label,
                              enabled: true);
                        },
                      ).toList(),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: DropdownMenu<VesselType>(
                      enabled: isEdit,
                      width: 300,
                      leadingIcon: Icon(Icons.directions_boat),
                      enableSearch: true,
                      controller: fishingVesselTypeController,
                      enableFilter: false,
                      requestFocusOnTap: true,
                      hintText: "Enter Vessel Type",
                      onSelected: (VesselType? vesselType) {
                        setState(() {
                          _selectedVesselType = vesselType;
                          fishingVesselTypeController.text =
                              _selectedVesselType;
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
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(15),
                        fixedSize: const Size(300, 60),
                        backgroundColor: Color.fromRGBO(0, 39, 68, 1),
                        shadowColor: Colors.transparent,
                      ),
                      child: const Text(
                        'Update Profile',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.white,
                            fontFamily: "Readex Pro"),
                      ),
                      onPressed: () => {
                            if (!isEdit)
                              {
                                setState(() {
                                  isEdit = true;
                                })
                              }
                            else
                              {
                                context.read<ProfileBloc>().add(
                                    ProfileUpdateRequested(
                                        first_name: data.first_name,
                                        last_name: data.last_name,
                                        sex: data.sex,
                                        email_address:
                                            emailController.text.trim(),
                                        isAuthenticated: data.isAuthenticated,
                                        createdAt: data.createdAt,
                                        contact_number:
                                            contactController.text.trim(),
                                        address: addressController.text.trim(),
                                        birthday: DateTime.parse(
                                            birthdayController.text),
                                        civil_status:
                                            civilStatusController.text.trim(),
                                        fishing_vessel_type:
                                            fishingVesselTypeController.text
                                                .trim()))
                              }
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
