import 'package:bach_thes/models/path.dart';
import 'package:bach_thes/models/registration_model.dart';
import 'package:bach_thes/views/pages/add_new_path_page.dart';
import 'package:bach_thes/views/pages/add_new_peak_page.dart';
import 'package:bach_thes/views/pages/list_of_peaks.dart';
import 'package:bach_thes/views/pages/main_page.dart';
import 'package:bach_thes/views/pages/path_detail.dart';
import 'package:bach_thes/views/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:bach_thes/views/pages/forgoten_password_page.dart';
import 'package:bach_thes/views/pages/home_page.dart';
import 'package:bach_thes/views/pages/login_page.dart';
import 'package:bach_thes/views/pages/registration_page.dart';
import 'package:bach_thes/views/pages/pointsAlert.dart';
//Class that provides navigation to any of the pages of the application

class MyNavigator {
  BuildContext context;

  MyNavigator(this.context);

  NavigateToLogin() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginPage()));
  }

  NavigateToSearchPeaks() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SearchPeaks()));
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

  void navigateToPathDetail(dynamic path) {
    Navigator.push(
        //adds the page to the stack, MaterialPageRoute determines to which screen it goes
        context,
        MaterialPageRoute(builder: (context) => PathDetail(path)));
  }

  void navigateToMainPage() {
    Navigator.push(
        //adds the page to the stack, MaterialPageRoute determines to which screen it goes
        context,
        MaterialPageRoute(builder: (context) => MainPage()));
  }

  void navigateToSettingsPage() {
    Navigator.pop(context);

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => settingsPage()));
  }

  void navigateToAddNewPathPage(String endName, int id) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => addNewPathPage(
                  name: '${endName}',
                  id: id,
                )));
  }

  void navigateToAddNewPeakPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => addNewPeakPage()));
  }

  void navigateToPointsPage(String action, int points) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PointsPage(action: action, points: points)));
  }
}
