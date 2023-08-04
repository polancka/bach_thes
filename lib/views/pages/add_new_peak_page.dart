import 'package:bach_thes/globals.dart';
import 'package:bach_thes/models/peak.dart';
import 'package:bach_thes/utils/styles.dart';
import 'package:bach_thes/views/widgets/reusable_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class addNewPeakPage extends StatefulWidget {
  const addNewPeakPage({super.key});

  @override
  State<addNewPeakPage> createState() => _addNewPeakPageState();
}

class _addNewPeakPageState extends State<addNewPeakPage> {
  int? nextPeakIndex;

  getPeakIndex() async {
    var peakIndex =
        await FirebaseFirestore.instance.collection("Indexes").get();
    int currentPeakIndex = int.parse(peakIndex.docs.first['peakIndex']);
    setState(() {});
    nextPeakIndex = currentPeakIndex;
    // dodaj povečanje indeksa v bazi
  }

  @override
  void initState() {
    // TODO: implement initState
    getPeakIndex();
  }

  final _formPeakKey = GlobalKey<FormState>();

  final _name = TextEditingController();
  final _altitude = TextEditingController();
  final _description = TextEditingController();
  final _urlThumbnail = TextEditingController();
  final _longitude = TextEditingController();
  final _latitude = TextEditingController();
  final _mountainChain = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar("Add a new peak"),
        body: Form(
            key: _formPeakKey,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                child: Column(children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  //Name of the peak
                  TextFormField(
                    controller: _name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: "What is the name of the peak?"),
                  ),
                  //starting point altitude
                  TextFormField(
                    controller: _altitude,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: "What is the peaks altitude?"),
                  ),
                  //altimeters
                  TextFormField(
                    controller: _description,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: "Describe the peak in a few sentences."),
                  ),
                  //altimeters on the way
                  TextFormField(
                    controller: _urlThumbnail,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: "Paste the url for the picture."),
                  ),
                  //difficulty
                  TextFormField(
                    controller: _longitude,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: "What is the longitude of the peak?"),
                  ),
                  //duration
                  TextFormField(
                    controller: _latitude,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: "What is the latitude of the peak?"),
                  ),
                  //description
                  DropdownButtonFormField(
                    isExpanded: true,
                    isDense: true,
                    value: 1,
                    items: const [
                      DropdownMenuItem(
                        child: Text("Julian Alps"),
                        value: 1,
                      ),
                      DropdownMenuItem(child: Text("Karawanks"), value: 2),
                      DropdownMenuItem(
                          child: Text("Kamnik Savinja Alps"), value: 3),
                      DropdownMenuItem(
                          child: Text(
                              "Gorice, Notranjsko and Snežnik mountain range"),
                          value: 4),
                      DropdownMenuItem(
                          child: Text("Pohorje, Dravinjske gorice and Haloze"),
                          value: 5),
                      DropdownMenuItem(
                          child: Text("Ljubljana and Polhograd mountain range"),
                          value: 6),
                      DropdownMenuItem(
                          child: Text(
                              "Jelovica, Škofja Loka and Cerklje mountain range"),
                          value: 7),
                      DropdownMenuItem(child: Text("Prekmurje"), value: 8),
                      DropdownMenuItem(
                          child: Text(
                              "Strojna, Košenjak, Kozjak and Slovenske gorice"),
                          value: 9),
                    ],
                    onChanged: (value) => value,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(backgroundColor:
                          MaterialStateColor.resolveWith((states) {
                        return Styles.deepgreen;
                      })),
                      onPressed: () {
                        if (_formPeakKey.currentState!.validate()) {
                          // If the form is valid, input into database
                          //defualt lat and lang are currently 0.0 and 0.0 because this page will not be used in production
                          addNewPeak(
                              nextPeakIndex,
                              _name.text,
                              int.parse(_altitude.text),
                              _description.text,
                              _urlThumbnail.text,
                              0.0,
                              0.0,
                              _mountainChain.text,
                              _name.text.toLowerCase());
                          incrementPeakIndex(nextPeakIndex);
                          Navigator.pop(context);
                        }
                      },
                      child: const Text("Save"))
                ]),
              ),
            )));
  }
}
