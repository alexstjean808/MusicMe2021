import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicme/features/music_app/data/data_provider/liked_songs_provider.dart';
import 'package:musicme/features/music_app/data/entities/track_data.dart';
import 'package:musicme/features/music_app/presentation/bloc/liked_songs_block.dart';
import 'package:musicme/features/music_app/presentation/bloc/liked_songs_event.dart';
import 'package:musicme/features/music_app/presentation/bloc/liked_songs_state.dart';
import 'package:musicme/features/music_app/presentation/bloc/track_block.dart';
import 'package:musicme/features/music_app/presentation/bloc/track_event.dart';

class LikedSongsSideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LikedSongsBloc(
          NoEditState(canEdit: false, likedSongs: []), LikedSongsProvider())
        ..add(GetLikedSongsEvent()),
      child: Drawer(
        child: DecoratedBox(
          decoration: BoxDecoration(color: Color.fromRGBO(212, 235, 242, 255)),
          child: Column(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/man_with_beard.jpg'),
                  ),
                ),
                child: Container(
                  height: 200,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            backgroundBlendMode: BlendMode.hue),
                        child: Text(
                          "Liked Songs",
                          style: TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 10),
                  Text("Edit:"),
                  Builder(
                    builder: (context) => IconButton(
                      onPressed: () {
                        BlocProvider.of<LikedSongsBloc>(context)
                            .add(EditListEvent());
                      },
                      icon: Icon(Icons.edit),
                      splashRadius: 15,
                    ),
                  ),
                ],
              ),
              Container(
                color: Color.fromRGBO(212, 235, 242, 255),
                height: 500,
                child: BlocBuilder<LikedSongsBloc, LikedSongsState>(
                  builder: (context, state) {
                    return ListView.builder(
                      itemCount: state.likedSongs.length,
                      itemBuilder: (BuildContext context, int index) {
                        var name = state.likedSongs[index].name;
                        var trackid = state.likedSongs[index].trackId;
                        var artist = state.likedSongs[index].artist;
                        if (state.canEdit) {
                          return LikeSongTileEdit(
                              name: name, trackId: trackid, artist: artist);
                        } else {
                          return LikeSongTile(
                              name: name, trackId: trackid, artist: artist);
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LikeSongTile extends StatelessWidget {
  final name;
  final artist;
  final trackId;

  const LikeSongTile({Key key, this.name, this.artist, this.trackId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: 56,
      decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          border: Border.all(color: Colors.blue)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    "$name",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: 20),
                  Text("By $artist", style: TextStyle(color: Colors.white)),
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
          Container(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                BlocProvider.of<TrackBloc>(context).add(PlayLikedSongEvent(
                    TrackData(
                        name: name,
                        artist: artist,
                        trackId: trackId,
                        mood: "Dont know")));
              },
              icon: Icon(Icons.play_arrow), // PLAY LIKED SONG
              splashRadius: 15,
              splashColor: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

// Like Song tiles with remove button
class LikeSongTileEdit extends StatelessWidget {
  final name;
  final artist;
  final trackId;

  const LikeSongTileEdit({Key key, this.name, this.artist, this.trackId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: 56,
      padding: EdgeInsets.all(0),
      decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          border: Border.all(color: Colors.blue)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              width: 40,
              height: 56,
              decoration: BoxDecoration(color: Colors.red),
              child: IconButton(
                onPressed: () {
                  BlocProvider.of<LikedSongsBloc>(context).add(RemoveSongEvent(
                      TrackData(
                          name: name,
                          artist: artist,
                          trackId: trackId,
                          mood: "Dont know")));
                },
                icon: Icon(
                  Icons.remove, //REMOVE A LIKED SONG
                ),
                splashRadius: 1,
              )),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(width: 10),
                    Text(
                      "$name",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 20),
                    Text("By $artist", style: TextStyle(color: Colors.white)),
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                BlocProvider.of<TrackBloc>(context).add(PlayLikedSongEvent(
                    TrackData(
                        name: name,
                        artist: artist,
                        trackId: trackId,
                        mood: "Dont know")));
              }, // play 2
              icon: Icon(Icons.play_arrow),
              splashRadius: 15,
              splashColor: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
