import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
              "John Rommel B. Octavo",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  fontFamily: "Readex Pro"),
            ),
            Text("Member Since 08/15/2001",
                style: TextStyle(fontSize: 12, fontFamily: "Readex Pro")),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.verified,
                  color: Colors.blue,
                  size: 18,
                ),
                SizedBox(
                  width: 5,
                ),
                Text("Verified",
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
              onTap: () => {},
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.notifications),
              title: Text('Notifications'),
              onTap: () => {},
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.cloud),
              title: Text('Weather'),
              onTap: () => {},
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () => {},
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
              onTap: () => {Navigator.popAndPushNamed(context, "/credits")},
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.info),
              title: Text('About'),
              onTap: () => {Navigator.popAndPushNamed(context, "/about")},
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.privacy_tip),
              title: Text('Privacy Policy'),
              onTap: () =>
                  {Navigator.popAndPushNamed(context, "/privacy-policy")},
            ),
            SizedBox(
              height: 90,
            ),
            ElevatedButton(
                onPressed: () => {},
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
                    minimumSize: MaterialStatePropertyAll(Size(270, 50)),
                    backgroundColor: MaterialStatePropertyAll(
                        Color.fromRGBO(37, 142, 190, 1)),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ))))
          ],
        ),
      ),
    );
  }
}