import 'package:flutter/material.dart';

class WelcomeMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      child: Text(
        "How are you feeling?",
        style: TextStyle(
            fontSize: 35, color: Colors.blue, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }
}
