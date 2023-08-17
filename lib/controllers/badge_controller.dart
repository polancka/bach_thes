import 'package:bach_thes/models/hiker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<String>> checkWhatIsNew(String userID) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var thisHiker = await FirebaseFirestore.instance
      .collection('Hikers')
      .where('hikerId', isEqualTo: userID)
      .get();

  //search DB RHikes for every hike from this hiker, collect names of peaks into List<String> and pass it to check for new
  List<String> peaks = [];

  var nHikes = thisHiker.docs.first['numberOfHikes'];
  var altimeters = thisHiker.docs.first['altimeters'];
  var mountainChains = prefs.getStringList('mountainChain');

  List<String> oldBadges = prefs.getStringList('badges')!;
  List<String> newBadges =
      checkForNew(nHikes, altimeters, mountainChains!, peaks);
  updateBadges(userID, newBadges);
  updatePrefBadges(newBadges);
  List<int> indexesOfNew = compareOldAndNew(oldBadges, newBadges);
  List<String> badgesString = returnStringsOfIndexes(indexesOfNew);
  //TODO: dont forget to save new string of badges to prefs and database
  return badgesString;
}

updatePrefBadges(List<String> newBadges) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setStringList('badges', newBadges);
}

Future<List<String>> retrieveOldBadges() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getStringList('badges')!;
}

List<String> getNumberHikesBadges(int nHikes) {
  if (nHikes < 5) {
    return ["false", "false", "false", "false", "false"];
  } else if (nHikes < 10) {
    return ["true", "false", "false", "false", "false"];
  } else if (nHikes < 25) {
    return ["true", "true", "false", "false", "false"];
  } else if (nHikes < 40) {
    return ["true", "true", "true", "false", "false"];
  } else if (nHikes < 65) {
    return ["true", "true", "true", "true", "false"];
  } else {
    return ["true", "true", "true", "true", "true"];
  }
}

List<String> getAltimetersBadges(double altimeters) {
  if (altimeters < 1000) {
    return ["false", "false", "false", "false"];
  } else if (altimeters < 2500) {
    return ["true", "false", "false", "false"];
  } else if (altimeters < 3500) {
    return ["true", "true", "false", "false"];
  } else if (altimeters < 4500) {
    return ["true", "true", "true", "false"];
  } else {
    return ["true", "true", "true", "true"];
  }
}

List<String> getRegionBadges(List<String> mountainChains) {
  bool fiveInReg = false;
  bool tenInReg = false;
  bool allReg = false;

  if (mountainChains.contains("Karawanks") &&
      mountainChains.contains("Julian Alps") &&
      mountainChains.contains("Kamnik Savinja Alps") &&
      mountainChains
          .contains("Gorice, Notranjsko and Snežnik mountain range") &&
      mountainChains.contains("Pohorje, Dravinjske gorice and Haloze") &&
      mountainChains.contains("Ljubljana and Polhograd mountain range") &&
      mountainChains
          .contains("Jelovica, Škofja Loka and Cerklje mountain range") &&
      mountainChains.contains("Prekmurje") &&
      mountainChains
          .contains("Strojna, Košenjak, Kozjak and Slovenske gorice")) {
    allReg = true;
  }

  var map = Map();
  mountainChains.forEach((element) {
    if (!map.containsKey(element)) {
      map[element] = 1;
    } else {
      map[element] += 1;
    }

    for (var oneregion in map.values) {
      if (oneregion >= 5) {
        fiveInReg = true;
      }

      if (oneregion >= 10) {
        tenInReg = true;
      }
    }
  });

  return [allReg.toString(), fiveInReg.toString(), tenInReg.toString()];
}

getNewPeaks(List<String> peaks) {
  final result = peaks.fold(
      <String, int>{},
      (Map<String, int> map, item) =>
          map..update(item, (count) => count + 1, ifAbsent: () => 1));

  List<String> uniqueNames = result.keys.toList();
  if (uniqueNames.length < 2) {
    return ["false", "false", "false", "false", "false"];
  } else if (uniqueNames.length > 20) {
    return ["true", "true", "true", "true", "true"];
  } else if (uniqueNames.length > 14) {
    return ["true", "true", "true", "true", "false"];
  } else if (uniqueNames.length > 11) {
    return ["true", "true", "true", "false", "false"];
  } else if (uniqueNames.length > 6) {
    return ["true", "true", "false", "false", "false"];
  } else if (uniqueNames.length > 2) {
    return ["true", "false", "false", "false", "false"];
  }
}

List<String> checkForNew(int nHikes, double altimeters,
    List<String> mountainChains, List<String> peaks) {
  //check for every badge
  List<String> allNewBadges = [];
  List<String> numberHikesBadges = getNumberHikesBadges(nHikes);
  List<String> regionsBadges = getRegionBadges(mountainChains);
  List<String> newConqBadges = getNewPeaks(peaks);
  List<String> specialBadges = [];
  List<String> altimBadges = getAltimetersBadges(altimeters);

  allNewBadges.addAll(numberHikesBadges);
  allNewBadges.addAll(regionsBadges);
  allNewBadges.addAll(newConqBadges);
  allNewBadges.addAll(specialBadges);
  allNewBadges.addAll(altimBadges);

  return allNewBadges;
}

List<int> compareOldAndNew(List<String> oldBadges, List<String> newBadges) {
  return [];
}

List<String> returnStringsOfIndexes(List<int> indexes) {
  return [];
}
