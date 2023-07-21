import 'dart:ffi';

import 'package:bach_thes/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Hiker {
  final String id;
  final String username;
  final String email;
  final String profilePicture;
  final int level;
  final int points;
  final String scoreboardParticipation;
  final int numberOfHikes;
  final int timeTogheter;
  final int altimetersTogheter;
  Hiker(
      {required this.id,
      required this.username,
      required this.email,
      required this.profilePicture,
      required this.level,
      required this.points,
      required this.scoreboardParticipation,
      required this.numberOfHikes,
      required this.timeTogheter,
      required this.altimetersTogheter});

  String getParticipation() {
    return this.scoreboardParticipation;
  }
}

changeParticipation(bool isParticipating, String id) async {
  var wantedDocuments = await FirebaseFirestore.instance
      .collection('Hikers')
      .where('id', isEqualTo: id)
      .get();
  var docRef = wantedDocuments.docs.first.id;

  final docRefUpdate = db.collection('Hikers').doc("${docRef}");
  docRefUpdate.update({"scoreboardParticipation": isParticipating}).then(
      (value) => print("DocumentSnapshot successfully updated!"),
      onError: (e) => print("Error updating document $e"));
}

Future<DocumentReference> addHiker(String email, String username, String? userId
    //String profilePicture in the beggining use a default photo
    ) async {
  var newUSerRef = await db.collection("Hikers").add({
    'id': userId,
    'username': username,
    'email': email,
    'pictureUrl':
        "https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/User-avatar.svg/2048px-User-avatar.svg.png",
    'level': 1,
    'points': 0,
    'bookletId': userId,
    'scoreboardParticipation': false,
    'achievedPeaks': [],
    'numberOfHikes': 0,
    'timeTogheter': 0,
    'altimetersTogheter': 0
  });

  //add reference number for the booklet

  return newUSerRef;
}
