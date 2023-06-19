import 'package:bach_thes/controllers/navigation_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:bach_thes/models/hiker.dart';

//Class that registers a new user - adds a new entry to the Firebase Authentication database
//TODO : add validation and display error messages on error

class RegistrationController {
  String _email;
  String _password;
  String _username;

  RegistrationController(this._email, this._password, this._username);

  bool validUser = false;

  Future<void> createNewUser(context) async {
    try {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password)
          .then((value) {
        validUser = true;
        MyNavigator(context).navigateToMainPage();
      });
    } on FirebaseException catch (e) {
      validUser = false;
      print("the user is not valid1");
      log(e.toString());
      print("the user is not valid2");
    }

    if (validUser = false) {
      print("the user is not valid");
    }

    //addHiker(_email, _username);
  }
}
