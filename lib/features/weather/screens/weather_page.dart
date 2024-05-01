import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  TextStyle boldStyle = TextStyle(
      fontFamily: "Readex Pro", fontSize: 15, fontWeight: FontWeight.w500);
  TextStyle normalStyle = TextStyle(fontFamily: "Readex Pro", fontSize: 15);

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
      appBar: AppBar(
        title: Text(
          "Weather Forecast",
          style: TextStyle(
              fontFamily: "Readex Pro",
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(onPressed: () => {}, icon: Icon(Icons.refresh_rounded))
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/day1.png",
                    width: 100,
                  ),
                  Text(
                    "36°C",
                    style: TextStyle(fontSize: 60, fontFamily: "Readex Pro"),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.red,
                  ),
                  Text(
                    "Los Baños, Laguna",
                    style: boldStyle,
                  )
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(16)),
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      "assets/images/cloud_rain.png",
                      width: 35,
                    ),
                    Text(
                      "37%",
                      style: boldStyle,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      "assets/images/rain_drop.png",
                      width: 20,
                    ),
                    Text(
                      "3 mm",
                      style: boldStyle,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      "assets/images/wind.png",
                      width: 35,
                    ),
                    Text(
                      "25 km/h",
                      style: boldStyle,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(16)),
                height: 230,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Today",
                            style: boldStyle,
                          ),
                          Text(
                            "May, 01",
                            style: boldStyle,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                        height: 170,
                        child: ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 12,
                            itemBuilder: (BuildContext context, int index) =>
                                Column(
                                  children: [
                                    Text(
                                      "47°C",
                                      style: normalStyle,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Image.asset(
                                      "assets/images/day2.png",
                                      width: 70,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "37%",
                                      style: normalStyle,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "${index + 1} PM",
                                      style: boldStyle,
                                    )
                                  ],
                                ))),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(16)),
                  height: 230,
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Next Forecast",
                          style: boldStyle,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                            height: 160,
                            child: ListView.builder(
                                physics: ClampingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: 7,
                                itemBuilder:
                                    (BuildContext context, int index) => Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Monday",
                                              style: boldStyle,
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Image.asset(
                                              "assets/images/night3.png",
                                              width: 30,
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              "31°C",
                                              style: normalStyle,
                                            ),
                                            Text(
                                              "76%",
                                              style: normalStyle,
                                            ),
                                          ],
                                        ))),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
