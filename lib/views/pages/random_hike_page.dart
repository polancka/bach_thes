import 'package:bach_thes/views/widgets/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:bach_thes/controllers/navigation_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../utils/styles.dart';

class RandomHikePage extends StatefulWidget {
  const RandomHikePage({super.key});

  @override
  State<RandomHikePage> createState() => _RandomHikePageState();
}

class _RandomHikePageState extends State<RandomHikePage> {
  var difficulty = "";
  var duration = 0;
  var mountainChain = "";
  bool hasPath = false;
  bool hasSearched = false;

  getRandomHike(duration, difficulty, mountainChain) async {
    print(duration);
    print(difficulty);
    print(mountainChain);

    var randomHikesQuery = await FirebaseFirestore.instance
        .collection('Paths')
        .where('difficulty', isEqualTo: difficulty)
        .where('mountainChain', isEqualTo: mountainChain)
        .where('duration', isLessThan: duration)
        .get();
    print(randomHikesQuery);
    if (randomHikesQuery.docs.isNotEmpty) {
      setState(() {
        hasPath = true;
      });
    }
    //this function should return path!
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar("Find a random hike"),
        body: Container(
            child: SingleChildScrollView(
                child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: Styles.offwhite,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            "No idea where to go?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Let's see where the random hike picker takes you!",
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Duration",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 5),
                          Container(
                            padding: EdgeInsets.all(15),
                            child: DropdownButtonFormField(
                                borderRadius: BorderRadius.circular(13),
                                focusColor: Colors.white,
                                isExpanded: true,
                                isDense: true,
                                value: 1,
                                items: const [
                                  DropdownMenuItem(
                                    child: Text("Under one hour"),
                                    value: 1,
                                  ),
                                  DropdownMenuItem(
                                      child: Text("Under two hours"), value: 2),
                                  DropdownMenuItem(
                                      child: Text("Under three hours"),
                                      value: 3),
                                  DropdownMenuItem(
                                      child: Text("Three hours or more"),
                                      value: 4)
                                ],
                                onChanged: (value) {
                                  switch (value) {
                                    case 1:
                                      duration = 60;
                                      break;
                                    case 2:
                                      duration = 120;
                                      break;
                                    case 3:
                                      duration = 180;
                                      break;
                                    case 4:
                                      duration = 20000;
                                      break;
                                  }
                                }
                                //add value to a variable
                                ),
                          ),
                          SizedBox(height: 15),
                          const Text(
                            "Difficulty",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 5),
                          Container(
                              padding: EdgeInsets.all(15),
                              child: DropdownButtonFormField(
                                isExpanded: true,
                                isDense: true,
                                value: 1,
                                items: const [
                                  DropdownMenuItem(
                                    child: Text("Easy marked path"),
                                    value: 1,
                                  ),
                                  DropdownMenuItem(
                                      child: Text("Moderate marked path"),
                                      value: 2),
                                  DropdownMenuItem(
                                      child: Text("Difficult marked path"),
                                      value: 3),
                                  DropdownMenuItem(
                                      child: Text("Very difficult marked path"),
                                      value: 4),
                                  DropdownMenuItem(
                                      child: Text("Roadless area"), value: 5),
                                  DropdownMenuItem(
                                      child: Text("Easy unmarked path"),
                                      value: 6),
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
                                        difficulty =
                                            "Very difficult marked path";
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
                              )),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Mountain chain",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 5),
                          Container(
                            padding: EdgeInsets.all(15),
                            child: DropdownButtonFormField(
                              isExpanded: true,
                              isDense: true,
                              value: 1,
                              items: const [
                                DropdownMenuItem(
                                  child: Text("Julian Alps"),
                                  value: 1,
                                ),
                                DropdownMenuItem(
                                    child: Text("Karawanks"), value: 2),
                                DropdownMenuItem(
                                    child: Text("Kamnik Savinja Alps"),
                                    value: 3),
                                DropdownMenuItem(
                                    child: Text(
                                        "Gorice, Notranjsko and Snežnik mountain range"),
                                    value: 4),
                                DropdownMenuItem(
                                    child: Text(
                                        "Pohorje, Dravinjske gorice and Haloze"),
                                    value: 5),
                                DropdownMenuItem(
                                    child: Text(
                                        "Ljubljana and Polhograd mountain range"),
                                    value: 6),
                                DropdownMenuItem(
                                    child: Text(
                                        "Jelovica, Škofja Loka and Cerklje mountain range"),
                                    value: 7),
                                DropdownMenuItem(
                                    child: Text("Prekmurje"), value: 8),
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
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextButton(
                              onPressed: () {
                                hasSearched = true;

                                //function getRandomHike should return a Path object that we can pass to the navigator
                                getRandomHike(
                                    duration, difficulty, mountainChain);
                                /*if (hasPath) {
                                  MyNavigator(context)
                                      .navigateToPathDetail(randomPath);
                                }*/

                                //fetch a ranfdom hike with these parameters
                                //navigate to that path page
                              },
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(13))),
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith(
                                          (states) {
                                    return Styles.deepgreen;
                                  })),
                              child: Text("Find!",
                                  style: TextStyle(color: Colors.white))),
                          hasSearched && !hasPath
                              ? Text(
                                  "Sorry! No current paths match these parameters!")
                              : Text("")
                        ],
                      )),
                ),
              ),
            )
          ],
        ))));
  }
}
