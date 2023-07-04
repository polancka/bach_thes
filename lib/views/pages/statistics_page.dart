import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../utils/styles.dart';

//This page shows user statistics - how many hikes they have recorded, how many peaks they have achieved
//and scoreboard

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  //getting hikers for scoreboard from database

  List _scoreboardHikers = [];

  getScoreboardHikers() async {
    var _listOfScoreboardHikers = await FirebaseFirestore.instance
        .collection('Hikers')
        .where('scoreboardParticipation', isEqualTo: true)
        .orderBy('points', descending: true)
        .limit(10)
        .get();

    setState(() {
      _scoreboardHikers = List.from(_listOfScoreboardHikers.docs);
      print(_scoreboardHikers);
    });

    return "complete";
  }

  @override
  void initState() {
    super.initState();
    getScoreboardHikers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      SizedBox(
        height: 10,
      ),
      Container(
          child: Center(
              child: Text(
        "Scoreboard - top 10 hikers",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ))),
      //list of hikers
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
                  children: renderTopHikers(_scoreboardHikers),
                )),
          ),
        ),
      )
    ]));
  }
}

List<Widget> renderTopHikers(List<dynamic> listOfHikes) {
  var index = 1;
  List<Widget> latestHikes = List<Widget>.empty(growable: true);
  for (var docSnapshot in listOfHikes) {
    //print(docSnapshot.toString());
    latestHikes.add(listItemTopHiker(docSnapshot, index));
    index = index + 1;
  }

  return latestHikes;
}

Widget listItemTopHiker(dynamic docSnapshot, int index) {
  return Container(
      child: Card(
    color: Styles.deepgreen.withOpacity(0.7),
    shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(20)),
    child: ListTile(
        leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("${index}.",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ]),
        title: Text(
          "${docSnapshot['username']}",
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Text("Points: ${docSnapshot['points']}",
            style: TextStyle(color: Colors.white)),
        onTap: () => () {}),
  ));
}
