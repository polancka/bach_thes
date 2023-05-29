import 'package:bach_thes/models/path.dart';
import 'package:bach_thes/models/place.dart';

class Peak extends Place {
  final String name;
  final List<Path> possiblePaths;
  final String mountainRange;
  final String urlThumbnail;
  Peak(
      {required super.latitude,
      required super.longitude,
      required super.altitude,
      required super.id,
      required super.isPeak,
      required this.name,
      required super.description,
      required super.region,
      required this.possiblePaths,
      required this.mountainRange,
      required this.urlThumbnail});
}
