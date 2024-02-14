import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.isLogin});

  final bool isLogin;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String msg1 =
      'Create your crush list. If your crush also has your name on their list then its a MATCH!!';

  final String msg2 = "Don't worry, your list will be always anonymous";

  bool _isMatched = false;

  String _crushDetail = "";

  _fetch() async {
    final db = FirebaseFirestore.instance;
    final email = FirebaseAuth.instance.currentUser!.email;
    final docRef = db.collection("users").doc(email);
    docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        setState(() {
          _isMatched = data["isMatched"];
          _crushDetail = data["crushName"];
        });
      },
      onError: (e) => debugPrint("Error getting document: $e"),
    );
  }

  @override
  Widget build(BuildContext context) {
    _fetch();
    var screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: screenSize.width * 0.1,
          vertical: screenSize.height * 0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
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
          // SizedBox(
          //   height: screenSize.height * 0.1,
          // ),
          // Text(msg1,
          //     textAlign: TextAlign.center,
          //     style: GoogleFonts.lato(
          //         color: Colors.red,
          //         fontSize: min(screenSize.width * 0.05, 25),
          //         fontWeight: FontWeight.w900)),
          // Text(msg2,
          //     textAlign: TextAlign.center,
          //     style: GoogleFonts.lato(
          //         color: Colors.red,
          //         fontSize: min(screenSize.width * 0.05, 25),
          //         fontWeight: FontWeight.w900)),
          // const SizedBox(
          //   height: 100,
          // ),
          if (!widget.isLogin) RedButton(isLogin: widget.isLogin),
          if (widget.isLogin)
            MatchData(
              isMatched: _isMatched,
              screenSize: screenSize,
              crushDetail: _crushDetail,
            ),
        ],
      ),
    );
  }
}

class MatchData extends StatelessWidget {
  const MatchData({
    super.key,
    required this.isMatched,
    required this.screenSize,
    required this.crushDetail,
  });

  final bool isMatched;
  final String crushDetail;
  final message =
      "The depth of your love isn't measured by their response; it's measured by your courage to express it. \n We are sorry to inform you, that you didn't have a match.";
  final Size screenSize;
  final cMessage = "Sometimes the heart sees what is invisible to the eye.";
  @override
  Widget build(BuildContext context) {
    var msg = "";
    if (isMatched) {
      msg = "$cMessage\nYou have a match with $crushDetail";
    } else {
      msg = message;
    }
    return Text(msg,
        textAlign: TextAlign.center,
        style: GoogleFonts.lato(
            color: Colors.red,
            fontSize: min(screenSize.width * 0.05, 25),
            fontWeight: FontWeight.w900));
  }
}

class RedButton extends StatelessWidget {
  const RedButton({
    super.key,
    required this.isLogin,
  });

  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
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
          "Login",
          style: GoogleFonts.lato(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
