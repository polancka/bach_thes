import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';
import 'package:bach_thes/views/widgets/reusable_widgets.dart';

class ResetPassworPage extends StatefulWidget {
  const ResetPassworPage({super.key});

  @override
  State<ResetPassworPage> createState() => _ResetPassworPageState();
}

class _ResetPassworPageState extends State<ResetPassworPage> {
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
                    resendPassword(resetPasswordEmailController.text);
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginPage()));
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

Future resendPassword(String email) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  } on FirebaseException catch (e) {
    print(e);
  }
}
