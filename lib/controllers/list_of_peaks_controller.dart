import 'package:bach_thes/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:bach_thes/views/pages/peak_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
              "${document['name']},  ${document['altitude']}m",
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(document['altitude'].toString(),
                style: TextStyle(color: Colors.white)),
            trailing: Icon(
              Icons.keyboard_double_arrow_right_outlined,
              color: Colors.white,
            ),
            onTap: () => navigateToPeakDetail(context, document),
          )));
}
