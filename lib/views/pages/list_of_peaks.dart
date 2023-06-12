import 'package:bach_thes/models/peak.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bach_thes/models/mock_database/mock_peak.dart';
import 'package:bach_thes/globals.dart';
import 'package:bach_thes/controllers/list_of_peaks_controller.dart';

//UI for the list of peaks shown during search (?) function

class SearchPeaks extends StatelessWidget {
  const SearchPeaks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.pinkAccent,
        appBar: AppBar(
          backgroundColor: Colors.pinkAccent,
          title: Text(
            "Search Slovenian peaks",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              child: ListView.separated(
                  itemCount: MockPeak.FetchAll().length,
                  itemBuilder: (context, index) =>
                      buildListItem(context, MockPeak.FetchAll()[index]),
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ))),
        ));
  }
}
