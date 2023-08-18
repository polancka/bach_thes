//TODO: figure out the date and time, figure out counting seconds and altimeters

import 'dart:async';
import 'dart:core';
import 'package:bach_thes/controllers/navigation_controller.dart';
import 'package:bach_thes/views/widgets/reusable_widgets.dart';
import 'package:background_location/background_location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bach_thes/utils/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:bach_thes/models/hiker.dart';
import 'package:latlong2/latlong.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:bach_thes/models/locationPoint.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart' as loc;
import 'package:bach_thes/controllers/badge_controller.dart' as bc;
import 'package:shared_preferences/shared_preferences.dart';

class RecordingPage extends StatefulWidget {
  const RecordingPage({super.key});

  @override
  State<RecordingPage> createState() => _RecordingPageState();
}

class _RecordingPageState extends State<RecordingPage>
    with WidgetsBindingObserver {
  Timer? _timer;
  Timer? _timerLocation;
  LocationPoint startingPosition = LocationPoint(latitude: 0, longitude: 0);
  bool _isRecording = false;
  List<Position> _locationPoints = [];
  String _timePassed = '00:00:00';
  double _altimetersDone = 0.0;
  double _distanceDone = 0.0;
  int secondsPassed = 0;
  Stopwatch _stopwatch = Stopwatch();
  CollectionReference _recordedHikesCollection =
      FirebaseFirestore.instance.collection('RHikes');
  var longitude = 0.0;
  var latitude = 0.0;
  Position? _currentPosition;
  LatLng currentMarker = LatLng(40.0, 12.0);
  MapController _mapController = MapController();
  String endPointRecording = "";
  List<String> itemsPeakNames = [];
  String currentUserId = FirebaseAuth.instance.currentUser!.uid.toString();
  LatLng endPointCoordinates = LatLng(0.0, 0.0);
  bool isPeakAchieved = false;
  AppLifecycleState? _notification;
  loc.Location _location = loc.Location();
  List<String> badges = [];
  String newChain = "";

  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  List<DateTime> _events = [];
  int _status = 0;
  var _endPointAltitude = 0;
  var currentAltitude = 0.0;
  loc.Location testLocation = loc.Location();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    setStartingPosition();
    //getCurrentPosition();
    _getAllPeaksNames();
    super.initState();
  }

  void setStartingPosition() {
    GeolocatorPlatform.instance
        .getCurrentPosition()
        .then((Position firstPosition) {
      setState(() {
        _locationPoints.add(firstPosition);
      });
      //print("THIS IS LOCATION POINTS IN STARTING POSITION: $_locationPoints");
    });
  }

  Future<Position> getCurrentPosition() async {
    //asks for permissions and stores current position into currentMarker variable
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

    Position currentPos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation,
        forceAndroidLocationManager: true);

    setState(() {
      currentMarker.latitude = currentPos.latitude;
      currentMarker.longitude = currentPos.longitude;
    });

    return currentPos;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    var appInBackground = (state == AppLifecycleState.inactive);
    if (appInBackground) {
      //print("in back");
      _startBackTracking();
      //application is running in bacground
      //show notification
    } else if (state == AppLifecycleState.resumed) {
      //print("resumed");
      _stopBackTracking();
    }
    //add fucntion to stop back tracking once the app is resumed
    //cancel the notification
  }

  _startBackTracking() async {
    //print("in startBackTrack");

    await BackgroundLocation.setAndroidNotification(
      title: 'Hike recording in process',
      message: 'Keep it up!',
      icon: '@mipmap/gore',
    );

    await BackgroundLocation.setAndroidConfiguration(1000);
    await BackgroundLocation.startLocationService(
        distanceFilter: 150, forceAndroidLocationManager: true);
    BackgroundLocation.getLocationUpdates((location) {
      //print("Location in background is : ${location.latitude}");
    });
  }

  _stopBackTracking() async {
    //figure it out for the background
    //print("stop back tracking");

    //Eraser.clearAllAppNotifications();

    //await BackgroundLocation.stopLocationService();
  }

  ///

  void _startFetchingLocationPeriodically() async {
    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 50,
    );

    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) async {
      // print("----new location-----");
      //print("CURRENT: ${position.latitude}, ${position.longitude}");
      //print("ENDPOINT: ${endPointCoordinates.latitude}, ${endPointCoordinates.longitude}");
      try {
        setState(() {
          if (_locationPoints.length > 1) {
            _distanceDone += GeolocatorPlatform.instance.distanceBetween(
                _locationPoints[_locationPoints.length - 1].latitude,
                _locationPoints[_locationPoints.length - 1].longitude,
                position!.latitude,
                position!.longitude);
            _altimetersDone +=
                (_locationPoints[_locationPoints.length - 1].altitude -
                        position.altitude)
                    .abs();
          } else {
            //print("The length of the list i 0 or 1");
          }
          _locationPoints.add(position!);
        });
        if (!isPeakAchieved) {
          //print("checking for peak .....");
          var distanceFromPeak = GeolocatorPlatform.instance.distanceBetween(
              _locationPoints.last.latitude,
              _locationPoints.last.longitude,
              endPointCoordinates.latitude,
              endPointCoordinates.longitude);
          if (distanceFromPeak < 150) {
            //print(_locationPoints.toString());
            setState(() {
              isPeakAchieved = true;
            });
          } else {
            //print("Peak is too far");
          }
        } else {
          //print("Peak has already been reached");
        }
      } catch (e) {
        // print("Error while fetching location: $e");
      }
    });
  }

  void _stopFetchingLocationPeriodically() {
    _timer?.cancel();
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
    String formattedDate = DateFormat('dd-MM-yyy HH:mm').format(DateTime.now());

    // Create a new document in Firestore with the recording details
    await _recordedHikesCollection.add({
      'hikerId': FirebaseAuth.instance.currentUser?.uid.toString(),
      'endPointName': endPointRecording,
      'endPointAltitude': _endPointAltitude,
      'acheived': isPeakAchieved,
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

  int calculatePoints(int seconds) {
    //hike must last more than 10minutes
    /* if (seconds < 300) {
      return 0;
    }*/ //TODO: uncomment after testing!
    var pointsToAdd = 10; //10 points for recording a hike
    pointsToAdd = pointsToAdd +
        (_altimetersDone.floor() ~/ 100) *
            2; // 2 points for every 100 altimeters
    pointsToAdd = pointsToAdd +
        (seconds ~/ 1800) * 5; // 5 points for every half hour of hiking

    return pointsToAdd;
  }

  void startLocationTracking() async {
    setState(() {
      _isRecording = true;
    });
    _stopwatch.start();
    _startTimer();
    _startFetchingLocationPeriodically();
  }

  void stopLocationTracking() {
    //await BackgroundFetch.stop();
    _stopwatch.stop();
    _stopTimer();
    _stopFetchingLocationPeriodically();
    _saveRecording(_locationPoints);
    updateNumberOfHikes(currentUserId);
    updateTimeHiking(currentUserId, _stopwatch.elapsed.inMinutes);
    updateNumberOfAltimeters(currentUserId, _altimetersDone);
    updateDistanceTogheter(currentUserId, _distanceDone);
    if (isPeakAchieved) {
      updateMountainChain(currentUserId, newChain);
    }
    functionForBadges(currentUserId);
    setState(() {
      //TODO: uncomment
      //fix this! wrong type
      secondsPassed = _stopwatch.elapsed.inSeconds;
      _isRecording = false;
      _stopwatch.reset();
      _locationPoints.clear();
    });

    var points = calculatePoints(secondsPassed);

    //go to pointAlert page!
    MyNavigator(context)
        .navigateToPointsPage("recording a hike", points, badges);
  }

  functionForBadges(String userID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      badges = prefs.getStringList('badges')!;
      //this gets you the badges [ t f f t f f ], but you need the list of strings that has names of the new badges!
    });
    print("FUNCTION FOR BADGES $badges");
  }

  LatLng locationPointToLatLng(LocationPoint point) {
    LatLng latLngPoint = LatLng(point.latitude, point.longitude);
    return latLngPoint;
  }

  _getAllPeaksNames() async {
    List<String> peakNames = [];
    await FirebaseFirestore.instance.collection("Peaks").get().then((event) {
      if (!_isRecording) {
        for (var doc in event.docs) {
          peakNames.add(doc['name'].toString());
        }
        setState(() {
          itemsPeakNames = peakNames;
        });
        //print(peakNames);
      } else {
        setState(() {
          itemsPeakNames = [];
        });
      }
    });
  }

  _getPeakCoordinatesAndChain(String? name) async {
    await FirebaseFirestore.instance
        .collection("Peaks")
        .where('name', isEqualTo: name)
        .get()
        .then((doc) {
      setState(() {
        endPointCoordinates.latitude = doc.docs.first['latitude'];
        endPointCoordinates.longitude = doc.docs.first['longitude'];
        _endPointAltitude = doc.docs.first['altitude'];
        newChain = doc.docs.first['mountainChain'];
      });
      //print(endPointCoordinates.latitude);
    });
  }

  _getThatValue(String? value) {
    setState(() {
      endPointRecording = value!;
    });
    _getPeakCoordinatesAndChain(value);
    //print(value);
  }

  @override
  void dispose() {
    setState(() {
      isPeakAchieved = false;
    });
    //BackgroundLocation.stopLocationService();
    _timer!.cancel();
    _timerLocation!.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var kmsToShow = _distanceDone / 1000;
    //print(kmsToShow);
    //print("IN BUILD: ${currentMarker.latitude}");
    return Scaffold(
        appBar: myAppBar("Hike recording"),
        body: Container(
            decoration: BoxDecoration(color: Colors.white),
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 15),
                    Center(child: Text("Where are we hiking to?")),
                    Padding(
                        padding: EdgeInsets.all(20),
                        child: DropdownSearch<String>(
                          mode: Mode.MENU,
                          items: itemsPeakNames,
                          onChanged: (value) => _getThatValue(value),
                          showSearchBox: true,
                          searchFieldProps:
                              TextFieldProps(cursorColor: Colors.green),
                        )),
                    SizedBox(height: 25),
                    SizedBox(height: 15),
                    Container(child: _isRecording ? myMapTwo() : Text("")),
                    Text("Time spent hiking: $_timePassed"),
                    Text("Distance hiked: ${kmsToShow} km"),
                    Text(
                        "Altimeters done: ${_altimetersDone.toString().substring(0, _altimetersDone.toString().indexOf('.') + 2)} m"),
                    SizedBox(height: 25),
                    Container(
                        child: isPeakAchieved
                            ? Text(
                                "Congratulations! You have reached $endPointRecording! \n When you stop the recording, $endPointRecording will be added to your booklet.",
                                textAlign: TextAlign.center,
                              )
                            : Text("While recording do not exit this window!")),
                    SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => Styles.deepgreen)),
                      onPressed: () {
                        _isRecording
                            ? setState(() {
                                _isRecording = false;
                                stopLocationTracking();
                              })
                            : setState(() {
                                _isRecording = true;
                                startLocationTracking();
                              });
                      },
                      child: _isRecording
                          ? Text("Stop recording",
                              style: TextStyle(color: Colors.white))
                          : Text("Start recording",
                              style: TextStyle(color: Colors.white)),
                    ),
                  ]),
            )));
  }

  Widget myMapTwo() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 250,
        child: FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            center: LatLng(
                _locationPoints.last.latitude, _locationPoints.last.longitude),
            zoom: 13.0,
          ),
          children: [
            TileLayer(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: LatLng(_locationPoints.last.latitude,
                      _locationPoints.last.longitude),
                  builder: (ctx) => Icon(
                    Icons.location_on_outlined,
                    color: Colors.black,
                    semanticLabel: "Current location",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
