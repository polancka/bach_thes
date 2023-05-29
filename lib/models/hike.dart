import 'package:bach_thes/models/path.dart';
import 'package:bach_thes/models/peak.dart';
import 'package:bach_thes/models/place.dart';

class Hike {
  final int id;
  final Path pathTaken;
  final Peak finalPeak;
  final List<Place> checkInPoints;
  final DateTime dateAndTime;
  final String duration;
  final int altimeters;
  Hike(
      {required this.id,
      required this.pathTaken,
      required this.finalPeak,
      required this.checkInPoints,
      required this.dateAndTime,
      required this.duration,
      required this.altimeters});
}
