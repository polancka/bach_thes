import 'package:flutter/material.dart';
import 'package:bach_thes/components/reusable_widgets.dart';

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
              logInButton(context, "Register!"),
            ]),
          )),
        ),
      ),
    );
  }
}
