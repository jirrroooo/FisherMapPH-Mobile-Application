import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  TextStyle tableTitleStyle = TextStyle(
      fontFamily: "Readex Pro", fontSize: 12, fontWeight: FontWeight.w500);

  TextStyle tableValStyle = TextStyle(fontFamily: "Readex Pro", fontSize: 12);

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
        title: Text(
          "Notifications",
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
                Icons.notifications_active,
                color: Color.fromRGBO(255, 0, 0, 1),
              ),
              title: Text(
                'Storm Alert (08/15/2001 - 10:59 AM)',
                style: TextStyle(
                    fontFamily: "Readex Pro",
                    fontWeight: FontWeight.w700,
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
                        DataCell(Text('Description', style: tableValStyle)),
                        DataCell(Text('Expect Heavy Rain and High Sea Wave',
                            style: tableValStyle)),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('Instruction', style: tableValStyle)),
                        DataCell(Text(
                            'Please go back to the seashore immediately!',
                            style: tableValStyle)),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('Classification', style: tableValStyle)),
                        DataCell(Text('High', style: tableValStyle)),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('Location', style: tableValStyle)),
                        DataCell(
                            Text('[121.763, 16.739]', style: tableValStyle)),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('Radius', style: tableValStyle)),
                        DataCell(Text('10 Kilometers', style: tableValStyle)),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('Status', style: tableValStyle)),
                        DataCell(Text('Active', style: tableValStyle)),
                      ],
                    ),
                  ],
                ),
                ElevatedButton(
                    onPressed: () => {},
                    child: Text(
                      "Locate in FisherMap PH",
                      style: TextStyle(
                          fontFamily: "Readex Pro",
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    style: ButtonStyle(
                        minimumSize: MaterialStatePropertyAll(Size(200, 40)),
                        backgroundColor: MaterialStatePropertyAll(
                            Color.fromRGBO(37, 142, 190, 1)),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        )))),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
