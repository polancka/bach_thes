import 'package:bach_thes/utils/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:bach_thes/models/locationPoint.dart';
import '../widgets/reusable_widgets.dart';

//This page provides more detail on the hike recording.
//It provides some basic statistics and map of the path.

class RecordingDetailPage extends StatefulWidget {
  DocumentSnapshot docSnapshot;
  RecordingDetailPage({required this.docSnapshot});

  @override
  State<RecordingDetailPage> createState() => _RecordingDetailPageState();
}

class _RecordingDetailPageState extends State<RecordingDetailPage> {
  List<LatLng> _locPoints = [];

  List<LatLng> toLocationList() {
    List<dynamic> wholeString = widget.docSnapshot['locationPoints'];

    List<LocationPoint> finalPoints = <LocationPoint>[];
    wholeString.forEach((element) {
      finalPoints.add(LocationPoint.fromJson(element));
    });

    List<LatLng> latLngList = finalPoints.map((locationPoint) {
      return LatLng(locationPoint.latitude, locationPoint.longitude);
    }).toList();

    setState(() {
      _locPoints = latLngList;
    });

    return latLngList;
  }

  @override
  void initState() {
    toLocationList();
    super.initState();
  }

  Widget myMap(List<LatLng> points) {
    MapController _mapController = MapController();
    _mapController.mapEventStream.listen((event) {
      if (_mapController.zoom >= 12) {
        setState(() {});
      }
    });
    if (points.isEmpty) {
      return Text('No location points found for this hike.');
    }

    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        pinchMoveThreshold: 0.3,
        center: points.first,
        zoom: 10.0,
      ),
      children: [
        TileLayer(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c'],
        ),
        PolylineLayer(
          polylines: [
            Polyline(
              points: points,
              color: Colors.blue,
              strokeWidth: 3.0,
            ),
          ],
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: points.last,
              builder: (ctx) => const Icon(
                Icons.location_on_outlined,
                color: Colors.black,
                semanticLabel: "Finish",
              ),
            ),
            Marker(
              point: points.first,
              builder: (ctx) => const Icon(
                Icons.location_on_outlined,
                color: Colors.black,
                semanticLabel: "Start",
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var kms = widget.docSnapshot['totalDistanceInMeters'] / 1000;
    String metersDetail = kms.toString();
    String meters = metersDetail.substring(0, metersDetail.indexOf('.') + 2);
    var _altimeters = widget.docSnapshot['altimeters'].toString();
    String _altTruncated =
        _altimeters.substring(0, _altimeters.indexOf('.') + 2);

    return Scaffold(
        appBar: myAppBar(
            "Hike to ${widget.docSnapshot['endPointName'].toString()}"),
        body: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: Styles.offwhite,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const Text("Hike statistics",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          Text(widget.docSnapshot['dateAndTime'].toString(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600)),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                              height: 300,
                              alignment: Alignment.center,
                              child: myMap(_locPoints)),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                              "Hike lasted for: ${widget.docSnapshot['duration'].toString()}",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
                          const SizedBox(
                            height: 5,
                          ),
                          Text("Distance: ${meters}km ",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
                          const SizedBox(
                            height: 5,
                          ),
                          Text("Altimeters: ${_altTruncated}m",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      )),
                ),
              ),
            )
          ],
        ));
  }
}
