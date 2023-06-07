import 'package:bach_thes/models/registration_model.dart';
import 'package:flutter/material.dart';
import 'package:bach_thes/views/pages/forgoten_password_page.dart';
import 'package:bach_thes/views/pages/home_page.dart';
import 'package:bach_thes/views/pages/login_page.dart';
import 'package:bach_thes/views/pages/registration_page.dart';

class MyNavigator {
  BuildContext context;

  MyNavigator(this.context);

  NavigateToLogin() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginPage()));
  }

  NavigateToHome() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => HomePage()));
  }

  NavigateToRegistration() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => RegistrationPage()));
  }

  NavigateToForgotenPassword() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ForgotenPasswordPage()));
  }
}
