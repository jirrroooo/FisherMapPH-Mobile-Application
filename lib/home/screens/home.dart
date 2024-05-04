import 'package:fishermap_ph_mobileapp/data/credentials.dart';
import 'package:fishermap_ph_mobileapp/data/secure_storage.dart';
import 'package:fishermap_ph_mobileapp/home/bloc/home_bloc.dart';
import 'package:fishermap_ph_mobileapp/home/repository/home_repository.dart';
import 'package:fishermap_ph_mobileapp/features/alert_page/screens/alert_log_screen.dart';
import 'package:fishermap_ph_mobileapp/features/distress_call_page/screens/distress_call_screen.dart';
import 'package:fishermap_ph_mobileapp/features/homepage/screens/home_screen.dart';
import 'package:fishermap_ph_mobileapp/features/location_page/screens/location_log_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

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

  HomeRepository homeRepository = HomeRepository();
  SecureStorage secureStorage = SecureStorage();
  Credentials credentials = Credentials();

  final DateFormat formatter = DateFormat('MMMM d, y');

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    _isVerified();
    context.read<HomeBloc>().add(InfoFetched());
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
      drawer: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is InfoFailure) {
            return Center(
              child: Text(state.error),
            );
          }

          if (state is! InfoSuccess) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          final data = state.infoModel;

          final first_name =
              data.first_name == Null ? "Fisherfolk" : data.first_name;
          final last_name =
              data.last_name == Null ? "Philippines" : data.last_name;
          final DateTime createdAt =
              data.createdAt == Null ? DateTime.now() : data.createdAt;
          final bool isAuthenticated =
              data.isAuthenticated == Null ? false : data.isAuthenticated;

          return Drawer(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 150.0,
                      height: 150.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(75.0)),
                        color: Color.fromRGBO(90, 205, 224, 1),
                      ),
                      child: Image.asset(
                        'assets/images/fisherman.png',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${first_name} ${last_name}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          fontFamily: "Readex Pro"),
                    ),
                    Text("Member Since ${formatter.format(createdAt)}",
                        style:
                            TextStyle(fontSize: 12, fontFamily: "Readex Pro")),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.verified,
                          color: isAuthenticated ? Colors.blue : Colors.grey,
                          size: 18,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(isAuthenticated ? "Verified" : "Not Verified",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Readex Pro"))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      height: 30,
                      thickness: 1,
                      color: Color.fromRGBO(47, 51, 64, 1),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.person),
                      title: Text('Profile'),
                      onTap: () =>
                          {Navigator.popAndPushNamed(context, '/profile')},
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.notifications),
                      title: Text('Notifications'),
                      onTap: () =>
                          {Navigator.popAndPushNamed(context, "/notification")},
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.cloud),
                      title: Text('Weather'),
                      onTap: () =>
                          {Navigator.popAndPushNamed(context, "/weather")},
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.settings),
                      title: Text('Settings'),
                      onTap: () =>
                          {Navigator.popAndPushNamed(context, '/settings')},
                    ),
                    const Divider(
                      height: 20,
                      thickness: 1,
                      color: Color.fromRGBO(47, 51, 64, 1),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.assignment),
                      title: Text('Credits'),
                      onTap: () =>
                          {Navigator.popAndPushNamed(context, "/credits")},
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.info),
                      title: Text('About'),
                      onTap: () =>
                          {Navigator.popAndPushNamed(context, "/about")},
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.privacy_tip),
                      title: Text('Privacy Policy'),
                      onTap: () => {
                        Navigator.popAndPushNamed(context, "/privacy-policy")
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                        onPressed: () => {
                              secureStorage.deleteAllSecureData(),
                              Navigator.popAndPushNamed(context, "/login")
                            },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.logout,
                              color: Colors.white,
                            ),
                            Text(
                              "Logout",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Readex Pro",
                                  fontSize: 15),
                            ),
                            SizedBox(
                              width: 20,
                            )
                          ],
                        ),
                        style: ButtonStyle(
                            minimumSize:
                                MaterialStatePropertyAll(Size(270, 50)),
                            backgroundColor: MaterialStatePropertyAll(
                                Color.fromRGBO(37, 142, 190, 1)),
                            shape:
                                MaterialStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ))))
                  ],
                ),
              ),
            ),
          );
        },
      ),
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
