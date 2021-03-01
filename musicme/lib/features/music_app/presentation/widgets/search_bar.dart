import 'package:flutter/material.dart';
import 'package:musicme/features/music_app/presentation/widgets/music_player.dart';

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
