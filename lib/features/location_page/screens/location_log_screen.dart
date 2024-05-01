import 'package:fishermap_ph_mobileapp/features/location_page/bloc/location_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

class LocationLogPage extends StatefulWidget {
  const LocationLogPage({super.key});

  @override
  State<LocationLogPage> createState() => _LocationLogPageState();
}

class _LocationLogPageState extends State<LocationLogPage> {
  TextStyle tableTitleStyle = TextStyle(
      fontFamily: "Readex Pro", fontSize: 12, fontWeight: FontWeight.w500);

  TextStyle tableValStyle = TextStyle(fontFamily: "Readex Pro", fontSize: 12);

  final DateFormat formatter = DateFormat('MM/d/y - hh:mm a');

  @override
  void initState() {
    super.initState();

    _isVerified();
    context.read<LocationBloc>().add(LocationFetched());
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
          "Location Logs",
          style: TextStyle(
              fontFamily: "Readex Pro",
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          if (state is LocationFetchedFailure) {
            return Center(
              child: Text(state.error),
            );
          }

          if (state is! LocationFetchedSuccess) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          final data = state.location_logs;

          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: data.length,
              itemBuilder: (BuildContext context, int i) => Padding(
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
                    'Tiwi, Albay (${formatter.format(data[i].timestamp)})',
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
                        'Latitude: ${data[i].latitude}, Longitude: ${data[i].longitude}',
                        style:
                            TextStyle(fontFamily: "Readex Pro", fontSize: 12),
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
                            DataCell(Text(data[i].latitude.toString(),
                                style: tableValStyle)),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('Longitude', style: tableValStyle)),
                            DataCell(Text(data[i].longitude.toString(),
                                style: tableValStyle)),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('Sea Depth', style: tableValStyle)),
                            DataCell(Text(data[i].sea_depth.toString(),
                                style: tableValStyle)),
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
                            minimumSize:
                                MaterialStatePropertyAll(Size(200, 40)),
                            backgroundColor: MaterialStatePropertyAll(
                                Color.fromRGBO(37, 142, 190, 1)),
                            shape:
                                MaterialStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            )))),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
