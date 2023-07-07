import 'package:flutter/material.dart';
import 'package:bach_thes/utils/styles.dart';

class PointsPage extends StatefulWidget {
  String action;
  int points;
  PointsPage({required this.action, required this.points});

  @override
  State<PointsPage> createState() => _PointsPageState();
}

class _PointsPageState extends State<PointsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            color: Colors.purple,
            image: DecorationImage(
                image: AssetImage('lib/utils/images/points_conf.png'),
                fit: BoxFit.cover)),
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            CloseButton(),
            SizedBox(
              height: 35,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: Text("Congratulations!",
                        style: TextStyle(
                            color: Styles.deepgreen,
                            fontSize: 25,
                            fontWeight: FontWeight.w700))),
              ],
            ),
            SizedBox(height: 20),
            Padding(
                padding: EdgeInsets.all(25),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Container(
                            decoration: BoxDecoration(color: Colors.white),
                            child: Text(
                                "By ${widget.action} you earned ${widget.points} points! ",
                                style: TextStyle(
                                    color: Styles.deepgreen,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500))))
                  ],
                ))
          ],
        ),
      ),
    ));
  }
}
