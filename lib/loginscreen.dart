import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key, required this.page});

  final Widget page;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      margin: EdgeInsets.symmetric(
          horizontal: screenSize.width * 0.2,
          vertical: screenSize.height * 0.05),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(163, 255, 82, 82),
      ),
      child: page,
    );
  }
}
