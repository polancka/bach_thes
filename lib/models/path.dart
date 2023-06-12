import 'package:bach_thes/models/place.dart';

class Path {
  final int id;
  final String startingPointName;
  final String endPointName;
  final int startingPointId;
  final int finishPointId;
  final int startingPointAltitude;
  final int finishPointAltitude;
  final int alitmeters;
  final String difficulty;
  final String duration;
  final String description;
  Path(
      {required this.id,
      required this.startingPointName,
      required this.endPointName,
      required this.startingPointId,
      required this.finishPointId,
      required this.startingPointAltitude,
      required this.finishPointAltitude,
      required this.alitmeters,
      required this.difficulty,
      required this.duration,
      required this.description});
}
