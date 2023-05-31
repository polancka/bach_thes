import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String imageUrl;
  SquareTile({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    /*return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Image.asset(
        imageUrl,
        height: 40,
      ),
    );*/

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[200],
      ),
      child: Image.asset(
        imageUrl,
        height: 60,
      ),
    );
  }
}
