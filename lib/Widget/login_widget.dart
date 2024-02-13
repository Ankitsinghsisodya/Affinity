import 'package:affinity/services/firebase_auth_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailId = TextEditingController();
  final TextEditingController password = TextEditingController();

  final double widthBar = 300.0;

  @override
  void dispose() {
    super.dispose();
    emailId.dispose();
    password.dispose();
  }

  void loginUser() async {
    FireBaseAuthMethods(FirebaseAuth.instance).loginWithEmail(
        email: emailId.text, password: password.text, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 300,
          child: TextField(
            controller: emailId,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              labelStyle: TextStyle(color: Colors.white),
              border: UnderlineInputBorder(),
              labelText: 'Enter Email Id',
            ),
          ),
        ),
        SizedBox(
          width: 300,
          child: TextField(
            controller: password,
            obscureText: true,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              labelStyle: TextStyle(color: Colors.white),
              border: UnderlineInputBorder(),
              labelText: 'Password',
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            //minimumSize: const Size(100, 40),
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          ),
          onPressed: loginUser,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
            child: Text(
              "Log-in",
              style: GoogleFonts.lato(
                  fontSize: 20,
                  color: const Color.fromARGB(255, 255, 0, 0),
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/signin');
            },
            child: const Text(
              "Sign-up?",
              style: TextStyle(color: Colors.white),
            )),
      ],
    );
  }
}
