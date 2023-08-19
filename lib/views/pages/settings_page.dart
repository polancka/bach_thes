import 'package:bach_thes/models/hiker.dart';
import 'package:bach_thes/utils/styles.dart';
import 'package:bach_thes/views/widgets/reusable_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//This page is UI for the Settings. In the settings user can choose if they
// want to participate in the Scoreboard challenge.

class settingsPage extends StatefulWidget {
  const settingsPage({super.key});

  @override
  State<settingsPage> createState() => _settingsPageState();
}

class _settingsPageState extends State<settingsPage> {
  var isParticipating;

  changeParticipationToPrefs(bool participation) async {
    //change shared prefs
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('scoreboardParticipation', participation);
    //change into database
    setState(() {
      isParticipating = prefs.getBool('scoreboardParticipation');
    });
    changeParticipation(participation, prefs.getString('id') ?? "");
  }

  getParticipationFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await FirebaseFirestore.instance
        .collection('Hikers')
        .where('id', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) => changeParticipationToPrefs(
            value.docs.first['scoreboardParticipation']));
  }

  bool switchOn = false;

  @override
  void initState() {
    getParticipationFromPrefs();
    if (isParticipating == true) {
      switchOn = true;
    } else {
      switchOn = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isParticipating == true) {
      switchOn = true;
    } else {
      switchOn = false;
    }

    return Scaffold(
      appBar: myAppBar("Settings"),
      body: Padding(
          padding: EdgeInsets.all(20),
          child: Container(
              decoration: BoxDecoration(
                  //border: Border(bottom: BorderSide(color: Colors.green)),
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      child: Text("Participating in the scoreboard challenge")),
                  Container(
                    child: Switch(
                      value: switchOn,
                      activeColor: Styles.deepgreen,
                      onChanged: (value) {
                        setState(() {
                          switchOn = value;
                          isParticipating = value;
                          changeParticipationToPrefs(switchOn);
                        });
                      },
                      activeTrackColor: Color.fromARGB(255, 92, 188, 97),
                    ),
                  )
                ],
              ))),
    );
  }
}
