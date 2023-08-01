//TODO: figure out the date and time, figure out counting seconds and altimeters
//TODO: why is location wrong, locking the textfield after "start recording"
//tracking geopoints and saving them?
import 'dart:async';
import 'dart:core';
import 'package:bach_thes/views/widgets/reusable_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bach_thes/utils/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:background_location/background_location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

class RecordingPage extends StatefulWidget {
  const RecordingPage({super.key});

  @override
  State<RecordingPage> createState() => _RecordingPageState();
}

class _RecordingPageState extends State<RecordingPage> {
  Timer? _timer;
  Timer? _timertwo;
  bool _isRecording = false;
  List<Position> _locationPoints = [];
  String _timePassed = '00:00:00';
  double _altimetersDone = 0.0;
  double _distanceDone = 0.0;
  Stopwatch _stopwatch = Stopwatch();
  //FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  //FlutterLocalNotificationsPlugin();
  CollectionReference _recordedHikesCollection =
      FirebaseFirestore.instance.collection('RecordedHikesTwo');
  var longitude = 0.0;
  var latitude = 0.0;
  Position? _currentPosition;

  //when u input name, lock the field, or have a dropdown menu to choose from all peaks
  TextEditingController endPointNameController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _startFetchingLocationPeriodically() {
    // Start fetching location every 10 seconds
    //when using on an acutal phone switch to
    /**final LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
          );
      StreamSubscription<Position> positionStream = Geolocator.getPositionStream(locationSettings: locationSettings).listen(
      (Position? position) {
        print(position == null ? 'Unknown' : '${position.latitude.toString()}, ${position.longitude.toString()}');
      }); */
    _timertwo = Timer.periodic(Duration(seconds: 10), (timer) {
      _getCurrentLocation();
    });
  }

  void _stopFetchingLocationPeriodically() {
    _timer?.cancel();
  }

  void _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition();

      setState(() {
        _locationPoints.add(position);
        _distanceDone += Geolocator.distanceBetween(
                _locationPoints[_locationPoints.length - 1].latitude,
                _locationPoints[_locationPoints.length - 1].longitude,
                position.latitude,
                position.longitude) ??
            0.0;
        _altimetersDone +=
            (_locationPoints[_locationPoints.length - 1].altitude -
                        position.altitude)
                    .abs() ??
                0.0;
      });
    } catch (e) {
      print("Error while fetching location: $e");
    }
  }

  Future<Position> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      setState(() {
        _timePassed = getFormattedTime();
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timertwo?.cancel();
  }

  String getFormattedTime() {
    int milliseconds = _stopwatch.elapsedMilliseconds;
    int seconds = (milliseconds / 1000).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    String formattedTime =
        '${hours.toString().padLeft(2, '0')}:${(minutes % 60).toString().padLeft(2, '0')}:${(seconds % 60).toString().padLeft(2, '0')}';

    return formattedTime;
  }

  void _saveRecording(List<Position> locationPoints) async {
    String formattedTime = getFormattedTime();
    String formattedDate =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    // Create a new document in Firestore with the recording details
    await _recordedHikesCollection.add({
      'hikerId': FirebaseAuth.instance.currentUser?.uid.toString(),
      'endPointName': "Test name",
      'duration': _timePassed,
      'totalDistanceInMeters': _distanceDone,
      'altimeters': _altimetersDone,
      'dateAndTime': formattedDate,
      'locationPoints': _locationPoints
          .map((point) => {
                'latitude': point.latitude,
                'longitude': point.longitude,
              })
          .toList(),
    });
  }

  void startLocationTracking() async {
    //var status = await BackgroundFetch.start();
    // if (status == BackgroundFetch.STATUS_AVAILABLE) {
    _stopwatch.start();
    _startTimer();
    Position firstPosition = await getCurrentPosition();
    _locationPoints.add(firstPosition);
    _startFetchingLocationPeriodically();
    setState(() {
      _isRecording = true;
    });
  }

  void stopLocationTracking() {
    //await BackgroundFetch.stop();
    _stopwatch.stop();
    _stopTimer();
    _stopFetchingLocationPeriodically();
    setState(() {
      _isRecording = false;
      _stopwatch.reset();
      _locationPoints.clear();
    });
    _saveRecording(_locationPoints);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar("Hike recording"),
        body: Container(
          decoration: BoxDecoration(color: Colors.white),
          width: MediaQuery.of(context).size.width,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child: Text("Where are we hiking to?")),
                Padding(
                    padding: EdgeInsets.all(20),
                    child: TextField(controller: endPointNameController)),
                SizedBox(height: 25),
                Container(
                    child: _isRecording
                        ? Image.asset("lib/utils/images/Hiker.gif",
                            height: 125.0, width: 125)
                        : Text("")),
                Text(_timePassed),
                Text("Altimeters done: ${_altimetersDone}"),
                SizedBox(
                  height: 40,
                ),
                TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Styles.deepgreen)),
                  onPressed: () {
                    _isRecording
                        ? stopLocationTracking()
                        : startLocationTracking();
                  },
                  child: _isRecording
                      ? Text("Stop recording",
                          style: TextStyle(color: Colors.white))
                      : Text("Start recording",
                          style: TextStyle(color: Colors.white)),
                ),
              ]),
        ));
  }
}
