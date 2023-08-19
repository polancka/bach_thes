import 'package:cloud_firestore/cloud_firestore.dart';

//This class stores information about each path. The data is gathered from Firebase Firestore database
//collection 'Paths'. It also includes function for adding a new path to the database.
class Path {
  final int id;
  final String pathName;
  final String startingPointName;
  final int startingPointId;
  final String startingPointAltitude;
  final String finishPointName;
  final int altimeters;
  final int altimetersOnTheWay;
  final String difficulty;
  final int duration;
  final String description;
  final String mountainChain;
  Path(
      {required this.id,
      required this.pathName,
      required this.startingPointName,
      required this.startingPointId,
      required this.startingPointAltitude,
      required this.finishPointName,
      required this.altimeters,
      required this.altimetersOnTheWay,
      required this.difficulty,
      required this.duration,
      required this.description,
      required this.mountainChain});
}

Future<void> addNewPath(
    int id,
    String pathName,
    String startingPointName,
    int startingPointId,
    int startingPointAltitude,
    String finishPointName,
    int altimeters,
    int altimetersOnTheWay,
    String difficulty,
    int duration,
    String description,
    String mountainChain) async {
  await FirebaseFirestore.instance.collection("Paths").add({
    'id': id,
    'pathName': pathName,
    'startingPointName': startingPointName,
    'startingPointId': startingPointId,
    'startingPointAltitude': startingPointAltitude,
    'finishPointName': finishPointName,
    'altimeters': altimeters,
    'altimetersOnTheWay': altimetersOnTheWay,
    'difficulty': difficulty,
    'duration': duration,
    'description': description,
    'mountainChain': mountainChain,
  });
}
