import 'package:bach_thes/controllers/navigation_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:bach_thes/models/peak.dart';
import 'dart:developer';
import 'package:bach_thes/globals.dart';
import 'package:bach_thes/main.dart';
import 'package:bach_thes/utils/styles.dart';
import 'package:bach_thes/views/widgets/reusable_widgets.dart';

//UI for landing page

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white12,
        body: Container(
            width: w,
            height: h,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Styles.deepgreen,
                Styles.lightgreen,
                Styles.offwhite
              ], begin: Alignment.bottomRight, end: Alignment.topLeft),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, h * 0.1, 20, 0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Welcome",
                              style: TextStyle(
                                  color: Styles.deepgreen,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25))
                        ],
                      ),
                      SizedBox(
                        height: h * 0.1,
                      ),
                      Row(
                        children: [
                          TextButton.icon(
                              onPressed:
                                  MyNavigator(context).NavigateToSearchPeaks,
                              icon: Icon(Icons.hiking_outlined,
                                  color: Colors.white),
                              label: Text(
                                "Search Peaks",
                                style: TextStyle(color: Colors.white),
                              )),
                          //landingPageTile(context, "Search peaks and paths"),
                          SizedBox(
                            width: 10,
                          ),
                          //landingPageTile(context, "My booklet")
                          //second tile
                        ],
                      ),
                      //SizedBox(height: 10),
                      /*Row(
                        children: [
                          landingPageTile(context, "My profile"),
                          SizedBox(
                            width: 10,
                          ),
                          landingPageTile(context, "Look up on the map")
                        ],
                      )*/
                    ]),
              ),
            )),
      ),
    );
  }
}

Future<void> readPeaks() async {
  await db.collection("Peaks").get().then((event) {
    for (var doc in event.docs) {
      log("${doc.id} => ${doc.data()}");
    }
  });
}

//function for adding to the database
Future<void> uploadingData(
  int _peakId,
  String _peakName,
  int _peakAltitude,
  String _peakDescription,
  String _urlThumbnail,
) async {
  await db.collection("Peaks").add({
    'id': _peakId,
    'name': _peakName,
    'altitude': _peakAltitude,
    'description': _peakDescription,
    'urlThumbnail': _urlThumbnail,
  });
}

/*uploadingData(
        1,
        "Grintovec",
        2558,
        "Grintovec je najvišji vrh Kamniških in Savinjskih Alp. Nahaja se nad dolino Kamniške Bistrice, Suhega dola in nad dolino Ravenske Kočne. Razgled z vrha je najlepši proti Jezerski in Kokrski Kočni na zahodni strani, na severu se lepo vidi Jezerska dolina in vrhovi nad Jezerskim proti vzhodu pa se vidi greben Grintovcev od Dolgega Hrbta, čez Štruco do Skute. Proti jugu pa se vidi Kalški greben in v ozadju Ljubljanska kotlina. Vrh ima vpisno knjigo in žig.",
        "https://www.hribi.net/Gora/p6250106medium5xm.jpg");
    uploadingData(
        2,
        "Skuta",
        2532,
        "Skuta je 2532 m visoka gora, ki se nahaja v osrčju Kamniško Savinjskih Alp. Z vrha, na katerem je vpisna skrinjica in žig, se nam odpre lep razgled na najvišje vrhove Kamniško Savinjskih Alp.",
        "https://www.hribi.net/slike11/P106066849386308.jpg");
    uploadingData(
        3,
        "Ojstrica",
        2350,
        "Ojstrica, katera ime je dobila po svoji ostri obliki, se strmo dviga nad Korošico, Logarsko dolino in Robanovim kotom. Z vrha, na katerem se nahaja vpisna skrinjica z žigom, se nam odpre lep razgled na najvišje vrhove Kamniško Savinjskih Alp.",
        "https://www.hribi.net/slike1/Ojstrica%20036102960.jpg"); */
