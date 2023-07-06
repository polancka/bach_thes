import 'dart:math';

import 'package:bach_thes/models/hiker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';

/* This is where global variables are stored */
final db = FirebaseFirestore.instance;

int nextUserId = 1;

incrementNextUserId() {
  nextUserId = nextUserId + 1;
}

incrementPeakIndex(int? currentIndex) async {
  int nextIndex = currentIndex! + 1;
  var wantedDocuments =
      await FirebaseFirestore.instance.collection('Indexes').get();
  var _docRef = wantedDocuments.docs.first.id;

  final docRefUpdate = db.collection('Indexes').doc("${_docRef}");
  docRefUpdate.update({"peakIndex": nextIndex}).then((value) {},
      onError: (e) => print("Error updating document $e"));
}

late Hiker currentHiker;
