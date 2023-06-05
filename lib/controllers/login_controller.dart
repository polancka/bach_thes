import 'package:bach_thes/controllers/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginController {
  String _email;
  String _password;

  LoginController(this._email, this._password);

  Future<void> logInUser(BuildContext context) async {
    try {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: this._email, password: this._password)
          .then((value) {
        MyNavigator(context).NavigateToHome();
      });
    } on FirebaseException catch (e) {
      print(e);
    }
  }
}
