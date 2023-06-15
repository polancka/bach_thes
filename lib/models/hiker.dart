import 'package:bach_thes/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class User {
  final int id;
  final String username;
  final String email;
  final String profilePicture;
  final int level;
  final int points;
  final int bookletId;
  final bool scoreboardParticipation;
  User(
      {required this.id,
      required this.username,
      required this.email,
      required this.profilePicture,
      required this.level,
      required this.points,
      required this.bookletId,
      required this.scoreboardParticipation});
}

Future<DocumentReference> addHiker(
  String email,
  String username,
  //String profilePicture in the beggining use a default photo
) async {
  var newUSerRef = await db.collection("Hikers").add({
    'username': username,
    'email': email,
    'pictureUrl':
        "https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/User-avatar.svg/2048px-User-avatar.svg.png",
    'level': 1,
    'points': 0,
    'bookletId': 0,
    'scoreboardParticipation': false
  });

  //add reference number for the booklet

  return newUSerRef;
}
