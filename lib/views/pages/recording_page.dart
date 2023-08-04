//TODO: figure out the date and time, figure out counting seconds and altimeters
//TODO: why is location wrong, locking the textfield after "start recording"
//tracking geopoints and saving them?
import 'dart:async';
import 'dart:core';
import 'package:bach_thes/controllers/navigation_controller.dart';
import 'package:bach_thes/models/localNotificationService.dart';
import 'package:bach_thes/views/widgets/reusable_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bach_thes/utils/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:background_location/background_location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:bach_thes/models/hiker.dart';
import 'package:latlong2/latlong.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:bach_thes/models/locationPoint.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart' as locpack;
import 'package:bach_thes/controllers/badge_controller.dart' as bc;

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
  locpack.Location _location = locpack.Location();
  List<String> badges = [];

  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  List<DateTime> _events = [];
  int _status = 0;

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    getStartingPosition();
    _getAllPeaksNames();
    super.initState();
  }

  /* Future<void> _onFetch(String taskId) async {
    if (_isRecording) {
      Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation);

      if (currentPosition != null) {
        setState(() {
          _totalDistanceInMeters += currentPosition.speed ?? 0.0;
          _totalAltitudeInMeters += currentPosition.altitude ?? 0.0;
          _showNotification(
              currentPosition.latitude, currentPosition.longitude);
        });
      }
    }
  }*/

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    var appInBackground = (state == AppLifecycleState.inactive);
    if (appInBackground) {
      print("in back");
      _startBackTracking();
      //application is running in bacground
      //show notification
    }
    //add fucntion to stop back tracking once the app is resumed
    //cancel the notification
  }

  _startBackTracking() async {
    /* print("in startBackTrack");

    await BackgroundLocation.setAndroidNotification(
      title: 'Background service is running',
      message: 'Background location in progress',
      icon: '@mipmap/ic_launcher',
    );
    await BackgroundLocation.setAndroidConfiguration(1000);
    await BackgroundLocation.startLocationService(
        distanceFilter: 20, forceAndroidLocationManager: true);
    BackgroundLocation.getLocationUpdates((location) {
      print("Location in background is : ${location.latitude}");
    });*/
  }

  _stopBackTracking() {
    BackgroundLocation.stopLocationService();
  }

  ///

  getStartingPosition() async {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.bestForNavigation,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        currentMarker.latitude = position.latitude;
        currentMarker.longitude = position.longitude;
      });

      print(
          "IN STARTING POSITION: ${currentMarker.latitude} + ${currentMarker.longitude}");
    }).catchError((e) {
      print(e);
    });
  }

  void _startFetchingLocationPeriodically() {
    // Start fetching location every 10 seconds
    //when using on an acutal phone switch to
    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 50,
    );
    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) {
      _getCurrentLocation();
    });
  }

  void _stopFetchingLocationPeriodically() {
    _timer?.cancel();
  }

  void _getCurrentLocation() async {
    print("in current location");
    try {
      Position position = await Geolocator.getCurrentPosition();
      print(position);

      setState(() {
        _locationPoints.add(position);
        //TODO: FIX: distance and altimeters are not adding up properly!!
        if (_locationPoints.length > 1) {
          _distanceDone += Geolocator.distanceBetween(
              _locationPoints[_locationPoints.length - 1].latitude,
              _locationPoints[_locationPoints.length - 1].longitude,
              position.latitude,
              position.longitude);
          print("distance is $_distanceDone");
          _altimetersDone +=
              (_locationPoints[_locationPoints.length - 1].altitude -
                      position.altitude)
                  .abs();
        } else {
          print("The length of the list i 0 or 1");
        }
      });
      if (!isPeakAchieved) {
        print("Peak not achieved yet");
        if (Geolocator.distanceBetween(position.latitude, position.longitude,
                endPointCoordinates.latitude, endPointCoordinates.longitude) <
            30) {
          print("PEAK ACHIEVED !!!!!!");
          //we have reached the end! Save the endPoint as an achieved peak, but dont end the recording,
          //add the achieved peak to Hiker atribute achieved peaks or whatever is feeding the booklet
          setState(() {
            isPeakAchieved = true;
          });
        }
      }
    } catch (e) {
      print("Error while fetching location: $e");
    }
    //print("------ _locationPoints: ${_locationPoints}");
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
    _stopwatch.start();
    _startTimer();
    Position firstPosition = await getCurrentPosition();
    _locationPoints.add(firstPosition);
    _startFetchingLocationPeriodically();
    setState(() {
      _isRecording = true;
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

  void stopLocationTracking() {
    //await BackgroundFetch.stop();
    _stopwatch.stop();
    _stopTimer();
    _stopFetchingLocationPeriodically();
    _saveRecording(_locationPoints);
    updateNumberOfHikes(currentUserId);
    updateTimeHiking(currentUserId, _stopwatch.elapsed.inMinutes);
    updateNumberOfAltimeters(currentUserId, _altimetersDone);
    setState(() {
      badges = bc.checkForNewBadges(currentUserId);
      secondsPassed = _stopwatch.elapsed.inSeconds;
      _isRecording = false;
      _stopwatch.reset();
      _locationPoints.clear();
      isPeakAchieved = false;
    });

    var points = calculatePoints(secondsPassed);

    //go to pointAlert page!
    MyNavigator(context)
        .navigateToPointsPage("recording a hike", points, badges);
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
        print(peakNames);
      } else {
        setState(() {
          itemsPeakNames = [];
        });
      }
    });
  }

  _getPeakCoordinates(String? name) async {
    await FirebaseFirestore.instance
        .collection("Peaks")
        .where('name', isEqualTo: name)
        .get()
        .then((doc) {
      setState(() {
        endPointCoordinates.latitude = double.parse(doc.docs.first['latitude']);
        endPointCoordinates.longitude =
            double.parse(doc.docs.first['longitude']);
      });
      print(endPointCoordinates.latitude);
    });
  }

  _getThatValue(String? value) {
    setState(() {
      endPointRecording = value!;
    });
    _getPeakCoordinates(value);
    print(value);
  }

  @override
  void dispose() {
    //BackgroundLocation.stopLocationService();
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("IN BUILD: ${currentMarker.latitude}");
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
