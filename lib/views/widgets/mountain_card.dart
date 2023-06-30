import 'package:flutter/material.dart';
import 'package:bach_thes/utils/styles.dart';

class MountainCard extends StatelessWidget {
  String name;
  int altitude;
  //maybe add reference and make it clickable
  MountainCard(this.name, this.altitude);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
            margin: EdgeInsets.all(3),
            color: Styles.deepgreen.withOpacity(0.7),
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(20)),
            child: ListTile(
              title: Text(
                name,
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                altitude.toString(),
                style: TextStyle(color: Colors.white),
              ),
              trailing: Icon(
                Icons.keyboard_double_arrow_right_outlined,
                color: Colors.white,
              ),
            )));
  }
}
