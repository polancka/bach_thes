import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bach_thes/utils/styles.dart';

//This page serves as a digital booklet. In it all the peaks in the databases collection 'Peaks' are shown.
//if the current user has a hike recording that achoeved a peak, that peak willl be colored in the booklet.
// The peaks that have not yet been achieved are greyed out. Peaks are grouped based on their mountain chain.

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
  List prekmurje = [];
  List sloGorice = [];
  List pohorje = [];
  List cerklje = [];
  List ljubljana = [];
  List gorice = [];

  List<String> achievedPeaks = [];
  List _julian = [];
  List _karawanks = [];
  List _kamnikSavinja = [];
  List _prekmurje = [];
  List _sloGorice = [];
  List _pohorje = [];
  List _cerklje = [];
  List _ljubljana = [];
  List _gorice = [];
  String currentUserId = FirebaseAuth.instance.currentUser!.uid.toString();

  getAchievedPeaks() async {
    var achievedPeaksQuery = await FirebaseFirestore.instance
        .collection('RHikes')
        .where('hikerId', isEqualTo: currentUserId)
        .where('acheived', isEqualTo: true)
        .get();

    for (var hike in achievedPeaksQuery.docs) {
      achievedPeaks.add(hike['endPointName']);
    }
  }

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

        case "Gorice, Notranjsko and Snežnik mountain range":
          {
            _gorice.add(docSnap);
          }
          break;

        case "Pohorje, Dravinjske gorice and Haloze":
          {
            _pohorje.add(docSnap);
          }
          break;

        case "Ljubljana and Polhograd mountain range":
          {
            _ljubljana.add(docSnap);
          }
          break;

        case "Jelovica, Škofja Loka and Cerklje mountain range":
          {
            _cerklje.add(docSnap);
          }
          break;

        case "Prekmurje":
          {
            _prekmurje.add(docSnap);
          }
          break;

        case "Strojna, Košenjak, Kozjak and Slovenske gorice":
          {
            _sloGorice.add(docSnap);
          }
          break;
      }
    }

    setState(() {
      karawanks = List.from(_karawanks);
      julianAlps = List.from(_julian);
      kamnikSavinjaAlps = List.from(_kamnikSavinja);
      prekmurje = List.from(_prekmurje);
      sloGorice = List.from(_sloGorice);
      pohorje = List.from(_pohorje);
      cerklje = List.from(_cerklje);
      ljubljana = List.from(_ljubljana);
      gorice = List.from(_gorice);
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
    getAchievedPeaks();
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
          SizedBox(
            height: 10,
          ),
          Center(
              child: Text(
            "Gorice, Notranjsko and Snežnik mountain range",
            textAlign: TextAlign.center,
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
            children: renderGridTiles(gorice, achievedPeaks),
          ))),
          SizedBox(
            height: 10,
          ),
          Center(
              child: Text(
            "Pohorje, Dravinjske gorice and Haloze",
            textAlign: TextAlign.center,
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
            children: renderGridTiles(pohorje, achievedPeaks),
          ))),
          SizedBox(
            height: 10,
          ),
          Center(
              child: Text(
            "Ljubljana and Polhograd mountain range",
            textAlign: TextAlign.center,
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
            children: renderGridTiles(ljubljana, achievedPeaks),
          ))),
          SizedBox(
            height: 10,
          ),
          Center(
              child: Text(
            "Jelovica, Škofja Loka and Cerklje mountain range",
            textAlign: TextAlign.center,
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
            children: renderGridTiles(cerklje, achievedPeaks),
          ))),
          SizedBox(
            height: 10,
          ),
          Center(
              child: Text(
            "Prekmurje",
            textAlign: TextAlign.center,
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
            children: renderGridTiles(prekmurje, achievedPeaks),
          ))),
          SizedBox(
            height: 10,
          ),
          Center(
              child: Text(
            "Strojna, Košenjak, Kozjak and Slovenske gorice",
            textAlign: TextAlign.center,
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
            children: renderGridTiles(sloGorice, achievedPeaks),
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
