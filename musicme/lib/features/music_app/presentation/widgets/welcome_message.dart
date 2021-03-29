import 'package:flutter/material.dart';

class WelcomeMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      child: Text(
        "How's your day going?",
        style: TextStyle(fontSize: 45, color: Colors.blue),
        textAlign: TextAlign.center,
      ),
    );
  }
}
