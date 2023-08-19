import 'package:bach_thes/controllers/login_controller.dart';
import 'package:bach_thes/controllers/navigation_controller.dart';
import 'package:bach_thes/controllers/registration_controller.dart';
import 'package:bach_thes/models/hiker.dart';
import 'package:bach_thes/views/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bach_thes/utils/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

/* Different widgets that are used multiple times or by multiple pages */

Image logoWidget(String imageUrl) {
  return Image.asset(
    imageUrl,
    fit: BoxFit.fitWidth,
    width: 240,
    height: 240,
    color: Colors.white,
  );
}

Align reusableTextField(String hinttext, TextEditingController controller,
    bool isPassword, IconData icon) {
  return Align(
      alignment: Alignment.center,
      child: TextFormField(
        validator: (value) {
          if (value == null ||
              value.isEmpty ||
              !value.contains('@') ||
              !value.contains('.')) {
            return 'Please enter a valid email';
          }
          return null;
        },
        style: TextStyle(
          color: Colors.white,
        ),
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.white,
          ),
          labelText: hinttext,
          filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          fillColor: Colors.white.withOpacity(0.3),
          labelStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(width: 0, style: BorderStyle.none)),
        ),
      ));
}

//Login button
SizedBox logInButton(
    BuildContext context, String text, String username, String password) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    height: 40,
    child: TextButton(
        onPressed: () {
          LoginController(username, password).logInUser(context);
        },
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              return Colors.white;
            })),
        child: Text(text, style: TextStyle(color: Styles.deepgreen))),
  );
}

//Register button
SizedBox regButton(BuildContext context, String text, String email,
    String password, String username) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    height: 40,
    child: TextButton(
        onPressed: () {
          RegistrationController(email, password, username)
              .createNewUser(context);
        },
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              return Colors.white;
            })),
        child: Text("Register now", style: TextStyle(color: Styles.deepgreen))),
  );
}

//sign up redirection
SizedBox signUpButton(BuildContext context) {
  return SizedBox(
    child: TextButton(
      onPressed: () {
        MyNavigator(context).NavigateToRegistration();
      },
      child: const Text(
        "Not a member? Sign up!",
        style: TextStyle(color: Colors.white),
      ),
    ),
  );
}

//Landing page tile (will probably be delted)
Container landingPageTile(BuildContext context, String text) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.30,
    height: MediaQuery.of(context).size.height * 0.3,
    child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Styles.offwhite,
        ),
        child: Text(text, style: TextStyle(color: Styles.deepgreen))),
  );
}

//Hamburger menu - contains options such as log out. Navigations on tap yet to be made in detail.
Drawer myDrawer(BuildContext context) {
  return Drawer(
      elevation: 50,
      backgroundColor: Styles.deepgreen,
      child: Container(
          padding: EdgeInsets.all(35),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              ListTile(
                  leading: Icon(Icons.track_changes, color: Colors.white),
                  title: Text("Record a hike",
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                  onTap: () {
                    MyNavigator(context).navigateToRecordingPage();
                  }),
              ListTile(
                leading: Icon(Icons.list, color: Colors.white),
                title: Text("My recordings",
                    style: TextStyle(color: Colors.white, fontSize: 15)),
                onTap: () {
                  MyNavigator(context).navigateToAllRecordingsPage();
                },
              ),
              ListTile(
                leading: Icon(Icons.star, color: Colors.white),
                title: Text("My badges",
                    style: TextStyle(color: Colors.white, fontSize: 15)),
                onTap: () {
                  MyNavigator(context).navigateToBadgesPage();
                },
              ),
              ListTile(
                leading: Icon(Icons.bolt_outlined, color: Colors.white),
                title: Text("Random hike suggestion",
                    style: TextStyle(color: Colors.white, fontSize: 15)),
                onTap: () {
                  MyNavigator(context).navigateToRandomHikePage();
                },
              ),
              ListTile(
                  leading: Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Settings",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  onTap: () {
                    //open settings
                    MyNavigator(context).navigateToSettingsPage();
                  }),
              ListTile(
                  leading: Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Log out",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  onTap: () async {
                    //logOutInPrefs();
                    clearSharedPreferences();
                    //Navigator.pushAndRemoveUntil(context, newRoute, (route) => false
                    await FirebaseAuth.instance.signOut().then((value) =>
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                            (route) => false));

                    //clear user cache
                    //Navigator.pushAndRemoveUntil(context, newRoute, (route) => false)
                  }),
            ],
          )));
}

//App bar that enables the drawer to be accessed. It does not contain a title.
AppBar myAppBar(String text) {
  return AppBar(
      centerTitle: true,
      backgroundColor: Styles.deepgreen.withOpacity(0.9),
      title: Text(
        text,
        style: TextStyle(color: Colors.white),
      ));
}

Widget listItemHike(dynamic docSnapshot, BuildContext context) {
  String dateFormat = 'MM/dd/yy';
  var time = docSnapshot['dateAndTime'];
  //DateTime docDateTime = DateTime.parse(time.toString());
  //var newtime = DateFormat(dateFormat).format(docDateTime);

  String formatTime(int secs) {
    var hours = (secs ~/ 3600).toString().padLeft(2, '0');
    var minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
    var seconds = (secs % 60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }

  return Container(
      child: Card(
          color: Styles.deepgreen.withOpacity(0.7),
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          child: Column(children: [
            ListTile(
                /*leading: Icon(
          Icons.check_box,
          color: Colors.white,
        ),*/
                title: Text(
                  "Hike to ${docSnapshot['endPointName']}",
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text("${time}",
                    style: TextStyle(color: Colors.white, fontSize: 14)),
                trailing: Icon(
                  Icons.check_box,
                  color: Colors.white,
                ),
                onTap: () {
                  MyNavigator(context)
                      .navigateToRecordingDetailPage(docSnapshot);
                }),
          ])));
}

logOutInPrefs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('isLoggedIn', false);
}
