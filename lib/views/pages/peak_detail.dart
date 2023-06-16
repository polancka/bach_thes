import 'package:bach_thes/controllers/navigation_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bach_thes/models/peak.dart';
import 'package:bach_thes/controllers/peak_detail_controller.dart';
import 'dart:developer';
import 'package:bach_thes/utils/styles.dart';

//make prettier UI
//UI for the detail page of a specific peak. List possible paths.

class PeakDetail extends StatefulWidget {
  final DocumentSnapshot document;
  PeakDetail(this.document);

  @override
  State<PeakDetail> createState() => _PeakDetailState();
}

class _PeakDetailState extends State<PeakDetail> {
  List _allPaths = [];

  getPaths() async {
    var paths = await FirebaseFirestore.instance
        .collection('Paths')
        .where('finishPointName', isEqualTo: widget.document['name'])
        .get();

    setState(() {
      _allPaths = List.from(paths.docs);
      print(_allPaths);
    });

    // print("FROM SET STATE" + _allPaths.toString());
    return "complete";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPaths();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(widget.document['name']),
          backgroundColor: Colors.transparent,
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
                child: Column(children: [
              Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children:
                          renderBody(context, widget.document, _allPaths)))
            ]))));
  }
}
