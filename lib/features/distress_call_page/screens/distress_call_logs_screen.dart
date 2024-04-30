import 'package:flutter/material.dart';

class DistressCallLogsScreen extends StatefulWidget {
  const DistressCallLogsScreen({super.key});

  @override
  State<DistressCallLogsScreen> createState() => _DistressCallLogsScreenState();
}

class _DistressCallLogsScreenState extends State<DistressCallLogsScreen> {
  TextStyle tableTitleStyle = TextStyle(
      fontFamily: "Readex Pro", fontSize: 12, fontWeight: FontWeight.w500);

  TextStyle tableValStyle = TextStyle(fontFamily: "Readex Pro", fontSize: 12);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Distress Call Logs",
          style: TextStyle(
              fontFamily: "Readex Pro",
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
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
                Icons.sos,
                color: Colors.red,
              ),
              title: Text(
                'Stranded (08/15/2001 - 10:59 AM)',
                style: TextStyle(
                    fontFamily: "Readex Pro",
                    fontWeight: FontWeight.w700,
                    fontSize: 14),
              ),
              subtitle: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.fiber_manual_record,
                    size: 10,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Latitude: 20.1234, Longitude: 20.1234',
                    style: TextStyle(fontFamily: "Readex Pro", fontSize: 12),
                  ),
                ],
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                      color: Color.fromRGBO(47, 51, 64, 1), width: 2)),
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Distress Message:",
                        style: TextStyle(
                            fontFamily: "Readex Pro",
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Tulong po mga sir. Nasiraan po ako dito sa gitna ng dagat. Naiwan po ako ng mga kasamahan ko. Di ko na po sila makita.",
                        style: TextStyle(
                          fontFamily: "Readex Pro",
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text("Status: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  fontFamily: "Readex Pro")),
                          Text("Responded ",
                              style: TextStyle(
                                  fontSize: 12, fontFamily: "Readex Pro")),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
