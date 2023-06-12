import 'package:bach_thes/controllers/forgotten_password_controller.dart';
import 'package:bach_thes/controllers/navigation_controller.dart';
import 'package:bach_thes/views/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bach_thes/views/pages/home_page.dart';
import 'package:bach_thes/views/widgets/reusable_widgets.dart';

//UI for the forgotten password page

class ForgotenPasswordPage extends StatefulWidget {
  const ForgotenPasswordPage({super.key});

  @override
  State<ForgotenPasswordPage> createState() => _ForgotenPasswordPageState();
}

class _ForgotenPasswordPageState extends State<ForgotenPasswordPage> {
  TextEditingController resetPasswordEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.pinkAccent),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
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
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(children: <Widget>[
              Padding(
                  padding: EdgeInsets.fromLTRB(25, 25, 25, 30),
                  child: Text(
                    "Reset password",
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  )),
              reusableTextField("Your email", resetPasswordEmailController,
                  false, Icons.email_outlined),
              const SizedBox(height: 20),
              GestureDetector(
                  onTap: () {
                    ForgotenPasswordController(
                            resetPasswordEmailController.text)
                        .sendPassword();
                    MyNavigator(context).NavigateToLogin();
                  },
                  child: Text("Send email with the reset link",
                      style: TextStyle(color: Colors.white)))
            ]),
          )),
        ),
      ),
    );
  }
}
