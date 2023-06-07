import 'package:bach_thes/views/pages/list_of_peaks.dart';
import 'package:bach_thes/views/pages/registration_page.dart';
import 'package:flutter/material.dart';
//import 'models/peak.dart';
//import 'mock_database/mock_peak.dart';
//import 'package:bach_thes/peak_list';
import 'package:bach_thes/views/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'views/pages/home_page.dart';
import 'package:bach_thes/views/pages/forgoten_password_page.dart';

void main() async {
  //ensure widget binding before running the aplication
  WidgetsFlutterBinding.ensureInitialized();

  //initializing Firebase
  try {
    await Firebase.initializeApp();
  } on FirebaseException catch (e) {
    print(e);
  }

  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
