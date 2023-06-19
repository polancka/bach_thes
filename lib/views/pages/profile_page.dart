import 'package:bach_thes/views/widgets/booklet_widget.dart';
import 'package:bach_thes/views/widgets/mountain_card.dart';
import 'package:flutter/material.dart';
import 'package:bach_thes/utils/styles.dart';

/* UI for showing users profile page. it shows their picture, username, 
level, number of points on a progress bar and their booklet. The booklet itself
 consists of recorderd hikes and achieved peaks and badges. Both parts of the 
 booklet are clickable. They lead to new pages with all possible peaks.*/

class ProfilePage extends StatelessWidget {
  final List achievedPeaks = [];
  final List achievedBadges = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: 25,
        ),
        CircleAvatar(
          backgroundColor: Styles.lightgreen,
          radius: 50,
          child: Image.asset('lib/utils/images/gore.png'),
        ),
        SizedBox(
          height: 20,
        ),
        Center(
            child: Container(
          child: Text("Ana Polančec", style: Styles.headerLarge),
        )),
        SizedBox(
          height: 20,
        ),
        renderBooklet()
      ],
    ));
  }
}

  /*return Scaffold(
      body: Column(
        children: [
          //background top picture
          Image.asset("lib/utils/images/profile_back.png"),
          SizedBox(height: 20),
          //user avatar
          //usrt name
          //user level
          //user progress bar with points
          //user Booklet (user id)
          BookletWidget()
        ],
      ),
    );*/

