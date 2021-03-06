import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:musicme/features/music_app/presentation/bloc/track_block.dart';
import 'package:musicme/features/music_app/presentation/bloc/track_event.dart';
import 'package:musicme/features/music_app/presentation/widgets/music_player.dart';

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
      child: TextField(
        onSubmitted: (String entry) {
          entry = entry.trim();
          if (entry != '') {
            // if the user doesnt enter anything dont search.
            _trackBloc.add(GetTrackEvent(sentence: entry));

            Scaffold.of(context).showBottomSheet((context) => MusicPlayer());
            _controller.clear();
          }
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
