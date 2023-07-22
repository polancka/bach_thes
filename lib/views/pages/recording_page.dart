import 'dart:async';

import 'package:bach_thes/controllers/navigation_controller.dart';
import 'package:bach_thes/views/widgets/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:bach_thes/utils/styles.dart';
import 'package:bach_thes/globals.dart';
import 'package:bach_thes/models/hike.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main_page.dart';

class RecordingPage extends StatefulWidget {
  const RecordingPage({super.key});

  @override
  State<RecordingPage> createState() => _RecordingPageState();
}

class _RecordingPageState extends State<RecordingPage> {
  double? longitude = 0.0;
  double? latitude = 0.0;
  double altimetersDone = 1;
  int secondsElapsed = 1;
  late Duration duration;
  var buttonText;
  var isRecording = false;
  final timeStamp = DateTime.now();
  var endPointName = "";
  var currentId;
  var altBeg;
  var altMid;
  var altFin;
  late DateTime secBeg;
  late DateTime secMid;
  late DateTime secFin;
  bool isCurrentlyRecording = false;
  var beginAltimeters;
  var finishAltimeters;

  Stopwatch _stopwatch = Stopwatch();
  late Timer _timer;

  //TODO: figure out the date and time, figure out counting seconds and altimeters
  //TODO: why is location wrong, locking the textfield after "start recording"
  //tracking geopoints and saving them?

  //when u input name, lock the field, or have a dropdown menu to choose from all peaks
  TextEditingController endPointNameController = new TextEditingController();

  int calculatePoints(int miliseconds) {
    //hike must last more than 10minutes
    if (miliseconds < 600000) {
      return 0;
    }
    var pointsToAdd = 10; //10 points for recording a hike
    pointsToAdd = pointsToAdd +
        (altimetersDone.floor() % 100) * 2; // 2 points for every 100 altimeters
    pointsToAdd = pointsToAdd +
        (secondsElapsed % 60) * 5; // 5 points for every hour of hiking

    return pointsToAdd;
  }

  checkIfRecording() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isCurrentlyRecording = prefs.getBool('isRecording')!;
    });
  }

  calculateTimerToShow() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //implement logic for calculating the correct time on screen
    duration = DateTime.now().difference(secBeg);
    print(duration);
  }

  String formatTime(int milliseconds) {
    var secs = milliseconds ~/ 1000;
    var hours = (secs ~/ 3600).toString().padLeft(2, '0');
    var minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
    var seconds = (secs % 60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }

  getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currentId = FirebaseAuth.instance.currentUser!.uid;
    setState() {
      prefs.setString('id', currentId);
    }
  }

  stopRecording() async {
    _stopwatch.stop();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isRecording = false;
      endPointName = endPointNameController.text;
      secFin = DateTime.now();
    });
    prefs.setBool('isRecording', false);
    //cTODO: check if last location is near a peak in the database

    //calculate altimeters done
    var finishAltimeters = await getCurrentPosition();
    altimetersDone = finishAltimeters - beginAltimeters;
    //save to database under correct ID
    addNewRecordedHike(currentId, DateTime.now(),
        _stopwatch.elapsedMilliseconds ~/ 1000, altimetersDone, endPointName);

    //calculate points to add
    var earnedPoints = calculatePoints(_stopwatch.elapsedMilliseconds);

    //navigate to screen with congrats  --> there the new poitns are added to the database
    MyNavigator(context).navigateToPointsPage("recording a hike", earnedPoints);

    //return back to profile page
    _stopwatch.reset();
  }

  startRecording() async {
    _stopwatch.start();
    setState(() {
      beginAltimeters = getCurrentPosition();
      secBeg = DateTime.now();
      isRecording = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('secBeg', secBeg.microsecondsSinceEpoch);
    prefs.setBool('isRecording', true);
    print(prefs.getInt('secBeg'));
  }

  Future<double> getCurrentPosition() async {
    Location location = new Location();
    LocationData _locationData;
    bool serviceEnabled;
    PermissionStatus permission;

    // Test if location services are enabled.
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await location.requestPermission();
      if (permission != PermissionStatus.granted) {
        //return nothing
      }
    }

    _locationData = await location.getLocation();
    setState(() {
      longitude = _locationData.longitude;
      latitude = _locationData.latitude;
    });

    return _locationData.altitude!;
  }

  @override
  void initState() {
    _stopwatch = Stopwatch();
    _timer = new Timer.periodic(new Duration(milliseconds: 30), (timer) {
      setState(() {});
    });

    //if we are already recording (isrecording is true in shared preferences), save the date and calulctae what to show
    checkIfRecording();
    if (isCurrentlyRecording) {
      setState(() {
        secMid = DateTime.now();
      });
    }
    getUserId();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
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
                    child: isRecording
                        ? Image.asset("lib/utils/images/Hiker.gif",
                            height: 125.0, width: 125)
                        : Text("")),
                Text("Current position: ${longitude}, ${latitude} "),
                Text(formatTime(_stopwatch.elapsedMilliseconds)),
                Text("Altimeters done: ${altimetersDone}"),
                SizedBox(
                  height: 40,
                ),
                TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Styles.deepgreen)),
                  onPressed: () {
                    isRecording ? stopRecording() : startRecording();
                  },
                  child: isRecording
                      ? Text("Stop recording",
                          style: TextStyle(color: Colors.white))
                      : Text("Start recording",
                          style: TextStyle(color: Colors.white)),
                ),
              ]),
        ));
  }
}
