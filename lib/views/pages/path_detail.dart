//make UI for page that shows information about a specific path

//implement search function - search bar, look for solutions

//implement drawer

//implement profile UI

//Collecting user data from firestore - make a new collection or add parameters to authentication database

//MVC or MVVM dillema - pros and cons of each, which is more suitable, how to implement

//Sign in - simple pop up messages "The password does not match the email adress given"

//Register - simple pop up messages "Please enter a valid email" / "Please enter a name" / "The password must be at least 8 characters long

//home page UI - four tiles leading to different pages, implement the UI and the controller that is bassically just a navigator
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:bach_thes/models/path.dart';
import 'package:bach_thes/utils/styles.dart';

class PathDetail extends StatelessWidget {
  final Path path;
  PathDetail(this.path);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(backgroundColor: Colors.white.withOpacity(0)),
            body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Styles.deepgreen,
                    Styles.lightgreen,
                    Styles.offwhite
                  ], begin: Alignment.bottomRight, end: Alignment.topLeft),
                ),
                child: SingleChildScrollView(
                    child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Styles.deepgreen,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              "${path.startingPointName}",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
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
                              "${path.difficulty}",
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
                              "${path.altimeters}m višinske razlike",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
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
                              child: Text("${path.description}",
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateColor.resolveWith(
                                          (states) => Styles.deepgreen)),
                              onPressed: () {
                                log("pressed");
                              },
                              child: Text(
                                "Record this path",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ))
                        ],
                      )
                    ],
                  ),
                )))));
  }
}
