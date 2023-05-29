import 'package:bach_thes/models/path.dart';
import 'package:bach_thes/models/peak.dart';
import 'package:bach_thes/models/badge.dart';

class Booklet {
  final String id;
  final String userId;
  final List<Peak> achievedPeaks;
  final List<Path> achievedPaths;
  final List<Badge> badges;
  Booklet(
      {required this.id,
      required this.userId,
      required this.achievedPeaks,
      required this.achievedPaths,
      required this.badges});
}
