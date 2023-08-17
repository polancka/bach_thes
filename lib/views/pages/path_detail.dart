import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:bach_thes/models/path.dart';
import 'package:bach_thes/utils/styles.dart';
import 'package:bach_thes/controllers/navigation_controller.dart';

/* UI for displayinf more information about a chosen path. User wil also be able 
to record his hike on this path by pressing the "Record" button. */

class PathDetail extends StatelessWidget {
  final dynamic path;
  PathDetail(this.path);

  var hours = 0;
  var minutes = 0;

  @override
  Widget build(BuildContext context) {
    hours = path['duration'] ~/ 60;
    minutes = path['duration'] % 60;

    return SafeArea(
        child: Scaffold(
            extendBodyBehindAppBar: false,
            appBar: AppBar(
              centerTitle: true,
              title: Text("Path", style: TextStyle(color: Styles.deepgreen)),
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Styles.deepgreen),
            ),
            body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                    child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              "${path['pathName']} - ${path['startingPointAltitude']}m",
                              style: TextStyle(
                                  fontSize: 20, color: Styles.deepgreen),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Text(
                              "${path['difficulty']} to ${path['finishPointName']}",
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Text(
                              "${path['altimeters']} altimeters",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Text(
                              "${path['altimetersOnTheWay']} altimeters on the way",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Text(
                              "Duration: $hours h $minutes min",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateColor.resolveWith(
                                          (states) => Styles.deepgreen)),
                              onPressed: () {
                                MyNavigator(context).navigateToRecordingPage();
                              },
                              child: Text(
                                "Record this path",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Wrap(children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width * 0.85,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              child: Text("${path['description']}",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400)),
                            )
                          ],
                        )
                      ]),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )))));
  }
}
