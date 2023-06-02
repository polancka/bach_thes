import 'package:bach_thes/pages/home_page.dart';
import 'package:bach_thes/pages/reg_page.dart';
import 'package:flutter/material.dart';

Image logoWidget(String imageUrl) {
  return Image.asset(
    imageUrl,
    fit: BoxFit.fitWidth,
    width: 240,
    height: 240,
    color: Colors.white,
  );
}

TextField reusableTextField(String hinttext, TextEditingController controller,
    bool isPassword, IconData icon) {
  return TextField(
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
      labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(width: 0, style: BorderStyle.none)),
    ),
  );
}

//Login button
SizedBox logInButton(BuildContext context, String text) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    height: 40,
    child: TextButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => HomePage()));
        },
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (!states.contains(MaterialState.pressed)) {
                return Colors.white;
              } else {
                return Colors.pinkAccent;
              }
            })),
        child: Text(text)),
  );
}

//sign up button
SizedBox signUpButton(BuildContext context) {
  return SizedBox(
    child: TextButton(
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => RegPage()));
      },
      child: Text("Not a member? Sign up!"),
    ),
  );
}
