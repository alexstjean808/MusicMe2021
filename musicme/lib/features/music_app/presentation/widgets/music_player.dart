import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicme/features/music_app/data/entities/track_data.dart';
import 'package:musicme/features/music_app/presentation/bloc/track_block.dart';
import 'package:musicme/features/music_app/presentation/bloc/track_event.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class MusicPlayer extends StatelessWidget {
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
            child: BlocBuilder<TrackBloc, TrackData>(
              builder: (context, trackData) {
                if (trackData.name == null || trackData.artist == null) {
                  return Text("Song Name Loading...");
                }
                return Text("${trackData.name} by ${trackData.artist}");
              },
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
                  debugger();
                  SpotifySdk.skipPrevious();
                  sleep(Duration(milliseconds: 500));
                  BlocProvider.of<TrackBloc>(context).add(SkipTrackEvent());
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
                  sleep(Duration(milliseconds: 500));
                  BlocProvider.of<TrackBloc>(context).add(SkipTrackEvent());
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

class BlockBuilderForLater extends StatelessWidget {
  const BlockBuilderForLater({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackBloc, TrackData>(
      builder: (context, track) {
        return Text(
          'id is ${track.trackId}.',
          style: TextStyle(fontSize: 20, color: Colors.white),
        );
      },
    );
  }
}
