import 'package:bach_thes/models/path.dart';
import 'package:bach_thes/utils/styles.dart';
import 'package:bach_thes/views/widgets/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bach_thes/controllers/navigation_controller.dart';

class addNewPathPage extends StatefulWidget {
  final int id;
  final String name;
  const addNewPathPage({required this.name, required this.id});

  @override
  State<addNewPathPage> createState() => _addNewPathPageState();
}

class _addNewPathPageState extends State<addNewPathPage> {
  final _formKey = GlobalKey<FormState>();

  final _pathName = TextEditingController();
  final _startingPoint = TextEditingController();
  final _altitude = TextEditingController();
  final _altimeters = TextEditingController();
  final _altimetersOnTheWay = TextEditingController();

  final _duration = TextEditingController();
  final _description = TextEditingController();
  var nextPathIndex = 0;

  getPathIndex() async {
    var pathIndex =
        await FirebaseFirestore.instance.collection("Indexes").get();
    int currentPathIndex = int.parse(pathIndex.docs.first['pathIndex']);
    setState(() {
      nextPathIndex = currentPathIndex + 1;
    });

    var collection = await FirebaseFirestore.instance
        .collection('Indexes')
        .doc('2SZAPriyUMk2SegoD9Io')
        .update({'pathIndex': nextPathIndex}).then(
            (value) => print("DocumentSnapshot successfully updated!"),
            onError: (e) => print("Error updating document $e"));
  }

  @override
  void initState() {
    getPathIndex();
  }

  @override
  Widget build(BuildContext context) {
    var difficulty = "";
    var mountainChain = "";
    return Scaffold(
        appBar: myAppBar("Add a new path to ${widget.name}"),
        body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                child: Column(children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  //Name of the path
                  TextFormField(
                    controller: _pathName,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: "What is the name of the path?"),
                  ),
                  //starting point
                  TextFormField(
                    controller: _startingPoint,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: "Where does the path start?"),
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
                        labelText: "What is the starting point altitude?"),
                  ),
                  //altimeters
                  TextFormField(
                    controller: _altimeters,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: "What is altitude difference?"),
                  ),
                  //altimeters on the way
                  TextFormField(
                    controller: _altimetersOnTheWay,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText:
                            "How many altimeters do you make on the way?"),
                  ),
                  //difficulty
                  DropdownButtonFormField(
                    isExpanded: true,
                    isDense: true,
                    value: 1,
                    items: const [
                      DropdownMenuItem(
                        child: Text("Easy marked path"),
                        value: 1,
                      ),
                      DropdownMenuItem(
                          child: Text("Moderate marked path"), value: 2),
                      DropdownMenuItem(
                          child: Text("Difficult marked path"), value: 3),
                      DropdownMenuItem(
                          child: Text("Very difficult marked path"), value: 4),
                      DropdownMenuItem(child: Text("Roadless area"), value: 5),
                      DropdownMenuItem(
                          child: Text("Easy unmarked path"), value: 6),
                    ],
                    onChanged: (value) {
                      setState(() {
                        switch (value) {
                          case 1:
                            difficulty = "Easy marked path";
                            break;
                          case 2:
                            difficulty = "Moderate marked path";
                            break;
                          case 3:
                            difficulty = "Difficult marked path";
                            break;
                          case 4:
                            difficulty = "Very difficult marked path";
                            break;
                          case 5:
                            difficulty = "Roadless area";
                            break;
                          case 6:
                            difficulty = "Easy unmarked path";
                            break;
                        }
                      });
                    },
                  ),
                  //mountainChain
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

                  //duration
                  TextFormField(
                    controller: _duration,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: "How long does the hike take (in minutes)?"),
                  ),
                  //description
                  TextFormField(
                    controller: _description,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: "Describe the path in a few sentences."),
                  ),
                  ElevatedButton(
                      style: ButtonStyle(backgroundColor:
                          MaterialStateColor.resolveWith((states) {
                        return Styles.deepgreen;
                      })),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, input into database
                          addNewPath(
                              widget.id,
                              _pathName.text,
                              _startingPoint.text,
                              nextPathIndex,
                              int.parse(_altitude.text),
                              widget.name,
                              int.parse(_altimeters.text),
                              int.parse(_altimetersOnTheWay.text),
                              difficulty,
                              int.parse(_duration.text),
                              _description.text,
                              mountainChain);
                        }
                        MyNavigator(context)
                            .navigateToPointsPage("adding a new path", 15, []);
                      },
                      child: const Text("Save"))
                ]),
              ),
            )));
  }
}
