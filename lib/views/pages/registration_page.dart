import 'package:flutter/material.dart';
import 'package:bach_thes/views/widgets/reusable_widgets.dart';
import 'package:bach_thes/utils/styles.dart';

//UI for registration page

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController newNameController = TextEditingController();
  TextEditingController newEmailController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Styles.deepgreen),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.white12,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Styles.deepgreen, Styles.lightgreen, Styles.offwhite],
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
              reusableTextField("Your email", newEmailController, false,
                  Icons.email_outlined),
              const SizedBox(height: 20),
              reusableTextField("Your password", newPasswordController, true,
                  Icons.lock_outline),
              const SizedBox(
                height: 20,
              ),
              regButton(context, "Join", newEmailController.text,
                  newPasswordController.text, newNameController.text)
            ]),
          )),
        ),
      ),
    );
  }
}
