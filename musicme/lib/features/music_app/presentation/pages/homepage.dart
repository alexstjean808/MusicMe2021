import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicme/features/music_app/data/data_provider/input_log_provider.dart';
import 'package:musicme/features/music_app/data/data_provider/liked_songs_provider.dart';
import 'package:musicme/features/music_app/data/data_provider/query_params_provider.dart';
import 'package:musicme/features/music_app/data/data_provider/song_history_provider.dart';
import 'package:musicme/features/music_app/data/data_provider/track_data_provider.dart';
import 'package:musicme/features/music_app/data/entities/spotify_image.dart';
import 'package:musicme/features/music_app/data/entities/track_data.dart';
import 'package:musicme/features/music_app/data/entities/user.dart';
import 'package:musicme/features/music_app/data/repository/track_repository.dart';
import 'package:musicme/features/music_app/presentation/bloc/display_name_block.dart';
import 'package:musicme/features/music_app/presentation/bloc/track_block.dart';
import 'package:musicme/features/music_app/presentation/bloc/user_event.dart';
import 'package:musicme/features/music_app/presentation/pages/country_page.dart';
import 'package:musicme/features/music_app/presentation/pages/genre_page.dart';
import 'package:musicme/features/music_app/presentation/widgets/Bubble.dart';
import 'package:musicme/features/music_app/presentation/widgets/hello_message.dart';
import 'package:musicme/features/music_app/presentation/widgets/music_player.dart';
import 'package:musicme/features/music_app/presentation/widgets/search_bar.dart';

import 'package:musicme/features/music_app/presentation/widgets/welcome_message.dart';

import 'liked_songs_page.dart';

class MusicMeHomePage extends StatelessWidget {
  var _navStyle = TextStyle(fontSize: 18);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            bottomSheetTheme: BottomSheetThemeData(
                backgroundColor: Colors.black.withOpacity(0))),
        home: BlocProvider(
          create: (context) => UserBloc(User(displayName: 'MusicMe')), //default
          child: BlocProvider(
            create: (context) => TrackBloc(
              TrackData(
                  mood: 'joy',
                  trackId: '7GhIk7Il098yCjg4BQjzvb',
                  image: SongImage('initial')),
              TrackRepository(TrackDataProvider()),
              LikedSongsProvider(),
              SongHistoryProvider(),
              InputLogProvider(),
              QueryParamsProvider(),
            ),
            child: Scaffold(
              drawer: LikedSongsSideMenu(),
              appBar: AppBar(
                leadingWidth: 150,
                toolbarHeight: 65,
                actions: [
                  Builder(
                    builder: (context) => ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GenrePage()));
                      },
                      child: Text("Filter by Genre", style: _navStyle),
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
                        child: Text('Discover Countries', style: _navStyle)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Builder(
                      builder: (context) => ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<UserBloc>(context)
                                  .add(GetUserEvent());
                            },
                            child: Text("Connect To Spotify", style: _navStyle),
                          )),
                  SizedBox(
                    width: 10,
                  ),
                ],
                leading: Builder(
                  builder: (context) => ElevatedButton(
                    child: Text("Liked Songs", style: _navStyle),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                ),
              ),
              resizeToAvoidBottomInset: false,
              body: Stack(
                children: [
                  BlocBuilder<TrackBloc, TrackData>(
                      builder: (context, trackData) {
                    return Bubbles(color: Colors.yellow);
                  }),
                  Column(
                    children: [
                      HelloMessage(),
                      SizedBox(
                        height: 10,
                      ),
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
                            height: MediaQuery.of(context).size.height * .13,
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
        ));
  }
}
