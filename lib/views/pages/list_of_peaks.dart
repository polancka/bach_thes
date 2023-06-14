import 'dart:developer';

import 'package:bach_thes/models/peak.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bach_thes/models/mock_database/mock_peak.dart';
import 'package:bach_thes/globals.dart';
import 'package:bach_thes/controllers/list_of_peaks_controller.dart';
import 'package:bach_thes/utils/styles.dart';
import 'package:provider/provider.dart';

//UI for the list of peaks shown during search (?) function

class SearchPeaks extends StatefulWidget {
  const SearchPeaks({super.key});

  @override
  State<SearchPeaks> createState() => _SearchPeaksState();
}

class _SearchPeaksState extends State<SearchPeaks> {
  final TextEditingController _searchController = TextEditingController();

  List _allPeaks = [];
  List _resultsList = [];

  late Future resultsLoaded;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resultsLoaded = getPeaksStreamSnapshots();
  }

  _onSearchChanged() {
    print(_searchController.text);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  getPeaksStreamSnapshots() async {
    //final uid = await Provider.of(context).auth.getCurrentUID();
    var data = await FirebaseFirestore.instance.collection('Peaks').get();
    setState(() {
      _allPeaks = data.docs;
    });
    return "complete";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Styles.deepgreen.withOpacity(0.9),
          title: Text(
            "Search Slovenian peaks",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Column(children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
            ),
          ),
          Expanded(
              child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Styles.deepgreen,
                      Styles.lightgreen,
                      Styles.offwhite
                    ], begin: Alignment.bottomRight, end: Alignment.topLeft),
                  ),
                  child: ListView.builder(
                    itemCount: _allPeaks.length,
                    itemBuilder: (BuildContext context, int index) =>
                        buildListItem(context, _allPeaks[index]),
                  )))
        ]));
  }
}
