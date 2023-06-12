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

List<Widget> renderPeakDetail(BuildContext context, Peak peak) {
  var result = List<Widget>.empty(growable: true);
  result.add(bannerImage(peak.urlThumbnail, 170.0));
  result.addAll(renderPeakPaths(context, peak));
  return result;
}

List<ListTile> renderPeakPaths(BuildContext context, Peak peak) {
  var result = List<ListTile>.empty(growable: true);
  for (int i = 0; i < peak.possiblePaths.length; i++) {
    result.add(ListTile(
      leading: Icon(Icons.nordic_walking_outlined),
      title: Text(
          "${peak.possiblePaths[i].startingPointName},  ${peak.possiblePaths[i].duration}"),
      subtitle: Text(peak.altitude.toString()),
      trailing: Icon(Icons.keyboard_double_arrow_right_outlined),
      onTap: () => navigateToPathDetail(context, peak.possiblePaths[i]),
    ));
  }
  /*final result = <Widget>[];
  for (int i = 0; i < peak.possiblePaths.length; i++) {
    result.add(sectionTitle(
        "From starting point no. ${peak.possiblePaths[i].startingPointId}"));
    result.add(sectionText(peak.possiblePaths[i].description));
  }*/
  return result;
}

//just stylist stuff, migh be taken out later or put in the styles.dart

Widget sectionTitle(String text) {
  return Container(
      padding: EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 10.0),
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: Styles.headerLarge,
      ));
}

Widget sectionText(String text) {
  return Container(
      padding: EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 10.0),
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: TextStyle(
          color: Colors.black,
        ),
      ));
}

Widget bannerImage(String url, double height) {
  return Container(
      constraints: BoxConstraints.tightFor(height: height),
      child: Image.network(url, fit: BoxFit.fitWidth));
}

List<Widget> renderBody(BuildContext context, Peak peak) {
  var result = List<Widget>.empty(growable: true);
  result.add(bannerImage(peak.urlThumbnail, 170.0));
  result.addAll(renderPeakPaths(context, peak));
  return result;
}
