import 'package:bach_thes/models/hiker.dart';
import 'package:bach_thes/utils/styles.dart';
import 'package:bach_thes/views/widgets/reusable_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bach_thes/globals.dart';

class settingsPage extends StatefulWidget {
  const settingsPage({super.key});

  @override
  State<settingsPage> createState() => _settingsPageState();
}

class _settingsPageState extends State<settingsPage> {
  //get users scoreboardParticipation
  getUserParticipation() async {
    var participantID = FirebaseAuth.instance.currentUser?.uid.toString();
    var isUserParticipating = await FirebaseFirestore.instance
        .collection('Hikers')
        .where('id', isEqualTo: participantID)
        .get();
    //var whatever = isUserParticipating.docs['id'];
  }

  changeUserParticipation() {}

  bool switchOn = false;
  @override
  void initState() {
    super.initState();
    String isParticipating = currentHiker.getParticipation();
    if (isParticipating == "true") {
      switchOn = true;
    } else {
      switchOn = false;
    }
  }

  @override
  Widget build(BuildContext context) {
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
                          changeParticipation(switchOn, currentHiker);
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
