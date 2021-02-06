import 'package:flutter/material.dart';
import 'dart:developer' as dev;

class MusicMeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/MobileAppLayout.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              WelcomeMessage(),
              UserMoodTextField(),
              MusicPlayButton(),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
    );
  }
}

class WelcomeMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      child: Text(
        "How's your day going?",
        style: TextStyle(
            fontFamily: "Monotype-Corsiva", fontSize: 45, color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class UserMoodTextField extends StatefulWidget {
  @override
  _UserMoodTextFieldState createState() => _UserMoodTextFieldState();
}

class _UserMoodTextFieldState extends State<UserMoodTextField> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MusicPlayButton extends StatefulWidget {
  @override
  _MusicPlayButtonState createState() => _MusicPlayButtonState();
}

class _MusicPlayButtonState extends State<MusicPlayButton> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
