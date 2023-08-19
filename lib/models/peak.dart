import 'package:cloud_firestore/cloud_firestore.dart';

//This class stores information about each peak. The data is gathered from Firebase Firestore database
//collection 'Peaks'. It also includes function for adding a new peak to the database.

class Peak {
  final int id;
  final String name;
  final int altitude;
  final String description;
  final String urlThumbnail;
  final double longitude;
  final double latitude;
  final String mountainChain;
  final String sortValue;

  Peak(
      {required this.id,
      required this.name,
      required this.altitude,
      required this.description,
      required this.urlThumbnail,
      required this.longitude,
      required this.latitude,
      required this.mountainChain,
      required this.sortValue});

  var db = FirebaseFirestore.instance;
}

Future<void> addNewPeak(
    int? _id,
    String _name,
    int _altitude,
    String _description,
    String _urlThumbnail,
    double _longitude,
    double _latitude,
    String _mountainChain,
    String _sortValue) async {
  await FirebaseFirestore.instance.collection("Peaks").add({
    'id': _id,
    'name': _name,
    'altitude': _altitude,
    'description': _description,
    'urlThumbnail': _urlThumbnail,
    'longitude': _longitude,
    'latitude': _latitude,
    'mountainChain': _mountainChain,
    'sortValue': _sortValue
  });
}
