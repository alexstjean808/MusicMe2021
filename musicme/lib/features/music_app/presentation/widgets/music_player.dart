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
      color: Colors.blue,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.30,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
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
            Expanded(
              flex: 2,
              child: Padding(
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
            ),
            SizedBox(
              height: 10,
            ),
            ControlButtons(),
            SizedBox(
              height: 60,
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
            onPressed: () {}, // dislike button
          ),
          SizedBox(
            width: 60,
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
              BlocProvider.of<TrackBloc>(context).add(LikeEvent());
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
              await SpotifySdk.skipPrevious();

              BlocProvider.of<TrackBloc>(context).add(SkipTrackEvent());
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
