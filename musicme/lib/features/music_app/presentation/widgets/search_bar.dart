import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:musicme/features/music_app/data/entities/track.dart';
import 'package:musicme/features/music_app/presentation/bloc/track_block.dart';
import 'package:musicme/features/music_app/presentation/bloc/track_event.dart';
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
    final _trackBloc = BlocProvider.of<TrackBloc>(context);

    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      child: BlocListener<TrackBloc, Track>(
        listener: (context, track) {
          SpotifySdk.play(spotifyUri: "spotify:track:${track.trackId}");
        },
        child: TextField(
          onSubmitted: (String entry) {
            _trackBloc.add(GetTrackEvent(entry));
            Scaffold.of(context).showBottomSheet((context) => MusicPlayer());
            _controller.clear();
            sleep(Duration(seconds: 2)); // delay so the keyboard can disapear.
          },
          controller: _controller,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(),
            hintText: 'Type here.',
          ),
        ),
      ),
    );
  }
}
