import 'dart:math';
import 'package:bach_thes/pages/home_page.dart';
import 'package:bach_thes/pages/reg_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      child: TextField(
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
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
          FirebaseAuth.instance
              .signInWithEmailAndPassword(email: username, password: password)
              .then((value) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HomePage()));
          });
        },
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              return Colors.white;
            })),
        child: Text(text, style: TextStyle(color: Colors.pinkAccent))),
  );
}

//Register button
SizedBox regButton(
    BuildContext context, String text, String username, String password) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    height: 40,
    child: TextButton(
        onPressed: () {
          FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: username, password: password)
              .then((value) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HomePage()));
          }).onError((error, stackTrace) {
            print("Error ${error.toString()}");
          });
        },
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              return Colors.white;
            })),
        child:
            Text("Register now", style: TextStyle(color: Colors.pinkAccent))),
  );
}

//sign up redirection
SizedBox signUpButton(BuildContext context) {
  return SizedBox(
    child: TextButton(
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => RegPage()));
      },
      child: Text(
        "Not a member? Sign up!",
        style: TextStyle(color: Colors.white),
      ),
    ),
  );
}
