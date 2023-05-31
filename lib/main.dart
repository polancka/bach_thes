import 'package:bach_thes/pages/authentication_page.dart';
import 'package:flutter/material.dart';
//import 'models/peak.dart';
//import 'mock_database/mock_peak.dart';
//import 'package:bach_thes/peak_list';
import 'pages/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //final List<Peak> mockPeaks = MockPeak.FetchAll();
  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthenticationPage(),
    );
  }
}
