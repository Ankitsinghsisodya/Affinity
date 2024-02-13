import 'package:affinity/services/firebase_auth_methods.dart';
import 'package:affinity/services/user_repsoitory.dart';
import 'package:affinity/util/show_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:affinity/models/user_model.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({
    super.key,
  });
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailId = TextEditingController();

  final TextEditingController name = TextEditingController();

  final TextEditingController branch = TextEditingController();

  final TextEditingController batch = TextEditingController();

  final TextEditingController password = TextEditingController();

  final TextEditingController sec = TextEditingController();
  final double widthBar = 300.0;
  @override
  void dispose() {
    super.dispose();
    branch.dispose();
    name.dispose();
    emailId.dispose();
    batch.dispose();
    password.dispose();
    sec.dispose();
  }

  final userRepo = Get.put(UserRepository());

  Future<void> signUpUser() async {
    showSnackBar(context, "Loading....");
    final user = UserModel(
        name: name.text.trim().toLowerCase(),
        email: emailId.text.trim().toLowerCase(),
        sec: sec.text.trim().toLowerCase(),
        batch: batch.text.trim().toLowerCase(),
        branch: branch.text.trim().toLowerCase());
    await userRepo.createUser(user);
    authenticateUser();
  }

  void authenticateUser() async {
    FireBaseAuthMethods(FirebaseAuth.instance).signUpWithEmail(
        email: emailId.text, password: password.text, context: context);
    Navigator.pushNamed(context, '/login');
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
              labelText: 'Enter Student Email Id',
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
        SizedBox(
          width: widthBar,
          child: TextField(
            controller: name,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              labelStyle: TextStyle(color: Colors.white),
              border: UnderlineInputBorder(),
              labelText: 'Name',
            ),
          ),
        ),
        SizedBox(
          width: widthBar,
          child: TextField(
            controller: branch,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              labelStyle: TextStyle(color: Colors.white),
              border: UnderlineInputBorder(),
              labelText: 'Branch',
            ),
          ),
        ),
        SizedBox(
          width: widthBar,
          child: TextField(
            controller: sec,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              labelStyle: TextStyle(color: Colors.white),
              border: UnderlineInputBorder(),
              labelText: 'Sec',
            ),
          ),
        ),
        SizedBox(
          width: widthBar,
          child: TextField(
            controller: batch,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              labelStyle: TextStyle(color: Colors.white),
              border: UnderlineInputBorder(),
              labelText: 'Batch',
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
          onPressed: () {
            final bool emailValid = RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@bitmesra.ac.in")
                .hasMatch(emailId.text.toLowerCase());
            if (!emailValid) {
              showSnackBar(context, "Enter student mail id");
            }
            if (name.text.isNotEmpty &&
                emailId.text.isNotEmpty &&
                branch.text.isNotEmpty &&
                batch.text.isNotEmpty &&
                emailValid) {
              signUpUser();
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
            child: Text(
              "Sign-in",
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
              Navigator.pushNamed(context, '/login');
            },
            child: const Text(
              "Login?",
              style: TextStyle(color: Colors.white),
            )),
      ],
    );
  }
}
