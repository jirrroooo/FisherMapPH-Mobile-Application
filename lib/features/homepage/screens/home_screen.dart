import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    _isVerified();
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
        leading: Row(children: [
          SizedBox(
            width: 10,
          ),
          Icon(Icons.location_on_rounded),
          SizedBox(
            width: 10,
          ),
          Text(
            "Albay, Bicol",
            style: TextStyle(fontFamily: "Readex Pro", fontSize: 15),
          ),
        ]),
        leadingWidth: double.infinity,
        actions: [
          IconButton(
            onPressed: () => {Navigator.pushNamed(context, "/notification")},
            icon: Icon(Icons.notifications_rounded),
          ),
          IconButton(
            onPressed: () => {Navigator.pushNamed(context, "/weather")},
            icon: Icon(Icons.cloud_rounded),
          ),
          Text("36°", style: TextStyle(fontFamily: "Readex Pro", fontSize: 15)),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 170,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  border: Border.all(
                    width: 2,
                  ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16)),
                ),
              ),
              Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(47, 51, 64, 1),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(13),
                              topRight: Radius.circular(13)),
                        ),
                        child: Center(
                          child: Text(
                            "Current Position Information",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Readex Pro",
                                fontSize: 15),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      currentPos("Latitude", "20.1234"),
                      currentPos("Longitude", "20.1234"),
                      currentPos("Timestamp", "08/15/2001 - 10:54:32"),
                      currentPos("Location", "West Philippine Sea"),
                      SizedBox(
                        height: 5,
                      ),
                      ElevatedButton(
                          onPressed: () => {},
                          child: Text(
                            "Locate in FisherMap PH",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Readex Pro",
                                fontSize: 15),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  Color.fromRGBO(37, 142, 190, 1)),
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ))))
                    ],
                  )),
              SizedBox(
                height: 30,
              ),
              Text("Important Notifications",
                  style: TextStyle(
                      fontFamily: "Readex Pro",
                      fontSize: 15,
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.left),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 200.0,
                child: ListView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) => Container(
                        height: 200,
                        width: 300,
                        margin:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            width: 2,
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(255, 0, 0, .55),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(13),
                                    topRight: Radius.circular(13)),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    "West Philippine Sea Maritime Boundary",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Readex Pro",
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 60,
                                child: SingleChildScrollView(
                                  child: Text(
                                    "You are entering a disputed maritime territory. It is advised that you go back to safe position immediately. If tension arises, send a distress signal in the distress signal tab of the application. Keep Safe",
                                    style: TextStyle(
                                      fontFamily: "Readex Pro",
                                      fontSize: 11,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            ElevatedButton(
                                onPressed: () => {},
                                child: Text(
                                  "View All Details",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Readex Pro",
                                      fontSize: 12),
                                ),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Color.fromRGBO(47, 51, 64, 1)),
                                    shape: MaterialStatePropertyAll(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ))))
                          ],
                        ))),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Latest Logged Alerts",
                      style: TextStyle(
                          fontFamily: "Readex Pro",
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.left),
                  ElevatedButton(
                      onPressed: () =>
                          {Navigator.pushNamed(context, '/alerts')},
                      child: Text(
                        "View All",
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
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 250.0,
                child: ListView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) => Container(
                        height: 250,
                        width: 200,
                        margin:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            width: 2,
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(240, 205, 146, 1),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(13),
                                    topRight: Radius.circular(13)),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    "HEAVY RAIN ALERT",
                                    style: TextStyle(
                                        fontFamily: "Readex Pro",
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 156,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Description:",
                                      style: TextStyle(
                                          fontFamily: "Readex Pro",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.left,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Expect Heavy Rain and High Sea Wave",
                                        style: TextStyle(
                                          fontFamily: "Readex Pro",
                                          fontSize: 11,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Text(
                                      "Instruction:",
                                      style: TextStyle(
                                          fontFamily: "Readex Pro",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.left,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Please go back to the seashore immediately!",
                                        style: TextStyle(
                                          fontFamily: "Readex Pro",
                                          fontSize: 11,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(90, 205, 224, 1),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(13),
                                    bottomRight: Radius.circular(13)),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    "Alert Status: Active",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Readex Pro",
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ))),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Latest Location Logs",
                      style: TextStyle(
                          fontFamily: "Readex Pro",
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.left),
                  ElevatedButton(
                      onPressed: () =>
                          {Navigator.pushNamed(context, '/location')},
                      child: Text(
                        "View All",
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
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) => Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 30,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: Column(
                              children: [
                                Text(
                                  "Tiwi, Albay (10/15/01 - 10:59 AM)",
                                  style: TextStyle(
                                      fontFamily: "Readex Pro",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.fiber_manual_record,
                                      size: 10,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                        "Latitude: 20.1234, Longitude: 20.1234",
                                        style: TextStyle(
                                          fontFamily: "Readex Pro",
                                          fontSize: 12,
                                        ))
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      )))
            ],
          ),
        ),
      ),
    );
  }

  Widget currentPos(String param, String value) {
    return Row(
      children: [
        SizedBox(
          width: 30,
        ),
        Icon(
          Icons.fiber_manual_record,
          size: 15,
        ),
        SizedBox(
          width: 15,
        ),
        Text(
          param + ":\t\t\t" + value,
          style: TextStyle(fontFamily: "Readex Pro", fontSize: 13),
        ),
      ],
    );
  }
}
