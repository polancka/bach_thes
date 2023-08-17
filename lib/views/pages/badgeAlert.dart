import 'package:flutter/material.dart';
import 'package:bach_thes/controllers/navigation_controller.dart';
import 'package:bach_thes/utils/styles.dart';

class BadgeAlert extends StatefulWidget {
  List<String> newBadges;

  BadgeAlert({required this.newBadges});

  @override
  State<BadgeAlert> createState() => _BadgeAlertState();
}

class _BadgeAlertState extends State<BadgeAlert> {
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
                  MyNavigator(context).navigateToMainPage();
                });
              },
            ),
            SizedBox(
              height: 15,
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
            SizedBox(height: 15),
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
                              child: Text("You have unlocked\n a new badge! ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Styles.deepgreen,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500,
                                  )),
                            ))),
                  ],
                )),
            SizedBox(height: 5),
            Image.asset('lib/utils/images/trophy.gif'),
            Text("${widget.newBadges[0]}",
                style: TextStyle(
                  color: Styles.deepgreen,
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ))
          ],
        ),
      ),
    ));
  }
}
