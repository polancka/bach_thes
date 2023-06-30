import 'package:flutter/material.dart';

//import 'package:flutter_map/plugin_api.dart'; // Only import if required functionality is not exposed by default

/*The page displays a map featuring users current position and any peaks nearby*/

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("This is map page")),
    );
  }
}
