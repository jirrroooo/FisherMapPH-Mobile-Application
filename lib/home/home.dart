import 'package:fishermap_ph_mobileapp/components/drawer.dart';
import 'package:fishermap_ph_mobileapp/features/alert_page/screens/alert_log_screen.dart';
import 'package:fishermap_ph_mobileapp/features/distress_call_page/screens/distress_call_screen.dart';
import 'package:fishermap_ph_mobileapp/features/homepage/screens/home_screen.dart';
import 'package:fishermap_ph_mobileapp/features/location_page/screens/location_log_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 2;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    AlertLogPage(),
    HomeScreen(),
    LocationLogPage(),
    DistressCallScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      drawer: AppDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_rounded),
            label: 'Fisher Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.warning_rounded),
            label: 'Alert',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_rounded),
            label: 'Location',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.ring_volume_rounded),
            label: 'Emergency',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromRGBO(37, 142, 190, 1),
        onTap: _onItemTapped,
      ),
    );
  }
}
