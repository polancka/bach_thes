import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationModel with ChangeNotifier {
  addUser(String email, String password) async {
    try {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        //add navigation to home page
      }).onError((error, stackTrace) {
        print("Error ${error.toString()}");
      });
    } on FirebaseException catch (e) {
      print(e);
    }
    notifyListeners();
  }
}
