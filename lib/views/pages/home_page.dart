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
    uploadingData(
        1,
        "Grintovec",
        2558,
        "Grintovec je najvišji vrh Kamniških in Savinjskih Alp. Nahaja se nad dolino Kamniške Bistrice, Suhega dola in nad dolino Ravenske Kočne. Razgled z vrha je najlepši proti Jezerski in Kokrski Kočni na zahodni strani, na severu se lepo vidi Jezerska dolina in vrhovi nad Jezerskim proti vzhodu pa se vidi greben Grintovcev od Dolgega Hrbta, čez Štruco do Skute. Proti jugu pa se vidi Kalški greben in v ozadju Ljubljanska kotlina. Vrh ima vpisno knjigo in žig.",
        "https://www.hribi.net/Gora/p6250106medium5xm.jpg");
    uploadingData(
        2,
        "Skuta",
        2532,
        "Skuta je 2532 m visoka gora, ki se nahaja v osrčju Kamniško Savinjskih Alp. Z vrha, na katerem je vpisna skrinjica in žig, se nam odpre lep razgled na najvišje vrhove Kamniško Savinjskih Alp.",
        "https://www.hribi.net/slike11/P106066849386308.jpg");
    uploadingData(
        3,
        "Ojstrica",
        2350,
        "Ojstrica, katera ime je dobila po svoji ostri obliki, se strmo dviga nad Korošico, Logarsko dolino in Robanovim kotom. Z vrha, na katerem se nahaja vpisna skrinjica z žigom, se nam odpre lep razgled na najvišje vrhove Kamniško Savinjskih Alp.",
        "https://www.hribi.net/slike1/Ojstrica%20036102960.jpg");
    //readPeaks();
    log("after function call");

    return Scaffold(body: Center(child: Text("Hi")));
  }
}

Future<void> readPeaks() async {
  await db.collection("Peaks").get().then((event) {
    for (var doc in event.docs) {
      log("${doc.id} => ${doc.data()}");
    }
  });
}

//function for adding to the database
Future<void> uploadingData(
  int _peakId,
  String _peakName,
  int _peakAltitude,
  String _peakDescription,
  String _urlThumbnail,
) async {
  await db.collection("Peaks").add({
    'id': _peakId,
    'name': _peakName,
    'altitude': _peakAltitude,
    'description': _peakDescription,
    'urlThumbnail': _urlThumbnail,
  });
}
