import 'package:bach_thes/models/path.dart';
import 'package:bach_thes/utils/styles.dart';
import 'package:bach_thes/views/widgets/reusable_widgets.dart';
import 'package:flutter/material.dart';

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
  final _difficulty = TextEditingController();
  final _duration = TextEditingController();
  final _description = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                        child: Text("Lahka označena pot"),
                        value: 1,
                      ),
                      DropdownMenuItem(
                          child: Text("Zmerna označena pot"), value: 2),
                      DropdownMenuItem(
                          child: Text("Zahtevna označena pot"), value: 3),
                      DropdownMenuItem(
                          child: Text("Zelo zahtevna označena pot"), value: 4),
                      DropdownMenuItem(child: Text("Brezpotje"), value: 5),
                      DropdownMenuItem(
                          child: Text("Lahka neoznačena steza"), value: 6),
                    ],
                    onChanged: (value) => value,
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
                        labelText: "How long does the hike take?"),
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
                              0,
                              int.parse(_altitude.text),
                              widget.name,
                              int.parse(_altimeters.text),
                              int.parse(_altimetersOnTheWay.text),
                              _difficulty.text,
                              _duration.text,
                              _description.text);
                        }
                        Navigator.pop(context);
                      },
                      child: const Text("Save"))
                ]),
              ),
            )));
  }
}
