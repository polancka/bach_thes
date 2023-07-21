import 'package:bach_thes/controllers/navigation_controller.dart';
import 'package:bach_thes/models/hiker.dart';
import 'package:bach_thes/models/path.dart';
import 'package:bach_thes/views/pages/list_of_peaks.dart';
import 'package:bach_thes/views/pages/map_page.dart';
import 'package:bach_thes/views/pages/profile_page.dart';
import 'package:bach_thes/views/widgets/horizontal_scroll_peaks.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

//UI for landing page

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /*@override
  void initState() {
    // TODO: implement initState
    super.initState();
    makeSharedPreferences(currentHiker);
  }*/

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
                        Text("Welcome user!",
                            style: TextStyle(
                                color: Styles.deepgreen,
                                fontWeight: FontWeight.bold,
                                fontSize: 25))
                      ],
                    ),
                    /* Row(
                      children: [HorizontalScrollPeaks()],
                    )*/
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

/*makeSharedPreferences(Hiker currentHiker) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('username', currentHiker.username);

  final int? counter = prefs.getInt('username');
  print(counter.toString());
}*/
