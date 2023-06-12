import 'dart:math';

import 'package:flutter/material.dart';
import 'package:bach_thes/models/peak.dart';
import 'package:bach_thes/views/pages/peak_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:bach_thes/globals.dart';

//Function to navigate to the page with details of the specific peak, whose tile was clicked

void navigateToPeakDetail(BuildContext context, DocumentSnapshot document) {
  Navigator.push(
      //adds the page to the stack, MaterialPageRoute determines to which screen it goes
      context,
      MaterialPageRoute(builder: (context) => PeakDetail(document)));
}

//Function that provides a list of tiles, each consisting of basic information about the peak.
// The information is gathered from Firebase Firestore

Widget buildListItem(BuildContext context, DocumentSnapshot document) {
  return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        leading: Icon(Icons.hiking_outlined),
        title: Text("${document['name']},  ${document['altitude']}m"),
        subtitle: Text(document['altitude'].toString()),
        trailing: Icon(Icons.keyboard_double_arrow_right_outlined),
        onTap: () => navigateToPeakDetail(context, document),
      ));
}

//Widget renderList() {}

//Future<void> readFirebasePeaks(){}