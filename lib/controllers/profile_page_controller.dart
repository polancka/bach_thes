import 'package:bach_thes/views/widgets/reusable_widgets.dart';
import 'package:flutter/material.dart';

//Profile Page Controller provides information about user's recent hikes from
//Firebase Firestore database

List<Widget> renderLatestHikes(
    List<dynamic> listOfHikes, BuildContext context) {
  List<Widget> latestHikes = List<Widget>.empty(growable: true);
  for (var docSnapshot in listOfHikes) {
    latestHikes.add(listItemHike(docSnapshot, context));
  }

  return latestHikes;
}
