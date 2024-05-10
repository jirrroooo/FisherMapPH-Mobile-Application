import 'package:fishermap_ph_mobileapp/features/sea_map/bloc/sea_map_bloc.dart';
import 'package:fishermap_ph_mobileapp/features/sea_map/repository/sea_map_repository.dart';
import 'package:fishermap_ph_mobileapp/functions/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

class SeaMapScreen extends StatefulWidget {
  const SeaMapScreen({super.key});

  @override
  State<SeaMapScreen> createState() => _SeaMapScreenState();
}

class _SeaMapScreenState extends State<SeaMapScreen> {
  MapController _mapController = MapController();
  PopupController _popupController = PopupController();

  PSTDateFormat pstDateFormat = PSTDateFormat();

  @override
  void initState() {
    super.initState();

    _isVerified();
    context.read<SeaMapBloc>().add(LocationFetchedRequested());
  }

  void _isVerified() async {
    FlutterSecureStorage fst = FlutterSecureStorage();

    if (await fst.containsKey(key: "token") == false) {
      Navigator.popAndPushNamed(context, "/login");
    }
  }

  @override
  Widget build(BuildContext context) {
    SeaMapRepository seaMapRepository = SeaMapRepository();

    var data = seaMapRepository.determinePosition();

    data.whenComplete(() => print(data.toString()));

    return Scaffold(
        body: BlocBuilder<SeaMapBloc, SeaMapState>(
          builder: (context, state) {
            if (state is SeaMapLocationFetchedFailed) {
              return Center(
                child: Text(state.error),
              );
            }

            if (state is! SeaMapLocationFetchedSuccess) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }

            var data = state.currentLocation;

            return Stack(
              children: [
                FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                      initialCenter: LatLng(data.latitude, data.longitude),
                      initialZoom: 8),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                    PopupMarkerLayer(
                      options: PopupMarkerLayerOptions(
                        markers: [
                          Marker(
                            point: LatLng(data.latitude, data.longitude),
                            width: 40,
                            height: 40,
                            child: GestureDetector(
                              onTap: () => {
                                showModalBottomSheet<void>(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (BuildContext context) {
                                      return SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Container(
                                          height: 220,
                                          child: Padding(
                                            padding: const EdgeInsets.all(15),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  height: 50,
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    color: Color.fromRGBO(
                                                        47, 51, 64, 1),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(13),
                                                            topRight:
                                                                Radius.circular(
                                                                    13)),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "Current Position Information",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily:
                                                              "Readex Pro",
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                ),

                                                SizedBox(
                                                  height: 20,
                                                ),
                                                currentPos(
                                                    "Latitude",
                                                    data.latitude
                                                        .toStringAsFixed(4)),
                                                currentPos(
                                                    "Longitude",
                                                    data.longitude
                                                        .toStringAsFixed(4)),
                                                currentPos(
                                                    "Timestamp",
                                                    pstDateFormat.dateString(
                                                        data.timestamp)),
                                                currentPos(
                                                    "Altitude",
                                                    data.altitude
                                                        .toStringAsFixed(4)),
                                                currentPos(
                                                    "Speed",
                                                    data.speed
                                                        .toStringAsFixed(4)),
                                                // currentPos("Location",
                                                //     "West Philippine Sea"),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    })
                              },
                              child: Image.asset('assets/images/fishing.png'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60, right: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(
                                      0.1), // Customize shadow color and opacity
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  offset: Offset(
                                      0, 4), // changes position of shadow
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  padding: MaterialStatePropertyAll(
                                      EdgeInsets.all(12)),
                                  shape: MaterialStatePropertyAll(
                                    CircleBorder(
                                      eccentricity: 0,
                                    ),
                                  )),
                              onPressed: () => {},
                              child: Icon(
                                Icons.fence_outlined,
                                color: Colors.black,
                                size: 25,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(
                                      0.1), // Customize shadow color and opacity
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  offset: Offset(
                                      0, 4), // changes position of shadow
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  padding: MaterialStatePropertyAll(
                                      EdgeInsets.all(12)),
                                  shape: MaterialStatePropertyAll(
                                    CircleBorder(
                                      eccentricity: 0,
                                    ),
                                  )),
                              onPressed: () => {},
                              child: Icon(
                                Icons.warning_amber_rounded,
                                color: Colors.black,
                                size: 25,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            child: Icon(
              Icons.navigation,
              color: Colors.black,
            ),
            onPressed: () =>
                {context.read<SeaMapBloc>().add(LocationFetchedRequested())}));
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
