import 'package:bach_thes/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Hiker {
  final String id;
  final String username;
  final String email;
  final String profilePicture;
  final int level;
  final int points;
  final String scoreboardParticipation;
  final int numberOfHikes;
  final int timeTogheter;
  final double altimetersTogheter;
  final List<String> badges;
  final List<String> recentSearches;
  final double distanceTogheter;
  final List<String> mountainChain;
  Hiker(
      {required this.id,
      required this.username,
      required this.email,
      required this.profilePicture,
      required this.level,
      required this.points,
      required this.scoreboardParticipation,
      required this.numberOfHikes,
      required this.timeTogheter,
      required this.altimetersTogheter,
      required this.badges,
      required this.recentSearches,
      required this.distanceTogheter,
      required this.mountainChain});

  String getParticipation() {
    return this.scoreboardParticipation;
  }
}

updateNumberOfHikes(String id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var currentHikes = prefs.getInt('numberOfHikes');
  var newHikes = currentHikes! + 1;
  prefs.setInt('numberOfHikes', newHikes);

  var wantedDocuments = await FirebaseFirestore.instance
      .collection('Hikers')
      .where('id', isEqualTo: id)
      .get();
  var docRef = wantedDocuments.docs.first.id;

  final docRefUpdate = db.collection('Hikers').doc("${docRef}");
  docRefUpdate.update({"numberOfHikes": newHikes}).then(
      (value) => print("DocumentSnapshot successfully updated!"),
      onError: (e) => print("Error updating document $e"));
}

updateNumberOfAltimeters(String id, double newalts) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var currentAltimeters = prefs.getDouble('altimetersTogheter');
  var newAltimeters = currentAltimeters! + newalts;
  prefs.setDouble('altimetersTogheter', newAltimeters);

  var wantedDocuments = await FirebaseFirestore.instance
      .collection('Hikers')
      .where('id', isEqualTo: id)
      .get();
  var docRef = wantedDocuments.docs.first.id;

  final docRefUpdate = db.collection('Hikers').doc("${docRef}");
  docRefUpdate.update({"altimetersTogheter": newAltimeters}).then(
      (value) => print("DocumentSnapshot successfully updated!"),
      onError: (e) => print("Error updating document $e"));
}

updateDistanceTogheter(String id, double newestDistance) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var currentDistance = prefs.getDouble('distanceTogheter');
  var newDistance = currentDistance! + newestDistance;
  prefs.setDouble('distanceTogheter', newDistance);

  var wantedDocuments = await FirebaseFirestore.instance
      .collection('Hikers')
      .where('id', isEqualTo: id)
      .get();
  var docRef = wantedDocuments.docs.first.id;

  final docRefUpdate = db.collection('Hikers').doc("${docRef}");
  docRefUpdate.update({"distanceTogheter": newDistance}).then(
      (value) => print("DocumentSnapshot successfully updated!"),
      onError: (e) => print("Error updating document $e"));
}

updateTimeHiking(String id, int newTime) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var currentTime = prefs.getInt('timeTogheter');
  var newTimeTogheter = currentTime! + newTime;
  prefs.setInt('timeTogheter', newTimeTogheter);

  var wantedDocuments = await FirebaseFirestore.instance
      .collection('Hikers')
      .where('id', isEqualTo: id)
      .get();
  var docRef = wantedDocuments.docs.first.id;

  final docRefUpdate = db.collection('Hikers').doc("${docRef}");
  docRefUpdate.update({"timeTogheter": newTimeTogheter}).then(
      (value) => print("DocumentSnapshot successfully updated!"),
      onError: (e) => print("Error updating document $e"));
}

updateNewPoints(int points, String id) async {
  var wantedDocuments = await FirebaseFirestore.instance
      .collection('Hikers')
      .where('id', isEqualTo: id)
      .get();
  var docRef = wantedDocuments.docs.first.id;

  final docRefUpdate = db.collection('Hikers').doc("${docRef}");
  docRefUpdate.update({"points": points}).then(
      (value) => print("DocumentSnapshot successfully updated!"),
      onError: (e) => print("Error updating document $e"));
}

updateNewLevel(int newLevel, String id) async {
  var wantedDocuments = await FirebaseFirestore.instance
      .collection('Hikers')
      .where('id', isEqualTo: id)
      .get();
  var docRef = wantedDocuments.docs.first.id;

  final docRefUpdate = db.collection('Hikers').doc("${docRef}");
  docRefUpdate.update({"level": newLevel}).then(
      (value) => print("DocumentSnapshot successfully updated!"),
      onError: (e) => print("Error updating document $e"));
}

updateRecentSearches(String id, List<String> allSearches) async {
  var wantedDocuments = await FirebaseFirestore.instance
      .collection('Hikers')
      .where('id', isEqualTo: id)
      .get();
  var docRef = wantedDocuments.docs.first.id;

  final docRefUpdate = db.collection('Hikers').doc("${docRef}");
  docRefUpdate.update({"recentSearches": allSearches}).then(
      (value) => print("DocumentSnapshot successfully updated!"),
      onError: (e) => print("Error updating document $e"));
}

changeParticipation(bool isParticipating, String id) async {
  var wantedDocuments = await FirebaseFirestore.instance
      .collection('Hikers')
      .where('id', isEqualTo: id)
      .get();
  var docRef = wantedDocuments.docs.first.id;

  final docRefUpdate = db.collection('Hikers').doc("${docRef}");
  docRefUpdate.update({"scoreboardParticipation": isParticipating}).then(
      (value) => print("DocumentSnapshot successfully updated!"),
      onError: (e) => print("Error updating document $e"));
}

updateBadges(String id, List<String> badges) async {
  var wantedDocuments = await FirebaseFirestore.instance
      .collection('Hikers')
      .where('id', isEqualTo: id)
      .get();
  var docRef = wantedDocuments.docs.first.id;

  final docRefUpdate = db.collection('Hikers').doc("${docRef}");
  docRefUpdate.update({"badges": badges}).then(
      (value) => print("DocumentSnapshot successfully updated!"),
      onError: (e) => print("Error updating document $e"));
}

updateMountainChain(String id, String mountainChain) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> oldMountainChain = prefs.getStringList('mountainChain')!;
  oldMountainChain.add(mountainChain);
  prefs.setStringList('mountainChain', oldMountainChain);

  var wantedDocuments = await FirebaseFirestore.instance
      .collection('Hikers')
      .where('id', isEqualTo: id)
      .get();
  var docRef = wantedDocuments.docs.first.id;

  final docRefUpdate = db.collection('Hikers').doc("${docRef}");
  docRefUpdate.update({"mountainChain": oldMountainChain}).then(
      (value) => print("DocumentSnapshot successfully updated!"),
      onError: (e) => print("Error updating document $e"));
}

clearSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}

Future<DocumentReference> addHiker(String email, String username, String? userId
    //String profilePicture in the beggining use a default photo
    ) async {
  var newUSerRef = await db.collection("Hikers").add({
    'id': userId,
    'username': username,
    'email': email,
    'pictureUrl':
        "https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/User-avatar.svg/2048px-User-avatar.svg.png",
    'level': 1,
    'points': 0,
    'bookletId': userId,
    'scoreboardParticipation': false,
    'achievedPeaks': [],
    'numberOfHikes': 0,
    'timeTogheter': 0,
    'altimetersTogheter': 0.0,
    'badges': [
      "false",
      "false",
      "false",
      "false",
      "false",
      "false",
      "false",
      "false",
      "false",
      "false",
      "false",
      "false",
      "false",
      "false",
      "false",
      "false",
      "false",
    ],
    'recentSearches': [],
    'distanceTogheter': 0.0,
    'mountainChain': [],
  });

  //add reference number for the booklet

  return newUSerRef;
}
