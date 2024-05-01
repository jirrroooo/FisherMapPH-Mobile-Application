import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  bool isHide1 = true;
  bool isHide2 = true;
  bool isHide3 = true;

  TextStyle tableTitleStyle = TextStyle(
      fontFamily: "Readex Pro", fontSize: 12, fontWeight: FontWeight.w500);

  TextStyle tableValStyle = TextStyle(fontFamily: "Readex Pro", fontSize: 12);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(
              fontFamily: "Readex Pro",
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Change your Password",
                style: TextStyle(
                    fontFamily: "Readex Pro",
                    fontSize: 14,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                obscureText: isHide1,
                controller: oldPasswordController,
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
                  hintText: "Enter Old Password",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                obscureText: isHide2,
                controller: newPasswordController,
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
                  hintText: "Enter New Password",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                obscureText: isHide3,
                controller: confirmPasswordController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.vpn_key),
                  suffixIcon: IconButton(
                      icon: isHide3
                          ? Icon(Icons.remove_red_eye)
                          : Icon(Icons.visibility_off),
                      onPressed: () => {
                            setState(() {
                              isHide3 = !isHide3;
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
                  hintText: "Confirm New Password",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(15),
                      fixedSize: const Size(300, 60),
                      backgroundColor: Color.fromRGBO(0, 39, 68, 1),
                      shadowColor: Colors.transparent,
                    ),
                    child: const Text(
                      'Update Password',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.white,
                          fontFamily: "Readex Pro"),
                    ),
                    onPressed: () => {}),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Emergency Contact List",
                    style: TextStyle(
                        fontFamily: "Readex Pro",
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                  IconButton(
                      onPressed: () => {
                            showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  height: 600,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Emergency Contact List",
                                            style: TextStyle(
                                                fontFamily: "Readex Pro",
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          TextFormField(
                                            controller: emailController,
                                            decoration: InputDecoration(
                                              prefixIcon: Icon(Icons.email),
                                              contentPadding:
                                                  const EdgeInsets.all(25),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color.fromRGBO(
                                                      59, 58, 69, 1),
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 0.498),
                                                  width: 3,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              hintText: "Enter Email Address",
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          TextFormField(
                                            keyboardType: TextInputType.phone,
                                            controller: contactController,
                                            decoration: InputDecoration(
                                              prefixIcon: Icon(Icons.call),
                                              contentPadding:
                                                  const EdgeInsets.all(25),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color.fromRGBO(
                                                      59, 58, 69, 1),
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 0.498),
                                                  width: 3,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              hintText: "Enter Contact Number",
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          TextFormField(
                                            controller: addressController,
                                            decoration: InputDecoration(
                                              prefixIcon:
                                                  Icon(Icons.location_on),
                                              contentPadding:
                                                  const EdgeInsets.all(25),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color.fromRGBO(
                                                      59, 58, 69, 1),
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 0.498),
                                                  width: 3,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              hintText: "Enter Address",
                                            ),
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.all(15),
                                                fixedSize: const Size(300, 60),
                                                backgroundColor: Color.fromRGBO(
                                                    0, 39, 68, 1),
                                                shadowColor: Colors.transparent,
                                              ),
                                              child: const Text(
                                                'Add Contact',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15,
                                                    color: Colors.white,
                                                    fontFamily: "Readex Pro"),
                                              ),
                                              onPressed: () =>
                                                  {Navigator.pop(context)}),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                          },
                      icon: Icon(
                        Icons.person_add,
                      ))
                ],
              ),
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: ExpansionTile(
                    collapsedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(color: Colors.grey, width: 2)),
                    leading: Icon(
                      Icons.person,
                      color: Colors.grey,
                    ),
                    title: Text(
                      'Paul Jake B. Octavo',
                      style: TextStyle(
                          fontFamily: "Readex Pro",
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                            color: Color.fromRGBO(47, 51, 64, 1), width: 2)),
                    children: [
                      DataTable(
                        columns: <DataColumn>[
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                "Parameters",
                                style: tableTitleStyle,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Values',
                                style: tableTitleStyle,
                              ),
                            ),
                          ),
                        ],
                        rows: <DataRow>[
                          DataRow(
                            cells: <DataCell>[
                              DataCell(Text('Email:', style: tableValStyle)),
                              DataCell(Text('pauljakeoctavo@gmail.com',
                                  style: tableValStyle)),
                            ],
                          ),
                          DataRow(
                            cells: <DataCell>[
                              DataCell(Text('Contact Number:',
                                  style: tableValStyle)),
                              DataCell(
                                  Text('09123456789', style: tableValStyle)),
                            ],
                          ),
                          DataRow(
                            cells: <DataCell>[
                              DataCell(Text('Address', style: tableValStyle)),
                              DataCell(Text(
                                  'Purok 4, Masarawag, Guinobatan, Albay 4503',
                                  style: tableValStyle)),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
