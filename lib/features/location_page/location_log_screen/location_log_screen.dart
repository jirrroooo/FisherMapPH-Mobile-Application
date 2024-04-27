import 'package:flutter/material.dart';

class LocationLogPage extends StatefulWidget {
  const LocationLogPage({super.key});

  @override
  State<LocationLogPage> createState() => _LocationLogPageState();
}

class _LocationLogPageState extends State<LocationLogPage> {
  TextStyle tableTitleStyle = TextStyle(
      fontFamily: "Readex Pro", fontSize: 12, fontWeight: FontWeight.w500);

  TextStyle tableValStyle = TextStyle(fontFamily: "Readex Pro", fontSize: 12);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Location Logs",
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
                Icons.warning_outlined,
                color: Colors.red,
              ),
              title: Text(
                'Tiwi, Albay (08/15/2001 - 10:59 AM)',
                style: TextStyle(
                    fontFamily: "Readex Pro",
                    fontWeight: FontWeight.w500,
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
                        DataCell(Text('Latitude', style: tableValStyle)),
                        DataCell(Text('6.1234', style: tableValStyle)),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('Longitude', style: tableValStyle)),
                        DataCell(Text('102.4283', style: tableValStyle)),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('Sea Depth', style: tableValStyle)),
                        DataCell(Text('32.7384', style: tableValStyle)),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
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
