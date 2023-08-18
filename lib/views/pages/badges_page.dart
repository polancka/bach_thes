import 'package:bach_thes/main.dart';
import 'package:bach_thes/views/widgets/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/styles.dart';

//page taht shows all badges tha user can achieve and thta the user has achieved already

class BadgesPage extends StatefulWidget {
  const BadgesPage({super.key});

  @override
  State<BadgesPage> createState() => _BadgesPageState();
}

class _BadgesPageState extends State<BadgesPage> {
  var badgeNames = [
    "5 hikes",
    "10 hikes",
    "25 hikes",
    "40 hikes",
    "65 hikes",
    "Hike in every region",
    "5 hikes in one region",
    "10 hikes in one region",
    "3 new peaks",
    "7 new peaks",
    "12 new peaks",
    "15 new peaks",
    "21 new peaks",
    "1000 altimeters",
    "2500 altimeters",
    "3500 altimeters",
    "4500 altimeters",
  ];
  List<String> listOfBadges = [
    "false",
    "false",
    "false",
    "false",
    "false",
    "false",
    "false",
    "false",
    "false",
    "false",
    "false",
    "false",
    "false",
    "false",
    "false",
    "false",
    "false"
  ];

  Future<String> getSharedPrefsBadges() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      listOfBadges = prefs.getStringList('badges')!;
    });
    return "complete";
  }

  List<Widget> renderBadgeTiles(int startingIndex, int endIndex) {
    List<Widget> allBadges = [];

    for (int i = startingIndex; i <= endIndex; i++) {
      //print(" $i iteration : $listOfBadges[i]");
      print(listOfBadges);
      if (listOfBadges[i] == "true") {
        allBadges.add(GridTile(child: colorfulBadgeTile(badgeNames[i])));
      } else {
        allBadges.add(
          GridTile(
            child: greyedOutBadgeTile(badgeNames[i]),
          ),
        );
      }
    }
    return allBadges;
  }

  Widget greyedOutBadgeTile(String name) {
    return Container(
      foregroundDecoration: BoxDecoration(
        color: Colors.grey,
        backgroundBlendMode: BlendMode.saturation,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 0.8),
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.withOpacity(0.3),
      ),
      child: Center(
        child: Column(
          children: [
            Expanded(
              child: Image.asset("lib/utils/images/trophystill.jpg"),
            ),
            Expanded(
                child: Center(
              child: Text(
                "${name}",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget colorfulBadgeTile(String name) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Styles.lightgreen, width: 1),
        borderRadius: BorderRadius.circular(8),
        color: Color.fromARGB(255, 134, 230, 138).withOpacity(0.8),
      ),
      child: Center(
        child: Column(
          children: [
            Expanded(
              child: Image.asset("lib/utils/images/trophy.gif"),
            ),
            Expanded(
                child: Center(
              child: Text(
                "${name}",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromARGB(255, 42, 98, 44),
                    fontWeight: FontWeight.w600),
              ),
            ))
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    getSharedPrefsBadges();
    print(listOfBadges);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar("My badges"),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Center(
                  child: Text(
                "Number of hikes",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              )),
              SizedBox(
                height: 10,
              ),
              Container(
                  child: IgnorePointer(
                      child: GridView.count(
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                shrinkWrap: true,
                // Create a grid with 2 columns. If you change the scrollDirection to
                // horizontal, this produces 2 rows.
                crossAxisCount: 4,
                // Generate 100 widgets that display their index in the List.
                children: renderBadgeTiles(0, 4),
              ))),
              SizedBox(
                height: 10,
              ),
              Center(
                  child: Text(
                "Regions of hiking",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              )),
              SizedBox(
                height: 10,
              ),
              Container(
                  child: IgnorePointer(
                      child: GridView.count(
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                shrinkWrap: true,
                // Create a grid with 2 columns. If you change the scrollDirection to
                // horizontal, this produces 2 rows.
                crossAxisCount: 4,
                // Generate 100 widgets that display their index in the List.
                children: renderBadgeTiles(5, 7),
              ))),
              SizedBox(
                height: 10,
              ),
              Center(
                  child: Text(
                "New conquests",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              )),
              SizedBox(
                height: 10,
              ),
              Container(
                  child: IgnorePointer(
                      child: GridView.count(
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                shrinkWrap: true,
                // Create a grid with 2 columns. If you change the scrollDirection to
                // horizontal, this produces 2 rows.
                crossAxisCount: 4,
                // Generate 100 widgets that display their index in the List.
                children: renderBadgeTiles(8, 12),
              ))),
              SizedBox(
                height: 10,
              ),
              Center(
                  child: Text(
                "Altimeters",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              )),
              SizedBox(
                height: 10,
              ),
              Container(
                  child: IgnorePointer(
                      child: GridView.count(
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                shrinkWrap: true,
                // Create a grid with 2 columns. If you change the scrollDirection to
                // horizontal, this produces 2 rows.
                crossAxisCount: 4,
                // Generate 100 widgets that display their index in the List.
                children: renderBadgeTiles(13, 16),
              ))),
            ],
          ),
        )));
  }
}
