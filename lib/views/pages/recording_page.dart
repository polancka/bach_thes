//TODO: figure out the date and time, figure out counting seconds and altimeters
//TODO: why is location wrong, locking the textfield after "start recording"
//tracking geopoints and saving them?
import 'dart:async';
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
  bool _isRecording = false;
  List<Position> _locationPoints = [];
  String _timePassed = '00:00:00';
  double _altimetersDone = 0.0;
  double _distanceDone = 0.0;
  Stopwatch _stopwatch = Stopwatch();
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
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
    //initBackgroundTracking();
    //_startFetchingLocationPeriodically();
  }

  @override
  void dispose() {
    //stopLocationTracking();
    //_stopFetchingLocationPeriodically();
    super.dispose();
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
    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      _getCurrentLocation();
    });
  }

  void _stopFetchingLocationPeriodically() {
    _timer?.cancel();
  }

  void _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation,
      );

      setState(() {
        _locationPoints.add(position);
      });
      print(_locationPoints);
    } catch (e) {
      print("Error while fetching location: $e");
    }
  }

  Future<Position> getCurrentPosition() async {
    //print("in current position");
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  addLocationPoint() async {
    Position thisPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    setState(() {
      _locationPoints.add(thisPosition);
    });
  }

  void _startTimer() {
    /*final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) {
      print(position == null
          ? 'Unknown'
          : '${position.latitude.toString()}, ${position.longitude.toString()}');
    });*/
    _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      setState(() {
        _timePassed = getFormattedTime();
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  Future<void> _onFetch() async {
    if (_isRecording) {
      Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);

      if (currentPosition != null) {
        setState(() {
          _locationPoints.add(currentPosition);
          _distanceDone += currentPosition.speed ?? 0.0;
          _altimetersDone += currentPosition.altitude ?? 0.0;
          _showNotification(_timePassed);
        });
      }
    }

    //BackgroundFetch.finish(taskId);
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
      'userId': FirebaseAuth.instance.currentUser?.uid.toString(),
      'endPointName': "Test name",
      'timePassed': _timePassed,
      'totalDistanceInMeters': _distanceDone,
      'totalAltitudeInMeters': _altimetersDone,
      'dateTime': formattedDate,
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
    //_showNotification(_timePassed);
    setState(() {
      _isRecording = false;
      _stopwatch.reset();
    });
    _saveRecording(_locationPoints);
  }

  void _showNotification(String time) {
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'location_channel',
      'Location updates',
      importance: Importance.high,
      priority: Priority.high,
    );

    _flutterLocalNotificationsPlugin.show(0, 'Current Location', 'Time: $time',
        const NotificationDetails(android: androidPlatformChannelSpecifics));
  }

  Future<void> initBackgroundTracking() async {
    //CALL ONFETCH FUNCTION
    final notificationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final notificationSettings = InitializationSettings(
      android: notificationSettingsAndroid,
    );
    _flutterLocalNotificationsPlugin.initialize(notificationSettings);
  }

  @override
  Widget build(BuildContext context) {
    print(_stopwatch.elapsedMilliseconds);
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
