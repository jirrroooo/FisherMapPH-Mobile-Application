import 'package:fishermap_ph_mobileapp/features/distress_call_page/bloc/distress_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

class DistressCallLogsScreen extends StatefulWidget {
  const DistressCallLogsScreen({super.key});

  @override
  State<DistressCallLogsScreen> createState() => _DistressCallLogsScreenState();
}

class _DistressCallLogsScreenState extends State<DistressCallLogsScreen> {
  TextStyle tableTitleStyle = TextStyle(
      fontFamily: "Readex Pro", fontSize: 12, fontWeight: FontWeight.w500);

  TextStyle tableValStyle = TextStyle(fontFamily: "Readex Pro", fontSize: 12);

  final DateFormat formatter = DateFormat('MM/d/y - hh:mm a');

  @override
  void initState() {
    super.initState();

    _isVerified();
    context.read<DistressBloc>().add(DistressFetched());
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
          "Distress Call Logs",
          style: TextStyle(
              fontFamily: "Readex Pro",
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<DistressBloc, DistressState>(
        builder: (context, state) {
          if (state is DistressFetchedFailure) {
            return Center(
              child: Text(state.error),
            );
          }

          if (state is! DistressFetchedSuccess) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          final data = state.distress_logs;

          if (data.length == 0) {
            return Center(
              child: Text(
                "No Distress Call Logs Yet",
                style: TextStyle(
                    fontFamily: "Readex Pro",
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            );
          }

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
                    Icons.sos,
                    color: Colors.red,
                  ),
                  title: Text(
                    '${data[i].type} (${formatter.format(data[i].createdAt)})',
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
                            data[i].content,
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
                              Text(data[i].status,
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
          );
        },
      ),
    );
  }
}
