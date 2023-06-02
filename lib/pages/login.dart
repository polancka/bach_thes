import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bach_thes/components/reusable_widgets.dart';
import 'forgoten_password.dart';

//TODO: add (dis)appering text if the username or password is not correct
//TODO: add dis(apearing) text if the user is not registered yet
//TODO: close the keyboard on its own

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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
          child: Column(children: <Widget>[
            logoWidget("lib/images/gore.png"),
            SizedBox(
              height: 30,
            ),
            reusableTextField(
                "Email", _emailController, false, Icons.person_outline),
            SizedBox(
              height: 20,
            ),
            reusableTextField(
                "Password", _passwordController, true, Icons.lock_outline),
            SizedBox(height: 20),
            //forgot password?
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ResetPassworPage()));
              },
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Text(
                  "Forgot password?",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w300),
                )
              ]),
            ),
            SizedBox(height: 20),
            logInButton(context, "Log in!", _emailController.text,
                _passwordController.text),
            signUpButton(context),

            SizedBox(height: 20),
            //signUp(context)
          ]),
        )),
      ),
    ));
  }
}

/*Row signUp(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text("Not a member yet?"),
      GestureDetector(
        onTap: () {
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => RegistrationPage()));
          });
        },
        child: const Text("Sign up!",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      )
    ],
  );
}*/

