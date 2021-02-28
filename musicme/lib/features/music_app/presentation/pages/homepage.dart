import 'dart:io';

import 'package:flutter/material.dart';

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
                  height: MediaQuery.of(context).size.height * .15,
                );
              }),
              MusicPlayer(),
            ],
            mainAxisAlignment: MainAxisAlignment.end,
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

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  var _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      child: TextField(
        onSubmitted: (String entry) {
          _controller.clear();
        },
        controller: _controller,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(),
          hintText: 'Type here.',
        ),
      ),
    );
  }
}

class MusicPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color.fromRGBO(99, 75, 110, 50)),
      height: MediaQuery.of(context).size.height * 0.30,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(40),
            child: Text(
              'Three Nights by Domminic F.',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(width: MediaQuery.of(context).size.width * 0.10),
              IconButton(icon: Icon(Icons.fast_rewind), onPressed: () {}),
              IconButton(icon: Icon(Icons.pause), onPressed: () {}),
              IconButton(icon: Icon(Icons.play_arrow), onPressed: () {}),
              IconButton(icon: Icon(Icons.fast_forward), onPressed: () {}),
              SizedBox(width: MediaQuery.of(context).size.width * 0.10),
            ],
          ),
        ],
      ),
    );
  }
}
