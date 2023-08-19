import 'package:bach_thes/controllers/navigation_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bach_thes/models/hiker.dart';
import 'package:fluttertoast/fluttertoast.dart';

//Class that registers a new user - adds a new entry to the Firebase Authentication database
//On error, an error message is displayed to the user.

class RegistrationController {
  String _email;
  String _password;
  String _username;

  RegistrationController(this._email, this._password, this._username);

  bool validUser = false;

  Future<void> createNewUser(context) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password);
      //success
      var currentUser = FirebaseAuth.instance.currentUser?.uid;
      Future<DocumentReference> thisHikerRef =
          addHiker(_email, _username, currentUser);
      MyNavigator(context).navigateToMainPage();
    } on FirebaseAuthException catch (error) {
      validUser = false;
      var errorMessage = error.message.toString();
      Fluttertoast.showToast(msg: errorMessage, gravity: ToastGravity.CENTER);
    }
  }
}
