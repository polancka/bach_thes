import 'package:flutter/material.dart';
import 'package:bach_thes/utils/styles.dart';

class MountainCard extends StatelessWidget {
  const MountainCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 30,
        width: 120,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Styles.deepgreen,
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Container(
              child: Image.asset('lib/utils/images/profile_back.png'),
            ),
            Container(
              height: 30,
              decoration: BoxDecoration(color: Colors.white),
              child: Center(child: Text("Testno ime")),
            )
          ],
        ),
      ),
    );
  }
}
