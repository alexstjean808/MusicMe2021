import 'dart:io';

import 'package:flutter/material.dart';
import 'package:musicme/features/music_app/presentation/widgets/music_player.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

// TODO: implement the search features BLoC here,
// we need to send the input enetry below to the BloC
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
          Scaffold.of(context).showBottomSheet((context) => MusicPlayer());
          _controller.clear();
          sleep(Duration(seconds: 1)); // delay so the keyboard can disapear.
          //TODO: implement here the output song from the BLoC -- we should get an id from the database.
          String trackId = '6q9IP7wbfpocUiOEGvQqCZ';
          SpotifySdk.play(spotifyUri: "spotify:track:$trackId");
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
