import 'package:bach_thes/controllers/navigation_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Login controller checks if the data inputed in the login fields match the ones in Firebase Authentication base.
//In case of an error, an error message is displayed to the user.

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

      //navigate to the apps main
      MyNavigator(context).navigateToMainPage();
    } on FirebaseAuthException catch (error) {
      //unsuccesful login
      var errorMessage = error.message.toString();
      Fluttertoast.showToast(msg: errorMessage, gravity: ToastGravity.CENTER);
    }
  }
}
