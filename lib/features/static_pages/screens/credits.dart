import 'package:flutter/material.dart';

class CreditsPage extends StatefulWidget {
  const CreditsPage({super.key});

  @override
  State<CreditsPage> createState() => _CreditsPageState();
}

class _CreditsPageState extends State<CreditsPage> {
  var credits = [
    "https://www.flaticon.com/free-icons/developer",
    "https://www.vecteezy.com/free-vector/fisherman",
    "https://www.flaticon.com/free-icons/wind",
    "https://www.flaticon.com/free-icons/blood",
    "https://www.freepik.com/free-vector/fishing-with-net-concept-illustration_37573837.htm#&position=20&from_view=author&uuid=6ddd2107-5ed2-4c25-ab0c-b2e731d2118e",
    "https://www.freepik.com/free-vector/megaphone-concept-illustration_63060941.htm#&position=1&from_view=author&uuid=6ddd2107-5ed2-4c25-ab0c-b2e731d2118e",
    "https://www.freepik.com/free-vector/oops-404-error-with-broken-robot-concept-illustration_13315300.htm#&position=28&from_view=author&uuid=6ddd2107-5ed2-4c25-ab0c-b2e731d2118e",
    "https://www.freepik.com/free-vector/megaphone-concept-illustration_144643098.htm#page=2&position=46&from_view=author&uuid=6ddd2107-5ed2-4c25-ab0c-b2e731d2118e",
    "https://www.freepik.com/free-vector/megaphone-concept-illustration_144643098.htm#page=2&position=46&from_view=author&uuid=6ddd2107-5ed2-4c25-ab0c-b2e731d2118e",
    "https://www.freepik.com/free-vector/ok-concept-illustration_8320200.htm#page=8&position=30&from_view=author&uuid=6ddd2107-5ed2-4c25-ab0c-b2e731d2118e",
    "https://www.freepik.com/free-vector/drawn-people-celebrating-goal-achievement_12063468.htm#fromView=search&page=1&position=34&uuid=1715e51f-74d7-4afd-8abb-d178600d2a1b",
    "https://www.flaticon.com/free-icons/foursquare-check-in",
    "https://www.flaticon.com/free-icons/fisherman",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Credits",
          style: TextStyle(
              fontFamily: "Readex Pro",
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => {Navigator.pop(context)},
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "Image and Icon References (Links)",
                style: TextStyle(
                    fontFamily: "Readex Pro",
                    fontSize: 15,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 20,
              ),
              ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: credits.length,
                  itemBuilder: (BuildContext context, int index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            credits[index],
                            style: TextStyle(
                                fontFamily: "Readex Pro", fontSize: 12),
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ))
            ],
          ),
        ),
      ),
    );
  }
}
