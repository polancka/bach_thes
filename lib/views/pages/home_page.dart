import 'package:bach_thes/controllers/navigation_controller.dart';
import 'package:bach_thes/models/hiker.dart';
import 'package:bach_thes/models/path.dart';
import 'package:bach_thes/views/pages/list_of_peaks.dart';
import 'package:bach_thes/views/pages/map_page.dart';
import 'package:bach_thes/views/pages/profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:bach_thes/models/peak.dart';
import 'dart:developer';
import 'package:bach_thes/globals.dart';
import 'package:bach_thes/main.dart';
import 'package:bach_thes/utils/styles.dart';
import 'package:bach_thes/views/widgets/reusable_widgets.dart';
import 'package:bach_thes/models/peak.dart';

//UI for landing page

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    List pages = [MapPage(), SearchPeaks(), ProfilePage()];

    return SafeArea(
      child: Scaffold(
        drawer: myDrawer(context),
        backgroundColor: Colors.white12,
        body: Container(
            width: w,
            height: h,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, h * 0.1, 20, 0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Welcome hiker!",
                              style: TextStyle(
                                  color: Styles.deepgreen,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25))
                        ],
                      ),
                      SizedBox(
                        height: h * 0.1,
                      ),
                      Row(
                        children: [
                          TextButton.icon(
                              onPressed:
                                  MyNavigator(context).NavigateToSearchPeaks,
                              icon: Icon(Icons.hiking_outlined,
                                  color: Colors.white),
                              label: Text(
                                "Search Peaks",
                                style: TextStyle(color: Colors.white),
                              )),
                          //landingPageTile(context, "Search peaks and paths"),
                          SizedBox(
                            width: 10,
                          ),
                          //landingPageTile(context, "My booklet")
                          //second tile
                        ],
                      ),
                      //SizedBox(height: 10),
                      /*Row(
                        children: [
                          landingPageTile(context, "My profile"),
                          SizedBox(
                            width: 10,
                          ),
                          landingPageTile(context, "Look up on the map")
                        ],
                      )*/
                    ]),
              ),
            )),
      ),
    );
  }
}

Future<void> readPeaks() async {
  await db.collection("Peaks").get().then((event) {
    for (var doc in event.docs) {
      log("${doc.id} => ${doc.data()}");
    }
  });
}
