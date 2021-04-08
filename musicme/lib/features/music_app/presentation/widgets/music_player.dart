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
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(.7),
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.37,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
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
            LikeDislikeButtons(),
            Padding(
              padding: EdgeInsets.all(10),
              child: BlocBuilder<TrackBloc, TrackData>(
                builder: (context, trackData) {
                  if (trackData.name == null || trackData.artist == null) {
                    return Text(
                      "Loading...",
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    );
                  }
                  return Text(
                    "${trackData.name} by ${trackData.artist}",
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  );
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ControlButtons(),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

class LikeDislikeButtons extends StatelessWidget {
  const LikeDislikeButtons({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              primary: Colors.black,
            ),
            child: Padding(
              padding: const EdgeInsets.all(11.0),
              child: Icon(Icons.thumb_down, color: Colors.white),
            ),
            onPressed: () {
              final snackBar = SnackBar(
                content: Text('Song disliked... Updating recommendations.'),
                action: SnackBarAction(
                  label: 'Close',
                  onPressed: () {
                    // Some code to undo the change.
                  },
                ),
              );

              BlocProvider.of<TrackBloc>(context)
                  .add(DislikeEvent()); // changing the paramters
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }, // dislike button
          ),
          SizedBox(
            width: 30,
          ),
          BlocBuilder<TrackBloc, TrackData>(
            builder: (context, track) {
              if (track.image.url == 'initial') {
                return Image.asset(
                  'assets/images/man_with_beard.jpg',
                  height: 150,
                );
              }
              return Image.network(
                track.image.url,
                height: 150,
              );
            },
          ),
          SizedBox(
            width: 30,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              primary: Colors.black,
            ),
            child: Padding(
              padding: const EdgeInsets.all(11.0),
              child: Icon(Icons.thumb_up, color: Colors.white),
            ),
            onPressed: () {
              final snackBar = SnackBar(
                content: Text('Song liked... Adding to liked songs list.'),
                action: SnackBarAction(
                  label: 'Close',
                  onPressed: () {
                    // Some code to undo the change.
                  },
                ),
              );
              BlocProvider.of<TrackBloc>(context).add(LikeEvent());
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }, // Like buttons
          ),
        ],
      ),
    );
  }
}

class FeelingLuckyButton extends StatelessWidget {
  const FeelingLuckyButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.blue,
      ),
      child: Padding(
        padding: const EdgeInsets.all(11.0),
        child: Text("Feeling lucky?"),
      ),
      onPressed: () {
        BlocProvider.of<TrackBloc>(context).add(FeelingLuckyEvent());
        Scaffold.of(context).showBottomSheet((context) => MusicPlayer());
      }, // PREVIOUS SONG BACK BUTTON
    );
  }
}

class ControlButtons extends StatelessWidget {
  const ControlButtons({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              primary: Colors.black,
            ),
            child: Padding(
              padding: const EdgeInsets.all(11.0),
              child: Icon(Icons.fast_rewind, color: Colors.white),
            ),
            onPressed: () async {
              BlocProvider.of<TrackBloc>(context).add(SkipPreviousEvent());
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
            onPressed: () async {
              await SpotifySdk.resume();
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
            onPressed: () async {
              BlocProvider.of<TrackBloc>(context).add(SkipTrackEvent());
            }, // FAST FORWARD BUTTON
          ),
        ],
      ),
    );
  }
}
