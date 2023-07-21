import 'dart:io';

import 'package:bach_thes/controllers/profile_page_controller.dart';
import 'package:bach_thes/models/current_user.dart';
import 'package:bach_thes/models/hike.dart';
import 'package:bach_thes/models/hiker.dart';
import 'package:bach_thes/views/widgets/booklet_widget.dart';
import 'package:bach_thes/views/widgets/mountain_card.dart';
import 'package:bach_thes/views/widgets/reusable_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bach_thes/utils/styles.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:bach_thes/views/widgets/hike_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main_page.dart';
import 'package:bach_thes/models/hiker.dart';
import 'package:bach_thes/globals.dart';

//TODO: change current hiker to getting data from shared prefernces

/* UI for showing users profile page. it shows their picture, username, 
level, number of points on a progress bar and their booklet. The booklet itself
 consists of recorderd hikes and achieved peaks and badges. Both parts of the 
 booklet are clickable. They lead to new pages with all possible peaks.*/

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var currentUserTwo = FirebaseAuth.instance.currentUser?.uid.toString();
  List recentHikes = [];
  final List achievedPeaks = [];
  final List achievedBadges = [];
  var username;
  var points = 1;
  var level = 1;

  String percentProgress = '';
  double decimalProgress = 0.0;

  getHikerData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      points = prefs.getInt('points')!;
      username = prefs.getString('username');
      level = prefs.getInt('level')!;
    });
  }

  returnListHikes(String? currentUserTwo) async {
    var recordedHikesQuery = await FirebaseFirestore.instance
        .collection('RecordedHikes')
        .where('hikerId', isEqualTo: currentUserTwo)
        .limit(3)
        .get();

    setState(() {
      recentHikes = List.from(recordedHikesQuery.docs);
    });
    //print(recentHikes);
  }

  String returnPercentProgress() {
    //returns the percentage in 20% form
    String percentprogres = '';
    int remaining = points % 100;
    percentprogres = remaining.toString();
    return percentprogres;
  }

  double returnDecimalProgress() {
    double decimalProgress = 0.0;
    int remaining = points % 100;
    decimalProgress = remaining / 100;
    return decimalProgress;
  }

  @override
  void initState() {
    getHikerData();
    returnListHikes(currentUserTwo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var percPoints = getPercent(points);
    return Scaffold(
        body: Container(
            child: SingleChildScrollView(
                child: Column(
      children: [
        SizedBox(
          height: 25,
        ),
        CircleAvatar(
            backgroundColor: Styles.lightgreen,
            radius: 50,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('lib/utils/images/user_logo.png'),
              radius: 40,
            )),
        //logoWidget(currentHiker.profilePicture),
        SizedBox(
          height: 20,
        ),
        Center(
            child: Container(
          child: Text("$username", style: Styles.headerLarge),
        )),
        SizedBox(
          height: 20,
        ),
        //level
        Center(
            child: Container(
          child: Text("Level ${level}", style: TextStyle(fontSize: 15)),
        )),

        SizedBox(height: 10),
        Center(
            child: Container(
          child: Text("${points}/${level}00 points",
              style: TextStyle(fontSize: 15)),
        )),

        //progress bar with points
        Padding(
          padding: EdgeInsets.all(15.0),
          child: LinearPercentIndicator(
            width: MediaQuery.of(context).size.width - 50,
            animation: true,
            lineHeight: 20.0,
            animationDuration: 2500,
            percent: getDecimal(points), //CHANGE WHEN DECIMAL PROGRESS IS FIXED
            center:
                Text("${percPoints}%", style: TextStyle(color: Colors.white)),
            barRadius: Radius.circular(20),
            progressColor: Styles.deepgreen,
          ),
        ),
        SizedBox(
          height: 25,
        ),
        Center(
            child:
                Text("My most recent hikes", style: TextStyle(fontSize: 18))),

        //most recent hikes (top 3 or display "You don't have any recent hikes yet")
        Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                color: Styles.offwhite,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: renderLatestHikes(recentHikes),
                  )),
            ),
          ),
        )
      ],
    ))));
  }
}

int getPercent(int points) {
  var percPoints = points % 100;
  return percPoints;
}

double getDecimal(int points) {
  var decPoints = (points % 100) / 100;
  return decPoints;
}
/*getHikerInfo() async {
  var currentUserOne = FirebaseAuth.instance.currentUser?.uid.toString();
  var data = FirebaseFirestore.instance
      .collection('Hikers')
      .where('id', isEqualTo: currentUserOne);

  String usernamee = data.get('email' as GetOptions?).toString();

  //Hiker currentHiker
}

Future<QuerySnapshot> getHikerData() async {
  var currentUserOne = FirebaseAuth.instance.currentUser?.uid.toString();
  return await FirebaseFirestore.instance
      .collection("Hikers")
      .where('id', isEqualTo: currentUserOne)
      .get();
}*/

/*return Scaffold(
      body: Column(
        children: [
          //background top picture
          Image.asset("lib/utils/images/profile_back.png"),
          SizedBox(height: 20),
          //user avatar
          //usrt name
          //user level
          //user progress bar with points
          //user Booklet (user id)
          BookletWidget()
        ],
      ),
    );*/


