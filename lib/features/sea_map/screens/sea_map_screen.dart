import 'package:fishermap_ph_mobileapp/features/alert_page/model/alert_model.dart';
import 'package:fishermap_ph_mobileapp/features/sea_map/bloc/sea_map_bloc.dart';
import 'package:fishermap_ph_mobileapp/features/sea_map/model/boundary_model.dart';
import 'package:fishermap_ph_mobileapp/features/sea_map/repository/sea_map_repository.dart';
import 'package:fishermap_ph_mobileapp/functions/date_format.dart';
import 'package:fishermap_ph_mobileapp/functions/map_function.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
  MapFunction mapFunction = MapFunction();

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
    return Scaffold(
        body: Stack(
          children: [
            BlocBuilder<SeaMapBloc, SeaMapState>(
              builder: (context, state) {
                if (state is SeaMapLocationFetchedFailed) {
                  return Center(
                    child: Text(state.error),
                  );
                }

                if (state is AlertMapFetchedFailed) {
                  return Center(
                    child: Text(state.error),
                  );
                }

                if (state is BoundaryMapFetchedFailed) {
                  return Center(
                    child: Text(state.error),
                  );
                }

                if (state is SeaMapLocationFetchedLoading) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }

                if (state is AlertMapFetchedLoading) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }

                if (state is BoundaryMapFetchedLoading) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }

                if (state is AlertMapFetchedSuccess) {
                  var currentlocation = state.currentLocation;
                  var alerts = state.alerts;
                  List<Polygon> polygonList = [];
                  List<Marker> markerList = [];

                  alerts.forEach((alert) {
                    polygonList.add(Polygon(
                        points: mapFunction.computeCircleAlertBounds(
                            double.parse(alert.location[0][0].toString()),
                            double.parse(alert.location[0][1].toString()),
                            double.parse(alert.radius.toString())),
                        isFilled: true,
                        color: Color.fromRGBO(0, 0, 0, 0.3),
                        borderColor: Colors.black45,
                        borderStrokeWidth: 3));

                    markerList.add(Marker(
                      point: LatLng(
                          double.parse(alert.location[0][1].toString()),
                          double.parse(alert.location[0][0].toString())),
                      width: 45,
                      height: 45,
                      child: GestureDetector(
                          onTap: () => {_showAlertLocationBottomSheet(alert)},
                          child: Image.asset(
                            'assets/images/alert.png',
                          )),
                    ));
                  });

                  markerList.add(
                    Marker(
                      point: LatLng(
                          currentlocation.latitude, currentlocation.longitude),
                      width: 50,
                      height: 50,
                      child: GestureDetector(
                        onTap: () =>
                            {_showUserLocationBottomSheet(currentlocation)},
                        child: Image.asset(
                          'assets/images/fishing.png',
                        ),
                      ),
                    ),
                  );

                  return FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                        initialCenter: LatLng(currentlocation.latitude,
                            currentlocation.longitude),
                        initialZoom: 8),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.app',
                      ),
                      PolygonLayer(
                        polygons: polygonList,
                        polygonCulling: true,
                      ),
                      PopupMarkerLayer(
                        options: PopupMarkerLayerOptions(
                          popupController: _popupController,
                          markers: markerList,
                        ),
                      ),
                    ],
                  );
                }

                if (state is BoundaryMapFetchedSuccess) {
                  var data = state.boundaryModel;
                  var position = state.currentLocation;

                  if (data != null) {
                    return FlutterMap(
                      mapController: _mapController,
                      options: MapOptions(
                          initialCenter:
                              LatLng(position.latitude, position.longitude),
                          initialZoom: 8),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.app',
                        ),
                        PolygonLayer(
                          polygons: [
                            Polygon(
                                points: data.location,
                                isFilled: true,
                                color: Color.fromRGBO(0, 0, 0, 0.3),
                                borderColor: Colors.black45,
                                borderStrokeWidth: 3)
                          ],
                          polygonCulling: true,
                        ),
                        PopupMarkerLayer(
                          options: PopupMarkerLayerOptions(
                            popupController: _popupController,
                            markers: [
                              Marker(
                                point: LatLng(
                                    position.latitude, position.longitude),
                                width: 50,
                                height: 50,
                                child: GestureDetector(
                                  onTap: () =>
                                      {_showBoundaryLocationBottomSheet(data)},
                                  child: Image.asset(
                                    'assets/images/fishing.png',
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  }

                  return FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                        initialCenter:
                            LatLng(position.latitude, position.longitude),
                        initialZoom: 8),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.app',
                      ),
                      PopupMarkerLayer(
                        options: PopupMarkerLayerOptions(
                          popupController: _popupController,
                          markers: [
                            Marker(
                              point:
                                  LatLng(position.latitude, position.longitude),
                              width: 50,
                              height: 50,
                              child: GestureDetector(
                                onTap: () => {
                                  // _showUserLocationBottomSheet(currentlocation)
                                },
                                child: Image.asset(
                                  'assets/images/fishing.png',
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                }

                if (state is! SeaMapLocationFetchedSuccess) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }

                var data = state.currentLocation;

                return FlutterMap(
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
                        popupController: _popupController,
                        markers: [
                          Marker(
                            point: LatLng(data.latitude, data.longitude),
                            width: 50,
                            height: 50,
                            child: GestureDetector(
                              onTap: () => {_showUserLocationBottomSheet(data)},
                              child: Image.asset('assets/images/fishing.png'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
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
                              offset:
                                  Offset(0, 4), // changes position of shadow
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              padding:
                                  MaterialStatePropertyAll(EdgeInsets.all(12)),
                              shape: MaterialStatePropertyAll(
                                CircleBorder(
                                  eccentricity: 0,
                                ),
                              )),
                          onPressed: () => {
                            context
                                .read<SeaMapBloc>()
                                .add(BoundaryMapFetchedRequested())
                          },
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
                              offset:
                                  Offset(0, 4), // changes position of shadow
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              padding:
                                  MaterialStatePropertyAll(EdgeInsets.all(12)),
                              shape: MaterialStatePropertyAll(
                                CircleBorder(
                                  eccentricity: 0,
                                ),
                              )),
                          onPressed: () => {
                            context
                                .read<SeaMapBloc>()
                                .add(AlertMapFetchedRequested())
                          },
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

  void _showUserLocationBottomSheet(var data) {
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
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
                      height: 20,
                    ),
                    currentPos("Latitude", data.latitude.toStringAsFixed(4)),
                    currentPos("Longitude", data.longitude.toStringAsFixed(4)),
                    currentPos(
                        "Timestamp", pstDateFormat.dateString(data.timestamp)),
                    currentPos("Altitude", data.altitude.toStringAsFixed(4)),
                    currentPos("Speed", data.speed.toStringAsFixed(4)),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _showAlertLocationBottomSheet(AlertModel alert) {
    showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            child: Container(
              height: 270,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(240, 205, 146, 1),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(13),
                            topRight: Radius.circular(13)),
                      ),
                      child: Center(
                        child: Text(
                          alert.title,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Readex Pro",
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Row(
                        children: [
                          Text(
                            "Description: ",
                            style: TextStyle(
                                fontFamily: "Readex Pro",
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text(
                              alert.description,
                              style: TextStyle(
                                  fontFamily: "Readex Pro", fontSize: 13),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Row(
                        children: [
                          Text(
                            "Instruction: ",
                            style: TextStyle(
                                fontFamily: "Readex Pro",
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text(
                              alert.instruction,
                              style: TextStyle(
                                  fontFamily: "Readex Pro", fontSize: 13),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    currentPos("Latitude", alert.location[0][1].toString()),
                    currentPos("Longitude", alert.location[0][0].toString()),
                    currentPos(
                        "Radius", alert.radius.toString() + ' kilometers'),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _showBoundaryLocationBottomSheet(BoundaryModel boundary) {
    showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            child: Container(
              height: 270,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(240, 205, 146, 1),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(13),
                            topRight: Radius.circular(13)),
                      ),
                      child: Center(
                        child: Text(
                          boundary.title,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Readex Pro",
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Row(
                        children: [
                          Text(
                            "Region: ",
                            style: TextStyle(
                                fontFamily: "Readex Pro",
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text(
                              boundary.region,
                              style: TextStyle(
                                  fontFamily: "Readex Pro", fontSize: 13),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Row(
                        children: [
                          Text(
                            "Province: ",
                            style: TextStyle(
                                fontFamily: "Readex Pro",
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text(
                              boundary.province[0].toUpperCase() +
                                  boundary.province.substring(1).toLowerCase(),
                              style: TextStyle(
                                  fontFamily: "Readex Pro", fontSize: 13),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Row(
                        children: [
                          Text(
                            "Municipality: ",
                            style: TextStyle(
                                fontFamily: "Readex Pro",
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text(
                              boundary.municipality[0].toUpperCase() +
                                  boundary.municipality
                                      .substring(1)
                                      .toLowerCase(),
                              style: TextStyle(
                                  fontFamily: "Readex Pro", fontSize: 13),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Row(
                        children: [
                          Text(
                            "Postal Code: ",
                            style: TextStyle(
                                fontFamily: "Readex Pro",
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text(
                              boundary.postal_code.toString(),
                              style: TextStyle(
                                  fontFamily: "Readex Pro", fontSize: 13),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
