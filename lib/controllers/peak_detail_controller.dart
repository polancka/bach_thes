import 'dart:convert';
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

List<Widget> renderPaths(BuildContext context, DocumentSnapshot document) {
  final arrayOfPaths = document['Paths'];

  var result = <Widget>[];

  for (int i = 0; i < document['Paths'].length; i++) {
    var firstPath = arrayOfPaths[i].toString();
    Map<String, dynamic> jsonPath = jsonDecode(firstPath);

    //TODO: make a new Path for every path, this path is then sent
    Path path = Path(
        id: jsonPath['id'],
        startingPointName: jsonPath['StartingPointName'],
        alitmeters: jsonPath['altimeters'],
        difficulty: jsonPath['difficulty'],
        duration: jsonPath['duration'],
        description: jsonPath['description']);
    result.add(ListTile(
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        //selectedTileColor: Colors.white,
        tileColor: Colors.black,
        dense: true,
        leading: Icon(Icons.nordic_walking_outlined),
        title: Text("${jsonPath['StartingPointName']}"),
        subtitle: Text("Chose this path"),
        trailing: Icon(Icons.keyboard_double_arrow_right_outlined),
        onTap: () => navigateToPathDetail(context, path)));
  }

  return result;

  /*return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text("${arrayOfPaths[0]}"),
              SizedBox(height: 10),
              Text("${arrayOfPaths[1]}"),
            ],
          )));*/
}

List<Widget> renderBody(BuildContext context, DocumentSnapshot document) {
  var result = List<Widget>.empty(growable: true);
  result.add(bannerImage(document['urlThumbnail'], 200));
  result.add(sectionTitle("${document['name']}"));
  result.add(Text(
    "${document['altitude']}",
  ));
  result.add(SizedBox(
    height: 15,
  ));
  result.add(sectionText("${document['description']}"));
  result.add(SizedBox(
    height: 15,
  ));

  //TODO: add check if the peak has paths, if not, return a text saying there are no paths
  //if there are paths, display them with renderPaths method
  /*try {
    result.addAll(renderPaths(context, document));
  } on FirebaseFirestore catch (e) {
    print(e);
  }*/

  //result.addAll(renderPeakPaths(context, document));
  return result;
}
