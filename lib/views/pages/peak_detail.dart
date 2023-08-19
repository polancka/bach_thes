import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bach_thes/controllers/peak_detail_controller.dart';
import 'package:bach_thes/utils/styles.dart';

/* UI for more information about the chosen peak. It displays the photo, name,
 description and possible paths leading up to the peak.*/

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
        .where('id', isEqualTo: widget.document['id'])
        .get();

    setState(() {
      _allPaths = List.from(paths.docs);
    });

    return "complete";
  }

  @override
  void initState() {
    super.initState();
    getPaths();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Peak", style: TextStyle(color: Styles.deepgreen)),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Styles.deepgreen),
        ),
        extendBodyBehindAppBar: false,
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
