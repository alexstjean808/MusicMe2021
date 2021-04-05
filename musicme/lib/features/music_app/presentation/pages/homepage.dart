import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicme/features/music_app/core/methods/connect_to_spotify.dart';
import 'package:musicme/features/music_app/data/data_provider/liked_songs_provider.dart';
import 'package:musicme/features/music_app/data/data_provider/song_history_provider.dart';
import 'package:musicme/features/music_app/data/data_provider/track_data_provider.dart';
import 'package:musicme/features/music_app/data/entities/track_data.dart';
import 'package:musicme/features/music_app/data/repository/track_repository.dart';
import 'package:musicme/features/music_app/presentation/bloc/track_block.dart';
import 'package:musicme/features/music_app/presentation/pages/country_page.dart';
import 'package:musicme/features/music_app/presentation/pages/genre_page.dart';
import 'package:musicme/features/music_app/presentation/widgets/Bubble.dart';
import 'package:musicme/features/music_app/presentation/widgets/music_player.dart';
import 'package:musicme/features/music_app/presentation/widgets/search_bar.dart';
import 'package:musicme/features/music_app/presentation/widgets/welcome_message.dart';

import 'liked_songs_page.dart';

class MusicMeHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    connectToSpotify();
    return MaterialApp(
      home: BlocProvider(
        create: (context) => TrackBloc(
            TrackData(mood: 'joy', trackId: '7GhIk7Il098yCjg4BQjzvb'),
            TrackRepository(TrackDataProvider()),
            LikedSongsProvider(),
            SongHistoryProvider()),
        child: Scaffold(
          drawer: LikedSongsSideMenu(),
          appBar: AppBar(
            leadingWidth: 150,
            actions: [
              Builder(
                builder: (context) => ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => GenrePage()));
                  },
                  child: Text("Filter by Genre"),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Builder(
                builder: (context) => ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CountryPage()));
                    },
                    child: Text('Discover Countries')),
              ),
              SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  connectToSpotify();
                },
                child: Text("Connect To Spotify"),
              ),
              SizedBox(
                width: 10,
              ),
            ],
            leading: Builder(
              builder: (context) => ElevatedButton(
                child: Text("Liked Songs"),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
          ),
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              BlocBuilder<TrackBloc, TrackData>(builder: (context, trackData) {
                print("Trying to change the bubble color");
                print(trackData.mood);
                if (trackData.mood == 'joy') {
                  return Bubbles(color: Colors.yellow);
                } else if (trackData.mood == 'sadness') {
                  return Bubbles(color: Colors.deepPurple);
                } else if (trackData.mood == 'anger') {
                  return Bubbles(color: Colors.red);
                } else {}
                return Bubbles(color: Colors.yellow);
              }),
              Column(
                children: [
                  WelcomeMessage(),
                  SizedBox(
                    height: 30,
                  ),
                  SearchBar(),
                  Container(
                      child: FeelingLuckyButton(),
                      padding: EdgeInsets.only(top: 10)),
                  Builder(
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * .08,
                      );
                    },
                  ),
                  // MusicPlayer(),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
