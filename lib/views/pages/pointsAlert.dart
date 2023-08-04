import 'package:bach_thes/controllers/navigation_controller.dart';
import 'package:bach_thes/models/hiker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bach_thes/utils/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PointsPage extends StatefulWidget {
  String action;
  int points;
  List<String> badges;
  PointsPage(
      {required this.action, required this.points, required this.badges});

  @override
  State<PointsPage> createState() => _PointsPageState();
}

class _PointsPageState extends State<PointsPage> {
  bool isNewLevel = false;
  var newLevel = 0;
  bool _newBadge = false;

  updatePoints() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var oldpoints = prefs.getInt('points');
    var newpoints = oldpoints! + widget.points;
    prefs.setInt('points', newpoints);
    updateNewPoints(newpoints, FirebaseAuth.instance.currentUser!.uid);
  }

  checkForLevelUpdate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var currentLevel = prefs.getInt('level')!;
    var currentPoints = prefs.getInt('points')!;

    if ((currentPoints ~/ currentLevel) >= 100) {
      //level needs to be updated
      newLevel = currentLevel + 1;
      updateNewLevel(newLevel, FirebaseAuth.instance.currentUser!.uid);
      prefs.setInt('level', newLevel);
      setState(() {
        isNewLevel = true;
      });
    }
  }

  checkForNewBadge(List<String> badges) {
    if (badges.isNotEmpty) {
      setState(() {
        _newBadge = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    updatePoints();
    checkForLevelUpdate();
    checkForNewBadge(widget.badges);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('lib/utils/images/points_conf.png'),
                fit: BoxFit.cover)),
        child: Column(
          children: [
            SizedBox(
              height: 35,
            ),
            CloseButton(
              onPressed: () {
                setState(() {
                  isNewLevel = false;
                  _newBadge
                      ? MyNavigator(context).navigateToBadgeAlert(widget.badges)
                      : MyNavigator(context).navigateToMainPage();
                });
              },
            ),
            SizedBox(
              height: 55,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: Text("Congratulations!",
                        style: TextStyle(
                            color: Styles.deepgreen,
                            fontSize: 30,
                            fontWeight: FontWeight.w700))),
              ],
            ),
            SizedBox(height: 45),
            Padding(
                padding: EdgeInsets.all(25),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Container(
                            decoration: BoxDecoration(color: Colors.white),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                  "By ${widget.action} you earned ${widget.points} points! ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Styles.deepgreen,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500,
                                  )),
                            ))),
                  ],
                )),
            Expanded(
                child: isNewLevel
                    ? Container(
                        child: Align(
                        alignment: Alignment.center,
                        child: Text("You also reached Level ${newLevel} ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Styles.deepgreen,
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                            )),
                      ))
                    : Text("")),
          ],
        ),
      ),
    ));
  }
}
