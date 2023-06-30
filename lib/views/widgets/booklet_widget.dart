/*import 'package:bach_thes/views/widgets/mountain_card.dart';
import 'package:flutter/material.dart';
import 'horizontal_scroll_peaks.dart';
import 'package:bach_thes/utils/styles.dart';

Widget renderBooklet() {
  return Container(
      child: Column(
    children: [
      Center(
        child: Container(
            child: Text("My booklet",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))),
      ),
      SizedBox(
        height: 20,
      ),
      Center(
        child: Container(child: Text("Peaks", style: Styles.navbarTitle)),
      ),
      SizedBox(
        height: 20,
      ),
      Expanded(
          child: ListView.builder(
        itemBuilder: (context, index) {
          return MountainCard();
        },
        itemCount: 7,
        scrollDirection: Axis.horizontal,
      )),
      Center(
          child: Container(
        child: Text("Badges", style: Styles.navbarTitle),
      )),
      SizedBox(
        height: 20,
      ),
      Expanded(
          child: ListView.builder(
        itemBuilder: (context, index) {
          return MountainCard();
        },
        itemCount: 7,
        scrollDirection: Axis.horizontal,
      ))
    ],
  ));
}*/
