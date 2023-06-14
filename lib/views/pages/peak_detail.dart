import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bach_thes/models/peak.dart';
import 'package:bach_thes/controllers/peak_detail_controller.dart';
import 'dart:developer';
import 'package:bach_thes/utils/styles.dart';

//make prettier UI
//UI for the detail page of a specific peak. List possible paths.

class PeakDetail extends StatelessWidget {
  final DocumentSnapshot document;
  PeakDetail(this.document);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(document['name']),
          backgroundColor: Colors.transparent,
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Styles.deepgreen,
                Styles.lightgreen,
                Styles.offwhite
              ], begin: Alignment.bottomRight, end: Alignment.topLeft),
            ),
            child: SingleChildScrollView(
                child: Column(children: [
              Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: renderBody(context, document),
                  ))
            ]))));
  }
}
