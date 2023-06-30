//Controller for the landing page, provides navigation to all functionalities of the application
import 'package:bach_thes/views/widgets/mountain_card.dart';
import 'package:flutter/material.dart';

renderSugestions(Map<String, int> suggestions) {
  List<Widget> results = [];
  for (int i = 0; i < suggestions.length; i++) {
    results.add(MountainCard("Triglav", 2675));
  }

  return results;
}
