import 'package:bach_thes/models/path.dart';
import 'package:bach_thes/models/peak.dart';
import 'package:bach_thes/models/place.dart';
import 'package:bach_thes/globals.dart';

class Hike {
  final String id;
  final dateAndTime;
  final int duration;
  final int altimeters;
  final String endPointName;
  Hike(
      {required this.id,
      required this.dateAndTime,
      required this.duration,
      required this.altimeters,
      required this.endPointName});
}

Future<void> addNewRecordedHike(String id, DateTime dateAndTime,
    int durationInSeconds, int altimeters, String endPointName) async {
  await db.collection("RecordedHikes").add({
    'hikerId': id,
    'dateAndTime': dateAndTime,
    'duration': durationInSeconds,
    'altimeters': altimeters,
    'endPointName': endPointName,
  });
}
