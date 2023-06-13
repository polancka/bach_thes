import 'package:bach_thes/models/peak.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bach_thes/models/mock_database/mock_peak.dart';
import 'package:bach_thes/globals.dart';
import 'package:bach_thes/controllers/list_of_peaks_controller.dart';
import 'package:bach_thes/utils/styles.dart';

//UI for the list of peaks shown during search (?) function

class SearchPeaks extends StatelessWidget {
  const SearchPeaks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            "Search Slovenian peaks",
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.white12,
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Styles.deepgreen,
                Styles.lightgreen,
                Styles.offwhite
              ], begin: Alignment.bottomRight, end: Alignment.topLeft),
            ),
            child: StreamBuilder(
              stream: db.collection('Peaks').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Text("Loading ...");
                }
                return ListView.separated(
                    separatorBuilder: ((context, index) =>
                        const SizedBox(height: 10)),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) =>
                        buildListItem(context, snapshot.data!.docs[index]));
              },
            )));
  }
}
