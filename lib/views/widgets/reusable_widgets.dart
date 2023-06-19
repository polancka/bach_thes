import 'package:bach_thes/controllers/login_controller.dart';
import 'package:bach_thes/controllers/navigation_controller.dart';
import 'package:bach_thes/controllers/registration_controller.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bach_thes/utils/styles.dart';

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
                  leading: Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Log out",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  onTap: () {
                    FirebaseAuth.instance
                        .signOut()
                        .then((value) => {})
                        .catchError((error) => {
                              //eror happened
                            });
                  })
            ],
          )));
}

//App bar that enables the drawer to be accessed. It does not contain a title.
AppBar myAppBar(String text) {
  return AppBar(
      backgroundColor: Styles.deepgreen.withOpacity(0.9),
      title: Text(
        text,
        style: TextStyle(color: Colors.white),
      ));
}
