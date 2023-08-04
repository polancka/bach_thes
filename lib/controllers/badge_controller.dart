List<String> checkForNewBadges(String userID) {
  List<bool> oldBadges = retrieveOldBadges();
  List<bool> newBadges = checkForNew();
  List<int> indexesOfNew = compareOldAndNew(oldBadges, newBadges);
  List<String> badgesString = returnStringsOfIndexes(indexesOfNew);
  return badgesString;
}

List<bool> retrieveOldBadges() {
  return [];
}

List<bool> checkForNew() {
  return [];
}

List<int> compareOldAndNew(List<bool> oldBadges, List<bool> newBadges) {
  return [];
}

List<String> returnStringsOfIndexes(List<int> indexes) {
  return [];
}
