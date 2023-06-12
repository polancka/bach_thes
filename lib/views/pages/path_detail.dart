//make UI for page that shows information about a specific path

//gather information from Firestore

//add information to Firestore (not via app)

//implement search function - search bar, look for solutions

//implement drawer

//implement profile UI

//Collecting user data from firestore - make a new collection or add parameters to authentication database

//MVC or MVVM dillema - pros and cons of each, which is more suitable, how to implement

//Sign in - simple pop up messages "The password does not match the email adress given"

//Register - simple pop up messages "Please enter a valid email" / "Please enter a name" / "The password must be at least 8 characters long

//home page UI - four tiles leading to different pages, implement the UI and the controller that is bassically just a navigator
import 'package:flutter/material.dart';
import 'package:bach_thes/models/path.dart';

class PathDetail extends StatelessWidget {
  final Path path;
  PathDetail(this.path);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text("Path to ${path.endPointName}"),
              backgroundColor: Colors.pinkAccent,
            ),
            body: Padding(
              padding: EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Colors.pinkAccent,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "${path.startingPointName} - ${path.endPointName}",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Container(
                        child: Text("${path.difficulty}"),
                      ),
                      Container(
                        child: Text("${path.alitmeters}"),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Container(
                        child: Text("${path.description}"),
                      )
                    ],
                  )
                ],
              ),
            )));
  }
}
