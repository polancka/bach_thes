import 'package:bach_thes/controllers/navigation_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';
import 'package:flutter/material.dart';

//Login controller checks if the data inputed in the login fields match the ones in Firebase Authentication base
//TODO: add error message

class LoginController {
  String _email;
  String _password;

  LoginController(this._email, this._password);

  Future<void> logInUser(context) async {
    try {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: this._email, password: this._password)
          .then((value) {
        MyNavigator(context).navigateToMainPage();
      });
    } on FirebaseException catch (e) {
      log(e.toString());
    }
  }
}
