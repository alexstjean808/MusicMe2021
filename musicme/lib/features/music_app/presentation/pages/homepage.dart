import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicme/features/music_app/core/methods/connect_to_spotify.dart';
import 'package:musicme/features/music_app/data/data_provider/query_params_provider.dart';
import 'package:musicme/features/music_app/data/data_provider/track_data_provider.dart';
import 'package:musicme/features/music_app/data/entities/track_data.dart';
import 'package:musicme/features/music_app/data/repository/track_repository.dart';
import 'package:musicme/features/music_app/presentation/bloc/track_block.dart';
import 'package:musicme/features/music_app/presentation/pages/genre_page.dart';
import 'package:musicme/features/music_app/presentation/widgets/search_bar.dart';
import 'package:musicme/features/music_app/presentation/widgets/welcome_message.dart';

class MusicMeHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    connectToSpotify();
    return MaterialApp(
      home: BlocProvider(
        create: (context) => TrackBloc(
          TrackData(trackId: '7GhIk7Il098yCjg4BQjzvb'),
          TrackRepository(TrackDataProvider()),
        ),
        child: Scaffold(
          appBar: AppBar(
            leadingWidth: 150,
            leading: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => GenrePage()));
                },
                child: Text("Search by Genre"),
              ),
            ),
          ),
          resizeToAvoidBottomInset: false,
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/MobileAppLayout.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                WelcomeMessage(),
                SizedBox(
                  height: 30,
                ),
                SearchBar(),
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
          ),
        ),
      ),
    );
  }
}
