import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bach_thes/views/widgets/reusable_widgets.dart';
import 'package:geolocator/geolocator.dart';
import '../../utils/styles.dart';
//THIS IS WHERE ALL THE USERS RECORDINGS ARE SHOWN

class AllRecordingsPage extends StatefulWidget {
  const AllRecordingsPage({super.key});

  @override
  State<AllRecordingsPage> createState() => _AllRecordingsPageState();
}

class _AllRecordingsPageState extends State<AllRecordingsPage> {
  var currentUserID = FirebaseAuth.instance.currentUser!.uid;
  var myRecordedHikes = [];
  List<dynamic> _geoPoints = [];
  bool _hasHikes = false;

  getMyHikes() async {
    var recordedHikesQuery = await FirebaseFirestore.instance
        .collection('RHikes')
        .where('hikerId', isEqualTo: currentUserID)
        .orderBy('dateAndTime', descending: true)
        .get();
    setState(() {
      myRecordedHikes = List.from(recordedHikesQuery.docs);
      if (myRecordedHikes.isNotEmpty) {
        _hasHikes = true;
      }
    });
  }

  List<Widget> renderMyHikes(List<dynamic> listOfHikes) {
    List<Widget> latestHikes = List<Widget>.empty(growable: true);
    for (var docSnapshot in listOfHikes) {
      //print(docSnapshot.toString());
      latestHikes.add(listItemHike(docSnapshot, context));
    }

    return latestHikes;
  }

  @override
  void initState() {
    getMyHikes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar("My hike recordings"),
        body: Container(
            child: SingleChildScrollView(
                child: Column(
          children: [
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
                        children: _hasHikes
                            ? renderMyHikes(myRecordedHikes)
                            : [
                                Text(
                                  "No recorded hikes yet! \n Record some hikes and come back :) ",
                                  textAlign: TextAlign.center,
                                )
                              ],
                      )),
                ),
              ),
            )
          ],
        ))));
  }
}
