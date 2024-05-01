import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "About",
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  "assets/images/FisherMapPH.png",
                  width: 200,
                ),
              ),
              SizedBox(height: 5),
              Center(
                child: Text(
                  "FisherMap PH ",
                  style: TextStyle(
                      fontFamily: "Readex Pro",
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                "A GPS-based Fisher Map and Alert System for Fisherfolk in the Philippines ",
                style: TextStyle(
                  fontFamily: "Readex Pro",
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Row(children: [
                Column(
                  children: [
                    Image.asset(
                      "assets/images/vision.jpg",
                      width: 40,
                    ),
                    Text(
                      "VISION",
                      style: TextStyle(
                          fontFamily: "Readex Pro",
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  width: 40,
                ),
                Expanded(
                  child: Text(
                    "Our goal is to provide an organized platform that increases the security and broaden the linkages among the fisherfolk in the Philippines.",
                    style: TextStyle(
                      fontFamily: "Readex Pro",
                      fontSize: 13,
                    ),
                  ),
                )
              ]),
              SizedBox(
                height: 25,
              ),
              Row(children: [
                Expanded(
                  child: Text(
                    "The FisherMap PH was developed using Flutter Framework. It was complemented by the web-based application which was developed using the MERN stack.",
                    style: TextStyle(
                      fontFamily: "Readex Pro",
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Image.asset(
                      "assets/images/development.jpg",
                      width: 40,
                    ),
                    Text(
                      "DEVELOPMENT",
                      style: TextStyle(
                          fontFamily: "Readex Pro",
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ]),
              SizedBox(
                height: 25,
              ),
              Row(children: [
                Column(
                  children: [
                    Image.asset(
                      "assets/images/developer.jpg",
                      width: 40,
                    ),
                    Text(
                      "DEVELOPER",
                      style: TextStyle(
                          fontFamily: "Readex Pro",
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Text(
                    "The FisherMap PH was developed by John Rommel B. Octavo, a student of the University of the Philippines Los Baños, Institute of Computer Science.",
                    style: TextStyle(
                      fontFamily: "Readex Pro",
                      fontSize: 13,
                    ),
                  ),
                )
              ]),
              SizedBox(
                height: 30,
              ),
              Text(
                "Acknowledgment:",
                style: TextStyle(
                    fontFamily: "Readex Pro",
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "I would like to acknowledge the valuable contributions of those who have helped me finish my Special Problem (SP) topic.",
                style: TextStyle(
                  fontFamily: "Readex Pro",
                  fontSize: 13,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "To Assoc. Prof. Concepcion L. Khan, my SP adviser, for her insights and opinions that lead to the successful development of the FisherMap PH mobile and website application.",
                style: TextStyle(
                  fontFamily: "Readex Pro",
                  fontSize: 13,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "To the Department of Science and Technology through the Science Education Institute for helping me through their scholarship program.",
                style: TextStyle(
                  fontFamily: "Readex Pro",
                  fontSize: 13,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "To my family and friends that sustain my sanity in this crucial years of my college journey. To my late brother, Paul Jake Octavo, who inspires me to keep striving and be faithful in believing in God. ",
                style: TextStyle(
                  fontFamily: "Readex Pro",
                  fontSize: 13,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "To all those who never doubt in my ability. To all who still believes in me. Thank you for giving me even a streak of hope in myself. ",
                style: TextStyle(
                  fontFamily: "Readex Pro",
                  fontSize: 13,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "And most importantly to the Almighty God who is my source of courage and faith. For giving me the grace to deal with the hardships of life. For sustaining me despite me being so sinful.",
                style: TextStyle(
                  fontFamily: "Readex Pro",
                  fontSize: 13,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "May God be glorified in this work!",
                style: TextStyle(
                  fontFamily: "Readex Pro",
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
