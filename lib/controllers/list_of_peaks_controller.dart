import 'package:flutter/material.dart';
import 'package:bach_thes/models/peak.dart';
import 'package:bach_thes/views/pages/peak_detail.dart';

void navigateToPeakDetail(BuildContext context, Peak peak) {
  Navigator.push(
      //adds the page to the stack, MaterialPageRoute determines to which screen it goes
      context,
      MaterialPageRoute(builder: (context) => PeakDetail(peak)));
}

Widget buildListItem(BuildContext context, Peak peak) {
  return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        leading: Icon(Icons.hiking_outlined),
        title: Text("${peak.name},  ${peak.altitude}m"),
        subtitle: Text(peak.altitude.toString()),
        trailing: Icon(Icons.keyboard_double_arrow_right_outlined),
        onTap: () => navigateToPeakDetail(context, peak),
      ));
}
