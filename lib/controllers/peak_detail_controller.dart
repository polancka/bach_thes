import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bach_thes/models/peak.dart';
import 'package:bach_thes/models/path.dart';
import 'package:bach_thes/utils/styles.dart';
import 'package:bach_thes/views/pages/peak_detail.dart';
import 'package:bach_thes/views/pages/path_detail.dart';
import 'navigation_controller.dart';

//Provides a widget that shows all the information about the peak, including
//all the paths leading up to it

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

List<Widget> renderBody(
    BuildContext context, DocumentSnapshot document, List<dynamic> allPaths) {
  var result = List<Widget>.empty(growable: true);

  result.add(bannerImage(document['urlThumbnail'], 200));
  result.add(sectionTitle("${document['name']}"));
  result.add(Center(
      child: Text(
    "${document['altitude']}m",
    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
  )));
  result.add(SizedBox(
    height: 15,
  ));
  result.add(sectionText("${document['description']}"));
  result.add(SizedBox(
    height: 15,
  ));

  result.add(Center(
      child: Text(
    "How to get there?",
    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
  )));

  result.add(SizedBox(
    height: 15,
  ));

  result.addAll(returnAllPaths(context, allPaths));

  return result;
}

List<Widget> returnAllPaths(BuildContext context, List<dynamic> allPaths) {
  List<Widget> result = [];

  for (var docSnapshot in allPaths) {
    result.add(Container(
        child: Card(
            margin: EdgeInsets.all(3),
            color: Styles.deepgreen.withOpacity(0.7),
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(20)),
            child: ListTile(
              leading: Icon(
                Icons.hiking_outlined,
                color: Colors.white,
              ),
              title: Text(
                docSnapshot['pathName'],
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(docSnapshot['difficulty'],
                  style: TextStyle(color: Colors.white)),
              trailing: Icon(
                Icons.keyboard_double_arrow_right_outlined,
                color: Colors.white,
              ),
              onTap: () => MyNavigator(context).navigateToPathDetail(),
            ))));
  }

  return result;
}
