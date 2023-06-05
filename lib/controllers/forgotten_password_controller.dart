import 'package:bach_thes/controllers/login_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotenPasswordController {
  final String _email;

  ForgotenPasswordController(this._email);

  Future<void> sendPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _email);
    } on FirebaseException catch (e) {
      print(e);
    }
  }
}
