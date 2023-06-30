import 'package:bach_thes/views/widgets/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:bach_thes/utils/styles.dart';

//implement logic for querying the Hikes database based on userID and Date of hike
List<Widget> renderLatestHikes(List<dynamic> listOfHikes) {
  List<Widget> latestHikes = List<Widget>.empty(growable: true);
  for (var docSnapshot in listOfHikes) {
    //print(docSnapshot.toString());
    latestHikes.add(listItemHike(docSnapshot));
  }

  return latestHikes;
}
