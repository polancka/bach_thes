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
    searcResultsList();
  }

  //if possible at some point move this function to the list_of_peaks controller
  searcResultsList() {
    var showResults = [];
    if (_searchController.text != "") {
      //we have a search parameter
      for (var peakSnapshot in _allPeaks) {
        var name = peakSnapshot['name'].toString().toLowerCase();
        if (name.contains(_searchController.text.toLowerCase())) {
          showResults.add(peakSnapshot);
        }
      }
    } else {
      showResults = List.from(_allPeaks);
    }
    setState(() {
      _resultsList = showResults;
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  getPeaksStreamSnapshots() async {
    //final uid = await Provider.of(context).auth.getCurrentUID();
    var data = await FirebaseFirestore.instance
        .collection('Peaks')
        .orderBy('sortValue')
        .get();

    setState(() {
      _allPeaks = data.docs;
    });
    searcResultsList();
    return "complete";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      TextField(
        controller: _searchController,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
        ),
      ),
      Expanded(
          child: Container(
              child: ListView.builder(
        itemCount: _resultsList.length,
        itemBuilder: (BuildContext context, int index) =>
            buildListItem(context, _resultsList[index]),
      )))
    ]));
  }
}
