import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:bach_thes/models/peak.dart';
import 'dart:developer';
import 'package:bach_thes/globals.dart';
import 'package:bach_thes/main.dart';

//UI for landing page

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    log("in home page");
    readPeaks();
    log("after function call");

    return Scaffold(body: Center(child: Text("Hi")));
  }
}

Future<void> readPeaks() async {
  log("before await");
  await db.collection("Peaks").get().then((event) {
    log("before for loop");
    for (var doc in event.docs) {
      log("in for loop");
      log("${doc.id} => ${doc.data()}");
    }
    log("after for loop");
  });
}
