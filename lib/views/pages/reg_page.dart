import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:bach_thes/views/widgets/reusable_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

//TODO:add authentication on email and password and pop up warnings if the password is too short
//TODO: add a "which hiking level are you"
//TODO: store the name and level in association with the profile

class RegPage extends StatefulWidget {
  const RegPage({super.key});

  @override
  State<RegPage> createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  TextEditingController newNameController = TextEditingController();
  TextEditingController newEmailController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

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
                    "Join our community",
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  )),
              reusableTextField(
                  "Your name", newNameController, false, Icons.person_outline),
              const SizedBox(height: 20),
              reusableTextFieldEmail("Your email", newEmailController, false,
                  Icons.email_outlined),
              const SizedBox(height: 20),
              reusableTextFieldEmail("Your password", newPasswordController,
                  true, Icons.lock_outline),
              const SizedBox(
                height: 20,
              ),
              regButton(context, "Join", newEmailController.text,
                  newPasswordController.text)
            ]),
          )),
        ),
      ),
    );
  }
}
