import 'package:flutter/material.dart';

/* UI for showing users profile page. it shows their picture, username, 
level, number of points on a progress bar and their booklet. The booklet itself
 consists of recorderd hikes and achieved peaks and badges. Both parts of the 
 booklet are clickable. They lead to new pages with all possible peaks.*/

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: Text("This is profile page"),
    ));
  }
}
