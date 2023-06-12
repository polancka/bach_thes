import 'package:bach_thes/controllers/login_controller.dart';
import 'package:bach_thes/controllers/navigation_controller.dart';
import 'package:bach_thes/views/pages/forgoten_password_page.dart';
import 'package:flutter/material.dart';
import 'package:bach_thes/views/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bach_thes/views/widgets/reusable_widgets.dart';

//TODO: add (dis)appering text if the username or password is not correct
//TODO: add dis(apearing) text if the user is not registered yet
//TODO: close the keyboard on its own

//UI for the login page, forgotten password and switching to registration

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white12,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.purple, Colors.pinkAccent, Colors.white],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft),
        ),
        child: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.fromLTRB(
              20, MediaQuery.of(context).size.height * 0.1, 20, 0),
          child: Form(
            child: Column(children: <Widget>[
              logoWidget("lib/utils/images/gore.png"),
              const SizedBox(height: 30),
              reusableTextField(
                  "Email", _emailController, false, Icons.person_outline),
              const SizedBox(height: 20),
              reusableTextField(
                  "Password", _passwordController, true, Icons.lock_outline),
              const SizedBox(height: 20),
              //forgot password?
              GestureDetector(
                onTap: () {
                  MyNavigator(context).NavigateToForgotenPassword();
                },
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text(
                        "Forgot password?",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w300),
                      )
                    ]),
              ),
              SizedBox(height: 20),

              logInButton(context, "Log in", _emailController.text,
                  _passwordController.text),
              signUpButton(context),
              SizedBox(height: 20),
              //signUp(context)
            ]),
          ),
        )),
      ),
    ));
  }
}
