import 'package:bach_thes/models/hiker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<String>> checkWhatIsNew(String userID) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var thisHikerQuery = await FirebaseFirestore.instance
      .collection('Hikers')
      .where('id', isEqualTo: userID)
      .get();

  int nHikes = thisHikerQuery.docs.first['numberOfHikes'] + 1;

  double altimeters = thisHikerQuery.docs.first['altimetersTogheter'];

  List<String> mountainChains = prefs.getStringList('mountainChain')!;

  //search DB RHikes for every hike from this hiker, collect names of peaks into List<String> and pass it to check for new
  List<String> peaks = [];
  var achievedPeaksQuery = await FirebaseFirestore.instance
      .collection('RHikes')
      .where('hikerId', isEqualTo: userID)
      .where('acheived', isEqualTo: true)
      .get();

  for (var hike in achievedPeaksQuery.docs) {
    peaks.add(hike['endPointName']);
  }

  List<String> oldBadges = prefs.getStringList('badges')!;
  List<String> newBadges =
      checkForNew(nHikes, altimeters, mountainChains!, peaks);
  updateBadges(userID, newBadges);
  updatePrefBadges(newBadges);
  List<int> indexesOfNew = compareOldAndNew(oldBadges, newBadges);
  List<String> badgesString = returnStringsOfIndexes(indexesOfNew);

  return badgesString; // this list needs to get to recording page somehow!
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
  } else if (altimeters >= 4500) {
    return ["true", "true", "true", "true"];
  }
  return ["false", "false", "false", "false"];
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
  List<String> specialBadges = ["false", "false", "false"];
  List<String> altimBadges = getAltimetersBadges(altimeters);

  allNewBadges.addAll(numberHikesBadges);
  allNewBadges.addAll(regionsBadges);
  allNewBadges.addAll(newConqBadges);
  allNewBadges.addAll(specialBadges);
  allNewBadges.addAll(altimBadges);

  print("this is new badges: $allNewBadges");

  return allNewBadges;
}

List<int> compareOldAndNew(List<String> oldBadges, List<String> newBadges) {
  List<int> diffs = [];
  for (int i = 0; i < oldBadges.length; i++) {
    if (oldBadges[i] != newBadges[i]) {
      diffs.add(i);
    }
  }
  return diffs;
}

List<String> returnStringsOfIndexes(List<int> indexes) {
  List<String> namesNewBadges = [];
  var badgeNames = [
    "5 hikes",
    "10 hikes",
    "25 hikes",
    "40 hikes",
    "65 hikes",
    "Hike in every region",
    "5 hikes in one region",
    "10 hikes in one region",
    "3 new peaks",
    "7 new peaks",
    "12 new peaks",
    "15 new peaks",
    "21 new peaks",
    "1000 altimeters",
    "2500 altimeters",
    "3500 altimeters",
    "4500 altimeters",
  ];
  for (int i = 0; i < indexes.length; i++) {
    namesNewBadges.add(badgeNames[indexes[i]]);
  }
  return namesNewBadges;
}
