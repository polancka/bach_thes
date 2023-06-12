import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bach_thes/models/peak.dart';
import 'package:bach_thes/controllers/peak_detail_controller.dart';
import 'dart:developer';

//make prettier UI
//UI for the detail page of a specific peak. List possible paths.

class PeakDetail extends StatelessWidget {
  final DocumentSnapshot document;
  PeakDetail(this.document);

  @override
  Widget build(BuildContext context) {
    log("in peak detail build function");
    return Scaffold(
        appBar: AppBar(
          title: Text(document['name']),
          backgroundColor: Colors.pinkAccent,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: renderBody(context, document),
        ));
  }
}
