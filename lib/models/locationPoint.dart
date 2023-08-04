class LocationPoint {
  double latitude;
  double longitude;

  LocationPoint({required this.latitude, required this.longitude});

  LocationPoint.fromJson(Map<String, dynamic> json)
      : longitude = json['longitude'],
        latitude = json['latitude'];

  latSetter(double lat) {
    this.latitude = lat;
  }

  lonSetter(double lon) {
    this.longitude = lon;
  }

  // Optional: Create a factory method to convert from a Map
}
