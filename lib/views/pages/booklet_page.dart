import 'package:bach_thes/controllers/list_of_peaks_controller.dart';
import 'package:bach_thes/globals.dart';
import 'package:bach_thes/views/widgets/reusable_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bach_thes/models/peak.dart';
import 'package:bach_thes/utils/styles.dart';
import 'package:bach_thes/models/hiker.dart';
import 'package:bach_thes/controllers/navigation_controller.dart';

class BookletPage extends StatefulWidget {
  const BookletPage({super.key});

  @override
  State<BookletPage> createState() => _BookletPageState();
}

class _BookletPageState extends State<BookletPage> {
  List listPeaks = [];
  List karawanks = [];
  List julianAlps = [];
  List kamnikSavinjaAlps = [];
  List<String> achievedPeaks = currentHiker.achievedPeaks;
  List _julian = [];
  List _karawanks = [];
  List _kamnikSavinja = [];

  getPeaks() async {
    var _allPeaks = await FirebaseFirestore.instance.collection('Peaks').get();

    for (var docSnap in _allPeaks.docs) {
      switch (docSnap['mountainChain'].toString()) {
        case "Julian Alps":
          {
            _julian.add(docSnap);
          }
          break;

        case "Karawanks":
          {
            _karawanks.add(docSnap);
          }
          break;

        case "Kamnik Savinja Alps":
          {
            _kamnikSavinja.add(docSnap);
          }
          break;
      }
    }

    //print(currentHiker.getAchievedPeaks());
    setState(() {
      karawanks = List.from(_karawanks);
      julianAlps = List.from(_julian);
      kamnikSavinjaAlps = List.from(_kamnikSavinja);
    });

    return "complete";
  }

  List<Widget> renderGridTiles(
      List<dynamic> listPeaks, List<String> achievedPeaks) {
    List<Widget> allTiles = [];

    for (var docSnapshot in listPeaks) {
      if (achievedPeaks.contains(docSnapshot['name'])) {
        allTiles.add(GridTile(
            child: colorfulMountainTile(docSnapshot['name'].toString(),
                docSnapshot['urlThumbnail'].toString())));
      } else {
        allTiles.add(
          GridTile(
            child: greyedOutMountainTile(docSnapshot['name'].toString(),
                docSnapshot['urlThumbnail'].toString()),
          ),
        );
      }
    }
    return allTiles;
  }

  @override
  void initState() {
    super.initState();
    getPeaks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Center(
              child: Text(
            "Julian Alps",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          )),
          SizedBox(
            height: 10,
          ),
          Container(
              child: IgnorePointer(
                  child: GridView.count(
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            shrinkWrap: true,
            // Create a grid with 2 columns. If you change the scrollDirection to
            // horizontal, this produces 2 rows.
            crossAxisCount: 4,
            // Generate 100 widgets that display their index in the List.
            children: renderGridTiles(julianAlps, achievedPeaks),
          ))),
          SizedBox(
            height: 10,
          ),
          Center(
              child: Text(
            "Kamnik-Savinja Alps",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          )),
          SizedBox(
            height: 10,
          ),
          Container(
              child: IgnorePointer(
                  child: GridView.count(
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            shrinkWrap: true,
            // Create a grid with 2 columns. If you change the scrollDirection to
            // horizontal, this produces 2 rows.
            crossAxisCount: 4,
            // Generate 100 widgets that display their index in the List.
            children: renderGridTiles(kamnikSavinjaAlps, achievedPeaks),
          ))),
          SizedBox(
            height: 10,
          ),
          Center(
              child: Text(
            "Karawanks",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          )),
          SizedBox(
            height: 10,
          ),
          Container(
              child: IgnorePointer(
                  child: GridView.count(
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            shrinkWrap: true,
            // Create a grid with 2 columns. If you change the scrollDirection to
            // horizontal, this produces 2 rows.
            crossAxisCount: 4,
            // Generate 100 widgets that display their index in the List.
            children: renderGridTiles(karawanks, achievedPeaks),
          ))),
        ],
      ),
    )));
  }
}

//make tile for every peak in database and add it to the list

Widget greyedOutMountainTile(String name, String urlThumbnail) {
  return Container(
    foregroundDecoration: BoxDecoration(
      color: Colors.grey,
      backgroundBlendMode: BlendMode.saturation,
    ),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black, width: 0.8),
      borderRadius: BorderRadius.circular(8),
      color: Colors.grey.withOpacity(0.3),
    ),
    child: Center(
      child: Column(
        children: [
          Expanded(
            child: Image.network(
              urlThumbnail,
            ),
          ),
          Expanded(
              child: Center(
            child: Text(
              "${name}",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ))
        ],
      ),
    ),
  );
}

Widget colorfulMountainTile(String name, String urlThumbnail) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: Styles.lightgreen, width: 1),
      borderRadius: BorderRadius.circular(8),
      color: Color.fromARGB(255, 134, 230, 138).withOpacity(0.8),
    ),
    child: Center(
      child: Column(
        children: [
          Expanded(
            child: Image.network(
              urlThumbnail,
            ),
          ),
          Expanded(
              child: Center(
            child: Text(
              "${name}",
              style: TextStyle(
                  color: Color.fromARGB(255, 42, 98, 44),
                  fontWeight: FontWeight.w600),
            ),
          ))
        ],
      ),
    ),
  );
}

/**getPeaks() async {
    var _julian = await FirebaseFirestore.instance
        .collection('Peaks')
        .where('mountainChain', isEqualTo: "Julian Alps")
        .get();

    var _kamnikSavinja = await FirebaseFirestore.instance
        .collection('Peaks')
        .where('mountainChain', isEqualTo: "Kamnik Savinja Alps")
        .get();

    var _karawanks = await FirebaseFirestore.instance
        .collection('Peaks')
        .where('mountainChain', isEqualTo: "Karawanks")
        .get();

    setState(() {
      karawanks = List.from(_karawanks.docs);
      julianAlps = List.from(_julian.docs);
      kamnikSavinjaAlps = List.from(_kamnikSavinja.docs);
    });

    return "complete";
  } */
