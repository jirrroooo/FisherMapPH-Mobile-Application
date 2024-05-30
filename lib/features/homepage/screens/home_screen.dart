import 'package:fishermap_ph_mobileapp/features/alert_page/bloc/alert_bloc.dart';
import 'package:fishermap_ph_mobileapp/features/location_page/bloc/location_bloc.dart';
import 'package:fishermap_ph_mobileapp/features/sea_map/bloc/sea_map_bloc.dart';
import 'package:fishermap_ph_mobileapp/functions/date_format.dart';
import 'package:fishermap_ph_mobileapp/home/bloc/home_bloc.dart';
import 'package:fishermap_ph_mobileapp/services/notification/local_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:latlong2/latlong.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MapController _mapController = MapController();
  PSTDateFormat pstDateFormat = PSTDateFormat();

  bool alertBtn = true;
  bool locationBtn = true;

  @override
  void initState() {
    super.initState();

    _isVerified();
    context.read<HomeBloc>().add(InfoFetched());
    context.read<SeaMapBloc>().add(LocationFetchedRequested());
    context.read<LocationBloc>().add(LocationFetched());
    context.read<AlertBloc>().add(AlertFetched());
    context.read<SeaMapBloc>().add(BoundaryMapFetchedRequested());
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
          BlocBuilder<SeaMapBloc, SeaMapState>(builder: (context, state) {
            if (state is BoundaryMapFetchedFailed) {
              return Center(
                child: Text(state.error),
              );
            }

            if (state is! BoundaryMapFetchedSuccess) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }

            var data = state.boundaryModel;
            var currentLocation = state.currentLocation;

            if (data == null) {
              return Text(
                currentLocation.longitude.toStringAsFixed(4) +
                    ", " +
                    currentLocation.latitude.toStringAsFixed(4),
                style: TextStyle(fontFamily: "Readex Pro", fontSize: 15),
              );
            }

            return Text(
              data.title,
              style: TextStyle(fontFamily: "Readex Pro", fontSize: 10),
            );
          }),
        ]),
        leadingWidth: double.infinity,
        actions: [
          IconButton(
            onPressed: () => {Navigator.pushNamed(context, "/notification")},
            icon: Icon(Icons.notifications_rounded),
          ),
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
              BlocBuilder<SeaMapBloc, SeaMapState>(builder: (context, state) {
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

                return Column(
                  children: [
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        border: Border.all(
                          width: 3,
                        ),
                        // borderRadius: BorderRadius.only(
                        //     topLeft: Radius.circular(16),
                        //     topRight: Radius.circular(16)),
                      ),
                      child: FlutterMap(
                          mapController: _mapController,
                          options: MapOptions(
                              initialCenter:
                                  LatLng(data.latitude, data.longitude),
                              initialZoom: 8),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              userAgentPackageName: 'com.example.app',
                            ),
                            MarkerLayer(markers: [
                              Marker(
                                  point: LatLng(data.latitude, data.longitude),
                                  width: 40,
                                  height: 40,
                                  child:
                                      Image.asset("assets/images/fishing.png"))
                            ])
                          ]),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        height: 230,
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
                            currentPos(
                                "Latitude", data.latitude.toStringAsFixed(4)),
                            currentPos(
                                "Longitude", data.longitude.toStringAsFixed(4)),
                            currentPos("Timestamp",
                                pstDateFormat.dateString(data.timestamp)),
                            currentPos(
                                "Altitude", data.altitude.toStringAsFixed(4)),
                            currentPos("Speed", data.speed.toStringAsFixed(4)),
                            SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                                onPressed: () =>
                                    {Navigator.pushNamed(context, '/sea-map')},
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
                  ],
                );
              }),
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
                                onPressed: () {
                                  // LocalNotification.showPeriodicNotification(
                                  //     title: "Tiwi Municipal Water Boundary",
                                  //     body:
                                  //         "You are now entering the Pioduran Municipal Boundary",
                                  //     payload: 'Test Payload');
                                  LocalNotification.cancelAll();
                                },
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
              BlocBuilder<AlertBloc, AlertState>(
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

                  if (data.length == 0) {
                    return Column(
                      children: [
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
                                onPressed: () => null,
                                child: Text(
                                  "View All",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Readex Pro",
                                      fontSize: 12),
                                ),
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.grey),
                                    shape: MaterialStatePropertyAll(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ))))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Text(
                              "No Alert Logs Yet",
                              style: TextStyle(
                                  fontFamily: "Readex Pro",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    );
                  }

                  return Column(
                    children: [
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
                              onPressed: () => data.length != 0
                                  ? {Navigator.pushNamed(context, '/alerts')}
                                  : null,
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
                                  shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
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
                            itemCount: data.length <= 10 ? data.length : 10,
                            itemBuilder: (BuildContext context, int i) =>
                                Container(
                                    height: 250,
                                    width: 200,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
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
                                            color: Color.fromRGBO(
                                                240, 205, 146, 1),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13)),
                                          ),
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Text(
                                                data[i].title,
                                                style: TextStyle(
                                                    fontFamily: "Readex Pro",
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  textAlign: TextAlign.left,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    data[i].description,
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
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  textAlign: TextAlign.left,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    data[i].instruction,
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
                                            color:
                                                Color.fromRGBO(90, 205, 224, 1),
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(13),
                                                bottomRight:
                                                    Radius.circular(13)),
                                          ),
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Text(
                                                DateTime.now().isAfter(
                                                        data[i].expires)
                                                    ? 'Alert Status: Expired'
                                                    : "Alert Status: Active",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "Readex Pro",
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ))),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
              BlocBuilder<LocationBloc, LocationState>(
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

                  if (data.length == 0) {
                    return Column(
                      children: [
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
                                onPressed: () => null,
                                child: Text(
                                  "View All",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Readex Pro",
                                      fontSize: 12),
                                ),
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.grey),
                                    shape: MaterialStatePropertyAll(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ))))
                          ],
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Text(
                              "No Location Logs Yet",
                              style: TextStyle(
                                  fontFamily: "Readex Pro",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    );
                  }

                  return Column(
                    children: [
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
                              onPressed: () => data.length != 0
                                  ? {Navigator.pushNamed(context, '/location')}
                                  : null,
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
                                  shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
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
                          itemCount: data.length <= 10 ? data.length : 10,
                          itemBuilder: (BuildContext context, int i) =>
                              Container(
                                  margin: EdgeInsets.symmetric(vertical: 5),
                                  height: 60,
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 2),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
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
                                              "[Location] (${pstDateFormat.dateString(data[i].timestamp)})",
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
                                                    "Latitude: ${data[i].latitude.toStringAsFixed(4)}, Longitude: ${data[i].longitude.toStringAsFixed(4)}",
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
                                  ))),
                    ],
                  );
                },
              )
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
