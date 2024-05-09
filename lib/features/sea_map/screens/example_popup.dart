import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class ExamplePopup extends StatefulWidget {
  final Marker marker;

  const ExamplePopup(this.marker, {super.key});

  @override
  State<StatefulWidget> createState() => _ExamplePopupState();
}

class _ExamplePopupState extends State<ExamplePopup> {
  final List<IconData> _icons = [
    Icons.star_border,
    Icons.star_half,
    Icons.star
  ];
  int _currentIcon = 0;

  @override
  Widget build(BuildContext context) {
    return Text("This is a test");
    // return Container(
    //     height: 300,
    //     width: 300,
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(16),
    //       border: Border.all(
    //         width: 2,
    //       ),
    //     ),
    //     child: Column(
    //       children: [
    //         Container(
    //           height: 50,
    //           width: double.infinity,
    //           decoration: BoxDecoration(
    //             color: Color.fromRGBO(47, 51, 64, 1),
    //             borderRadius: BorderRadius.only(
    //                 topLeft: Radius.circular(13),
    //                 topRight: Radius.circular(13)),
    //           ),
    //           child: Center(
    //             child: Text(
    //               "Current Position Information",
    //               style: TextStyle(
    //                   color: Colors.white,
    //                   fontFamily: "Readex Pro",
    //                   fontSize: 15),
    //             ),
    //           ),
    //         ),
    //         SizedBox(
    //           height: 15,
    //         ),
    //         currentPos("Latitude", "20.1234"),
    //         currentPos("Longitude", "20.1234"),
    //         currentPos("Timestamp", "08/15/2001 - 10:54:32"),
    //         currentPos("Location", "West Philippine Sea"),
    //         SizedBox(
    //           height: 5,
    //         ),
    //         ElevatedButton(
    //             onPressed: () => {},
    //             child: Text(
    //               "Locate in FisherMap PH",
    //               style: TextStyle(
    //                   color: Colors.white,
    //                   fontFamily: "Readex Pro",
    //                   fontSize: 15),
    //             ),
    //             style: ButtonStyle(
    //                 backgroundColor: MaterialStatePropertyAll(
    //                     Color.fromRGBO(37, 142, 190, 1)),
    //                 shape: MaterialStatePropertyAll(RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(8.0),
    //                 ))))
    //       ],
    //     ));
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

  Widget _cardDescription(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        constraints: const BoxConstraints(minWidth: 200, maxWidth: 300),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'Popup for a marker!',
              overflow: TextOverflow.fade,
              softWrap: false,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
            Text(
              'Position: ${widget.marker.point.latitude}, ${widget.marker.point.longitude}',
              style: const TextStyle(fontSize: 12.0),
            ),
            Text(
              'Marker size: ${widget.marker.width}, ${widget.marker.height}',
              style: const TextStyle(fontSize: 12.0),
            ),
          ],
        ),
      ),
    );
  }
}
