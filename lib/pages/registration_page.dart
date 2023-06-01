import 'package:flutter/material.dart';
import 'home_page.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistratioPageState();
}

class _RegistratioPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Register now!",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 5),
                //TODO: vpis podatkov v polja ime, email, geslo, izbira nivoja znanja
                /*PersonalizedTextInputField(
                    hintText: "Name",
                    obscureText: false,
                    controller: nameController),
                const SizedBox(height: 3),
                PersonalizedTextInputField(
                    hintText: "Email",
                    obscureText: false,
                    controller: emailController),
                const SizedBox(height: 3),
                PersonalizedTextInputField(
                    hintText: "Set password",
                    obscureText: true,
                    controller: passwordController),*/
                const SizedBox(height: 3),
                GestureDetector(
                    onTap: () {
                      //TO DO: dodaj funkcijo za zapis podatkov v Firebase (nov uporabnik)
                      _navigateToHomePage(context);
                    },
                    child: const Text("Register now!")),
              ],
            ),
          ),
        ));
  }
}

//Function for navigating to the home page, once the new user is registered
void _navigateToHomePage(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => HomePage()));
}
