import 'package:flutter/material.dart';
import 'package:bach_thes/models/peak.dart';
import 'package:bach_thes/controllers/peak_detail_controller.dart';
import 'dart:developer';

class PeakDetail extends StatelessWidget {
  final Peak peak;
  PeakDetail(this.peak);

  @override
  Widget build(BuildContext context) {
    log("in peak detail build function");
    return Scaffold(
        appBar: AppBar(
          title: Text(peak.name),
          backgroundColor: Colors.pinkAccent,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: renderBody(context, peak),
        ));
  }
}
