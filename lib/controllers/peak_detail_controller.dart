import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bach_thes/models/peak.dart';
import 'package:bach_thes/models/path.dart';
import 'package:bach_thes/utils/styles.dart';
import 'package:bach_thes/views/pages/peak_detail.dart';
import 'package:bach_thes/views/pages/path_detail.dart';

//Provides a widget that shows all the information about the peak, including
//all the paths leading up to it

void navigateToPathDetail(BuildContext context, Path path) {
  Navigator.push(
      //adds the page to the stack, MaterialPageRoute determines to which screen it goes
      context,
      MaterialPageRoute(builder: (context) => PathDetail(path as Path)));
}

/*List<ListTile> renderPeakPaths(BuildContext context, DocumentSnapshot document) {
  var result = List<ListTile>.empty(growable: true);
  for (int i = 0; i < document['possiblePaths'].length; i++) {
    result.add(ListTile(
      leading: Icon(Icons.nordic_walking_outlined),
      title: Text(
          "${peak.possiblePaths[i].startingPointName},  ${peak.possiblePaths[i].duration}"),
      subtitle: Text(peak.altitude.toString()),
      trailing: Icon(Icons.keyboard_double_arrow_right_outlined),
      onTap: () => navigateToPathDetail(context, document.possiblePaths[i]),
    ));
  }

  final result = <Widget>[];


  for (int i = 0; i < peak.possiblePaths.length; i++) {
    result.add(sectionTitle(
        "From starting point no. ${peak.possiblePaths[i].startingPointId}"));
    result.add(sectionText(peak.possiblePaths[i].description));
  }

  return result;
}*/

//just stylist stuff, migh be taken out later or put in the styles.dart

Widget sectionTitle(String text) {
  return Container(
      padding: EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 10.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Styles.deepgreen, fontSize: 25, fontWeight: FontWeight.bold),
      ));
}

Widget sectionText(String text) {
  return Container(
      padding: EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        textAlign: TextAlign.start,
        style: TextStyle(
          color: Styles.deepgreen,
          fontWeight: FontWeight.normal,
          fontSize: 14,
        ),
      ));
}

Widget bannerImage(String url, double height) {
  return Container(
      constraints: BoxConstraints.tightFor(height: height),
      child: Image.network(url, fit: BoxFit.fitWidth));
}

List<Widget> renderBody(BuildContext context, DocumentSnapshot document) {
  var result = List<Widget>.empty(growable: true);
  result.add(bannerImage(document['urlThumbnail'], 200.0));
  result.add(sectionTitle("${document['name']} - ${document['altitude']}m "));
  result.add(sectionText("${document['description']}"));

  //result.addAll(renderPeakPaths(context, document));
  return result;
}
