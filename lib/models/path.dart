import 'package:bach_thes/models/place.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//finish point Peak could be added additionally
//all attributes are String so that they can be estracted from Firebase more easily

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
  final String duration;
  final String description;
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
      required this.description});
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
  String duration,
  String description,
) async {
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
  });
}
