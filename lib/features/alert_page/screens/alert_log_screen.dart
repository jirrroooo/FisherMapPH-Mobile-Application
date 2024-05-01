import 'dart:ui';

import 'package:fishermap_ph_mobileapp/features/alert_page/bloc/alert_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

class AlertLogPage extends StatefulWidget {
  const AlertLogPage({super.key});

  @override
  State<AlertLogPage> createState() => _AlertLogPageState();
}

class _AlertLogPageState extends State<AlertLogPage> {
  TextStyle tableTitleStyle = TextStyle(
      fontFamily: "Readex Pro", fontSize: 12, fontWeight: FontWeight.w500);

  TextStyle tableValStyle = TextStyle(fontFamily: "Readex Pro", fontSize: 12);

  final DateFormat formatter = DateFormat('MM/d/y - hh:mm a');

  @override
  void initState() {
    super.initState();

    _isVerified();
    context.read<AlertBloc>().add(AlertFetched());
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
          "Alert Logs",
          style: TextStyle(
              fontFamily: "Readex Pro",
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<AlertBloc, AlertState>(
        builder: (context, state) {
          if (state is AlertFetchedFailure) {
            return Center(
              child: Text(state.error),
            );
          }

          if (state is! AlertFetchedSuccess) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          final data = state.alert_logs;

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
                    '${data[i].title} (${formatter.format(data[i].effective)})',
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
                            DataCell(Text(data[i].description,
                                style: tableValStyle)),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('Instruction', style: tableValStyle)),
                            DataCell(Text(data[i].instruction,
                                style: tableValStyle)),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(
                                Text('Classification', style: tableValStyle)),
                            DataCell(Text(data[i].level, style: tableValStyle)),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('Location', style: tableValStyle)),
                            DataCell(Text(data[i].location.toString(),
                                style: tableValStyle)),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('Radius', style: tableValStyle)),
                            DataCell(Text('${data[i].radius.toString()} km',
                                style: tableValStyle)),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('Status', style: tableValStyle)),
                            DataCell(Text(
                                DateTime.now().isAfter(data[i].expires)
                                    ? 'Expired'
                                    : "Active",
                                style: tableValStyle)),
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
