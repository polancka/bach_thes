//the login page, where user inputs his email and password and signs in the application
//user can also sign in with appleId or googleId
//or he can register if they are not using the application already

import 'dart:math';

import 'package:bach_thes/components/personal_button.dart';
import 'package:bach_thes/components/text_field.dart';
import 'package:bach_thes/pages/authentication_page.dart';
import 'package:bach_thes/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bach_thes/components/square_tile.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
  }

  //build function
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 197, 202, 204),
        body: SafeArea(
          child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                //the main elements of the login page
                //logo
                SquareTile(imageUrl: 'lib/images/gore.png'),

                const SizedBox(
                  height: 20,
                ),

                // email textbox
                PersonalizedTextInputField(
                  hintText: 'Enter your email',
                  obscureText: false,
                  controller: emailController,
                ),

                const SizedBox(
                  height: 20,
                ),

                //password textbox
                PersonalizedTextInputField(
                  hintText: 'Enter your password',
                  obscureText: true,
                  controller: passwordController,
                ),

                const SizedBox(
                  height: 20,
                ),

                //sign in button with function to sign the user in
                PersonalButton(text: "Sign in", onTap: signUserIn),

                //continue with gmail/appleId

                //Not a member jet? Sign up!
              ])),
        ));
  }
}
