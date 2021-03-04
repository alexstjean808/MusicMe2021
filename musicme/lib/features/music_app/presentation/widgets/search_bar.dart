import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:musicme/features/music_app/data/entities/track.dart';
import 'package:musicme/features/music_app/presentation/bloc/track_block.dart';
import 'package:musicme/features/music_app/presentation/bloc/track_event.dart';
import 'package:musicme/features/music_app/presentation/widgets/music_player.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

// we need to send the input enetry below to the BloC
class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  var _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final _trackBloc = BlocProvider.of<TrackBloc>(context);

    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      child: BlocListener<TrackBloc, Track>(
        listener: (context, track) {
          print(
              "trying to play the track: Bloc listener is responding to input");
          print(track.trackId);

          String trackId =
              track.trackId; //7GhIk7Il098yCjg4BQjzvb 6q9IP7wbfpocUiOEGvQqCZ
          SpotifySdk.play(spotifyUri: "spotify:track:$trackId", asRadio: true);
          print('trying to play spotify song spotify:track:$trackId');
        },
        child: TextField(
          onSubmitted: (String entry) {
            _trackBloc.add(GetTrackEvent(entry));
            Scaffold.of(context).showBottomSheet((context) => MusicPlayer());
            _controller.clear();
            // delay so the keyboard can disapear.
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
