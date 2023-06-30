import 'package:bach_thes/controllers/navigation_controller.dart';
import 'package:bach_thes/globals.dart';
import 'package:bach_thes/views/pages/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Login controller checks if the data inputed in the login fields match the ones in Firebase Authentication base
//TODO: add error message

class LoginController {
  String _email;
  String _password;

  LoginController(this._email, this._password);

  Future<void> logInUser(context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: this._email, password: this._password);

      //succesful login

      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("email", "useremail@gmail.com");
      //print(pref.get("email"));
      /*Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
        return MainPage();
      }));*/

      //change the current user variable
      //var currentUser = FirebaseAuth.instance.currentUser?.uid;

      //navigate to the apps main
      MyNavigator(context).navigateToMainPage();
    } on FirebaseAuthException catch (error) {
      var errorMessage = error.message.toString();
      Fluttertoast.showToast(msg: errorMessage, gravity: ToastGravity.CENTER);
    }
  }
}
