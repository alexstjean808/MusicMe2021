import 'package:flutter/material.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class MusicPlayer extends StatelessWidget {
  String _trackName = "I'll Never Smile Again";
  String _artist = "Tommy Dorsey";
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color.fromRGBO(99, 60, 90, 50)),
      height: MediaQuery.of(context).size.height * 0.30,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 40),
            child: Text(
              '$_trackName by $_artist.', // TODO: We need to change this so it displays the author and sing title, this will be the output of the BLoC.
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(width: MediaQuery.of(context).size.width * 0.08),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  primary: Colors.black,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: Icon(Icons.fast_rewind, color: Colors.white),
                ),
                onPressed: () {
                  SpotifySdk.skipPrevious();
                }, // PREVIOUS SONG BACK BUTTON
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  primary: Colors.black,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                onPressed: () {
                  SpotifySdk.resume();
                }, // RESUME BUTTON
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  primary: Colors.black,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: Icon(
                    Icons.pause,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                onPressed: () {
                  SpotifySdk.pause();
                }, // PAUSE BUTTON
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  primary: Colors.black,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: Icon(Icons.fast_forward, color: Colors.white),
                ),
                onPressed: () {
                  SpotifySdk.skipNext();
                }, // FAST FORWARD BUTTON
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.08,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
