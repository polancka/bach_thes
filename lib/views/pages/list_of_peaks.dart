import 'package:bach_thes/models/peak.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bach_thes/models/mock_database/mock_peak.dart';

class SearchPeaks extends StatelessWidget {
  const SearchPeaks({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.pink,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                "Search Slovenian peaks",
                style: TextStyle(color: Colors.pinkAccent),
              ),
            ),
            body: Container(
                child: ListView.separated(
                    itemCount: MockPeak.FetchAll().length,
                    itemBuilder: (context, index) =>
                        _buildListItem(context, MockPeak.FetchAll()[index]),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                        )))));
  }
}

Widget _buildListItem(BuildContext context, Peak peak) {
  return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        leading: Icon(Icons.hiking_outlined),
        title: Text("${peak.name},  ${peak.altitude}m"),
        subtitle: Text(peak.description),
        trailing: Icon(Icons.keyboard_double_arrow_right_outlined),
      ));
}
