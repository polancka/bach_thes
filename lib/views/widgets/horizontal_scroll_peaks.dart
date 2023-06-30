import 'package:bach_thes/controllers/home_controller.dart';
import 'package:bach_thes/views/widgets/mountain_card.dart';
import 'package:flutter/material.dart';

class HorizontalScrollPeaks extends StatelessWidget {
  const HorizontalScrollPeaks({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, int> suggestions = {"Triglav": 2345};
    return Container(
        height: 120,
        width: 120,
        child: ListView.builder(
            itemCount: 3,
            itemBuilder: (BuildContext context, int index) =>
                renderSugestions(suggestions)));
  }
}
