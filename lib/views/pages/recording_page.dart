import 'package:bach_thes/views/widgets/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:bach_thes/utils/styles.dart';
import 'package:bach_thes/globals.dart';
import 'package:bach_thes/models/hike.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecordingPage extends StatefulWidget {
  const RecordingPage({super.key});

  @override
  State<RecordingPage> createState() => _RecordingPageState();
}

class _RecordingPageState extends State<RecordingPage> {
  double? longitude = 0.0;
  double? latitude = 0.0;
  int altimetersDone = 0;
  int secondsElapsed = 0;
  var buttonText;
  var isRecording = false;
  final timeStamp = DateTime.now();
  var endPointName = "";
  var currentId = "";

  //TODO: figure out the date and time, figure out counting seconds and altimeters
  //TODO: why is location wrong, locking the textfield after "start recording"
  //tracking geopoints and saving them?

  TextEditingController endPointNameController = new TextEditingController();

  getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState() {
      currentId = prefs.getString('id')!;
    }
  }

  stopRecording() {
    print("in stop recording");
    setState(() {
      isRecording = false;
      endPointName = endPointNameController.text;
    });
    //check if last location is near a peak in the database
    //save the recording to databse RecordedHikes with the correct user ID

    addNewRecordedHike(currentId, DateTime.now(), secondsElapsed,
        altimetersDone, endPointName);

    //add points for recording a hike
    //return back to profile page
  }

  startRecording() {
    print("in start recording");
    setState(() {
      isRecording = true;
    });
  }

  getCurrentPosition() async {
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
        return;
      }
    }

    _locationData = await location.getLocation();
    setState(() {
      longitude = _locationData.longitude;
      latitude = _locationData.latitude;
    });
    print(_locationData.latitude);
    print(_locationData.longitude);
    print(_locationData.altitude);
  }

  @override
  void initState() {
    // TODO: implement initState
    getUserId();
    print(currentId);
    getCurrentPosition();
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
                Text("Time elapsed: ${secondsElapsed}"),
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
