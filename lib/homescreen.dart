import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.isLogin});

  final String msg1 =
      'Create your crush list. If your crush also has your name on their list then its a MATCH!!';
  final String msg2 = "Don't worry, your list will be always anonymous";

  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: screenSize.width * 0.1,
          vertical: screenSize.height * 0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Valentine's Day",
              textAlign: TextAlign.center,
              style: GoogleFonts.lobster(
                  color: Colors.red,
                  fontSize: min(screenSize.width * 0.1, 100))),
          Text("--------------------------------------",
              style: GoogleFonts.lobster(
                  color: Colors.red,
                  fontSize: min(screenSize.width * 0.02, 10))),
          SizedBox(
            height: screenSize.height * 0.1,
          ),
          Text(msg1,
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                  color: Colors.red,
                  fontSize: min(screenSize.width * 0.05, 25),
                  fontWeight: FontWeight.w900)),
          Text(msg2,
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                  color: Colors.red,
                  fontSize: min(screenSize.width * 0.05, 25),
                  fontWeight: FontWeight.w900)),
          const SizedBox(
            height: 100,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              //minimumSize: const Size(100, 40),
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              if (isLogin) {
                Navigator.pushNamed(context, '/crushlist');
              } else {
                Navigator.pushNamed(context, '/signin');
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
              child: Text(
                "Create Your Crush List",
                style: GoogleFonts.lato(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
