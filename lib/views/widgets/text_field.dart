import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PersonalizedTextInputField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final controller;

  PersonalizedTextInputField(
      {super.key,
      required this.hintText,
      required this.obscureText,
      required this.controller});

  @override
  Widget build(BuildContext contex) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: TextField(
          obscureText: obscureText,
          decoration: InputDecoration(
              hintText: hintText,
              fillColor: Colors.white,
              filled: true,
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black))),
        ));
  }
}
