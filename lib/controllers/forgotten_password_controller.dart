import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';

//If the user forgots the password, he can have a resent link sent to his email address

class ForgotenPasswordController {
  final String _email;

  ForgotenPasswordController(this._email);

  Future<void> sendPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _email);
    } on FirebaseException catch (e) {
      log(e.toString());
    }
  }
}
