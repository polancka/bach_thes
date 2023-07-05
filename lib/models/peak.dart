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
  final String longitude;
  final String latitude;
  final String mountainChain;

  Peak(
      {required this.id,
      required this.name,
      required this.altitude,
      required this.description,
      required this.possiblePaths,
      required this.urlThumbnail,
      required this.longitude,
      required this.latitude,
      required this.mountainChain});

  var db = FirebaseFirestore.instance;
}

Future<String> fetchPeaks() async {
  await FirebaseFirestore.instance.collection("Peaks").get().then((event) {
    for (var doc in event.docs) {
      print("${doc.id} => ${doc.data()}");
    }
  });
  return "Hello";
}

Future<void> addNewPeak(
    int _id,
    String _name,
    int _altitude,
    String _description,
    String _urlThumbnail,
    String _longitude,
    String _latitude,
    String _mountainChain) async {
  await FirebaseFirestore.instance.collection("Peaks").add({
    'id': _id,
    'name': _name,
    'altitude': _altitude,
    'description': _description,
    'urlThumbnail': _urlThumbnail,
    'longitude': _longitude,
    'latitude': _latitude,
    'mountainChain': _mountainChain
  });
}
