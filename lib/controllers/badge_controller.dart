import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<String> checkForNewBadges(String userID) {
  Future<List<String>> oldBadges = retrieveOldBadges();
  Future<List<String>> newBadges = checkForNew(userID);
  List<int> indexesOfNew = compareOldAndNew(oldBadges, newBadges);
  List<String> badgesString = returnStringsOfIndexes(indexesOfNew);
  return badgesString;
}

Future<List<String>> retrieveOldBadges() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getStringList('badges')!;
}

Future<List<String>> checkForNew(String userId) async {
  //check for every badge
  List<String> allNewBadges = [];
  List<String> numberHikesBadges = [];
  var nHikes = 0;

  //number of hikes
  var numberOfHikes = await FirebaseFirestore.instance
      .collection('RHikes')
      .where('hikerId', isEqualTo: userId)
      .count()
      .get()
      .then((value) => print(value));

  if (nHikes < 5) {
    return ["false", "false", "false", "false", "false"];
  }

  return ["a"];
}

List<int> compareOldAndNew(
    Future<List<String>> oldBadges, Future<List<String>> newBadges) {
  return [];
}

List<String> returnStringsOfIndexes(List<int> indexes) {
  return [];
}
