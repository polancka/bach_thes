import 'package:bach_thes/models/hiker.dart';
import 'package:bach_thes/utils/styles.dart';
import 'package:bach_thes/views/widgets/reusable_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controllers/navigation_controller.dart';

//This page displays the results of Random Hike Page. User can choose from all
//the paths offered to them. More informationa re provided, when clicked
//on the individual path tile.

class RandomHikeResultPage extends StatefulWidget {
  int duration;
  String difficulty;
  String mountainChain;
  RandomHikeResultPage({
    required this.duration,
    required this.difficulty,
    required this.mountainChain,
  });

  @override
  State<RandomHikeResultPage> createState() => _RandomHikeResultPageState();
}

class _RandomHikeResultPageState extends State<RandomHikeResultPage> {
  bool hasPaths = false;
  List<dynamic> pathsToShow = [];
  bool hasPreviousSearches = false;
  List<String> recentSearchesFromPrefs = [];
  var currentUserTwo = FirebaseAuth.instance.currentUser?.uid.toString();

  Future<String> getRandomHike(duration, difficulty, mountainChain) async {
    var randomHikesQuery = await FirebaseFirestore.instance
        .collection('Paths')
        .where('difficulty', isEqualTo: difficulty)
        .where('mountainChain', isEqualTo: mountainChain)
        .where('duration', isLessThan: duration)
        .get();

    if (randomHikesQuery.docs.length > 0) {
      setState(() {
        hasPaths = true;
        pathsToShow = List.from(randomHikesQuery.docs);
      });
    } else {
      setState(() {
        hasPaths = false;
      });
    }

    return "complete";
  }

  addToPreviousSearches(String name) async {
    //get from database
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('recentSearches')) {
      setState(() {
        hasPreviousSearches = true;
      });
      recentSearchesFromPrefs = prefs.getStringList('recentSearches')!;
    }
    recentSearchesFromPrefs.add(name);
    prefs.setStringList('recentSearches', recentSearchesFromPrefs);
    updateRecentSearches(currentUserTwo!, recentSearchesFromPrefs);
  }

  List<Widget> rightSearches(BuildContext context, List<dynamic> allPaths) {
    List<Widget> result = [
      SizedBox(
        height: 10,
      )
    ];
    for (var docSnapshot in allPaths) {
      result.add(Container(
          child: Card(
              margin: const EdgeInsets.all(3),
              color: Styles.deepgreen.withOpacity(0.7),
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: ListTile(
                  leading: const Icon(
                    Icons.hiking_outlined,
                    color: Colors.white,
                  ),
                  title: Text(
                    docSnapshot['pathName'],
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(docSnapshot['difficulty'],
                      style: TextStyle(color: Colors.white)),
                  trailing: const Icon(
                    Icons.keyboard_double_arrow_right_outlined,
                    color: Colors.white,
                  ),
                  onTap: () {
                    addToPreviousSearches(docSnapshot['pathName']);

                    MyNavigator(context).navigateToPathDetail(docSnapshot);
                  }))));
    }

    return result;
  }

  @override
  void initState() {
    getRandomHike(widget.duration, widget.difficulty, widget.mountainChain);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar("Path suggestions"),
      body: Container(
          child: SingleChildScrollView(
        child: Column(
          children: hasPaths
              ? rightSearches(context, pathsToShow)
              : [
                  SizedBox(height: 15),
                  Container(
                    alignment: Alignment.center,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "No paths match these parameters! Change the parameters and try again or try adding paths to our database!",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
        ),
      )),
    );
  }
}
