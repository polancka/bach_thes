import 'package:bach_thes/controllers/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationController {
  String _name;
  String _email;
  String _password;
  String _hikerLevel;

  RegistrationController(
      this._name, this._email, this._password, this._hikerLevel);

  Future<void> addUser() async {
    try {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password)
          .then((value) {})
          .onError((error, stackTrace) {
        print("Error ${error.toString()}");
      });
    } on FirebaseException catch (e) {
      print(e);
    }
  }
}
