import 'dart:ffi';

import 'package:bach_thes/models/path.dart';
import 'package:bach_thes/models/place.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Peak {
  final int id;
  final String name;
  final int altitude;
  final String description;
  final List<Path> possiblePaths;
  final String urlThumbnail;

  Peak({
    required this.id,
    required this.name,
    required this.altitude,
    required this.description,
    required this.possiblePaths,
    required this.urlThumbnail,
  });

  var db = FirebaseFirestore.instance;

  addNewPeak() {}

  Future<String> fetchPeaks() async {
    await db.collection("peaks").get().then((event) {
      for (var doc in event.docs) {
        print("${doc.id} => ${doc.data()}");
      }
    });
    return "Hello";
  }
}
