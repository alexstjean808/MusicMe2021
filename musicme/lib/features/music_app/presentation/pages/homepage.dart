import 'package:flutter/material.dart';
import 'package:musicme/features/music_app/presentation/widgets/search_bar.dart';
import 'package:musicme/features/music_app/presentation/widgets/welcome_message.dart';
import 'package:musicme/methods/connect_to_spotify.dart';
import 'dart:developer';

class MusicMeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    connectToSpotify();
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
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
              SizedBox(
                height: 30,
              ),
              SearchBar(),
              Builder(builder: (BuildContext context) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * .08,
                );
              }),
              // MusicPlayer(),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
    );
  }
}
