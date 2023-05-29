class Place {
  final String latitude;
  final String longitude;
  final int altitude;
  final int id;
  final bool isPeak;
  final String description;
  final String region;
  Place(
      {required this.latitude,
      required this.longitude,
      required this.altitude,
      required this.id,
      required this.isPeak,
      required this.description,
      required this.region});
}
