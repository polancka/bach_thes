import 'package:flutter/material.dart';

class PersonalButton extends StatelessWidget {
  final String text;
  final Function()? onTap;

  const PersonalButton({required this.text, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              text,
              style: TextStyle(color: Colors.white),
            )));
  }
}
