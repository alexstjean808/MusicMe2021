import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:musicme/features/music_app/data/entities/user.dart';
import 'package:musicme/features/music_app/presentation/bloc/display_name_block.dart';
import '../../data/local_data/user_data.dart';

class HelloMessage extends StatefulWidget {
  @override
  _HelloMessageState createState() => _HelloMessageState();
}

class _HelloMessageState extends State<HelloMessage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, User>(
      builder: (context, user) {
        if (user.displayName == 'MusicMe') {
          return Text(
              'Please connect to Spotify by clicking "Connect to Spotify" on the top right of the screen.',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center);
        } // dont
        return Text(
          "Hey there ${user.displayName}.",
          style: TextStyle(fontSize: 24, color: Colors.black),
          textAlign: TextAlign.center,
        );
      },
    );
  }
}
