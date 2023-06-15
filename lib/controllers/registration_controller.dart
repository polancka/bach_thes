import 'package:bach_thes/controllers/navigation_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:bach_thes/models/hiker.dart';

//Class that registers a new user - adds a new entry to the Firebase Authentication database

class RegistrationController {
  String _email;
  String _password;
  String _username;

  RegistrationController(this._email, this._password, this._username);

  Future<void> createNewUser(context) async {
    try {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password)
          .then((value) {
        MyNavigator(context).NavigateToLogin();
      });
    } on FirebaseException catch (e) {
      log(e.toString());
    }

    addHiker(_email, _username);
    MyNavigator(context).NavigateToHome();
  }
}
