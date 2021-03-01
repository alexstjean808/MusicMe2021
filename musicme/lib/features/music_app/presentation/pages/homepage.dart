import 'package:flutter/material.dart';
import 'package:musicme/features/music_app/presentation/widgets/search_bar.dart';
import 'package:musicme/features/music_app/presentation/widgets/welcome_message.dart';

class MusicMeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
