import 'package:bach_thes/globals.dart';
import 'package:bach_thes/models/peak.dart';
import 'package:bach_thes/utils/styles.dart';
import 'package:bach_thes/views/widgets/reusable_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bach_thes/controllers/navigation_controller.dart';

//This page serves as UI for adding a new peak to the databse.
//User fills out all the information, the path gets stored in Firebase Firestor collection 'Peaks'
//and user recieves points as a reward.

class addNewPeakPage extends StatefulWidget {
  const addNewPeakPage({super.key});

  @override
  State<addNewPeakPage> createState() => _addNewPeakPageState();
}

class _addNewPeakPageState extends State<addNewPeakPage> {
  int? nextPeakIndex;
  var mountainChain = "";

  getPeakIndex() async {
    var peakIndex =
        await FirebaseFirestore.instance.collection("Indexes").get();
    int currentPeakIndex = peakIndex.docs.first['peakIndex'];
    setState(() {
      nextPeakIndex = currentPeakIndex + 1;
    });
    // dodaj povečanje indeksa v bazi

    var collection = await FirebaseFirestore.instance
        .collection('Indexes')
        .doc('2SZAPriyUMk2SegoD9Io')
        .update({'peakIndex': nextPeakIndex}).then(
            (value) => print("DocumentSnapshot successfully updated!"),
            onError: (e) => print("Error updating document $e"));
  }

  @override
  void initState() {
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
                    onChanged: (value) {
                      setState(() {
                        switch (value) {
                          case 1:
                            mountainChain = "Julian Alps";
                            break;
                          case 2:
                            mountainChain = "Karawanks";
                            break;
                          case 3:
                            mountainChain = "Kamnik Savinja Alps";
                            break;
                          case 4:
                            mountainChain =
                                "Gorice, Notranjsko and Snežnik mountain range";
                            break;
                          case 5:
                            mountainChain =
                                "Pohorje, Dravinjske gorice and Haloze";
                            break;
                          case 6:
                            mountainChain =
                                "Ljubljana and Polhograd mountain range";
                            break;
                          case 7:
                            mountainChain =
                                "Jelovica, Škofja Loka and Cerklje mountain range";
                            break;
                          case 8:
                            mountainChain = "Prekmurje";
                            break;
                          case 9:
                            mountainChain =
                                "Strojna, Košenjak, Kozjak and Slovenske gorice";
                            break;
                        }
                      });
                    },
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
                              double.parse(_longitude.text),
                              double.parse(_latitude.text),
                              mountainChain,
                              _name.text.toLowerCase());
                          incrementPeakIndex(nextPeakIndex);
                          MyNavigator(context)
                              .navigateToPointsPage("adding a new peak", 15);
                        }
                      },
                      child: const Text("Save"))
                ]),
              ),
            )));
  }
}
