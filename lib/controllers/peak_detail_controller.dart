import 'package:flutter/material.dart';
import 'package:bach_thes/models/peak.dart';
import 'package:bach_thes/models/path.dart';
import 'package:bach_thes/utils/styles.dart';
import 'package:bach_thes/views/pages/peak_detail.dart';

List<Widget> renderPeakDetail(BuildContext context, Peak peak) {
  var result = List<Widget>.empty(growable: true);
  result.add(bannerImage(peak.urlThumbnail, 170.0));
  result.addAll(renderPeakPaths(context, peak));
  return result;
}

List<Widget> renderPeakPaths(BuildContext context, Peak peak) {
  final result = <Widget>[];
  for (int i = 0; i < peak.possiblePaths.length; i++) {
    result.add(sectionTitle(
        "From starting point no. ${peak.possiblePaths[i].startingPointId}"));
    result.add(sectionText(peak.possiblePaths[i].description));
  }
  return result;
}

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
