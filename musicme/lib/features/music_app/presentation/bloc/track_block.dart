import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:musicme/features/music_app/core/methods/get_player_state.dart';
import 'package:musicme/features/music_app/data/entities/track_data.dart';
import 'package:musicme/features/music_app/data/repository/track_repository.dart';
import 'package:musicme/features/music_app/presentation/bloc/track_event.dart';

import 'package:spotify_sdk/models/track.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class TrackBloc extends Bloc<TrackEvent, TrackData> {
  final TrackRepository repository;

  _playSpotifyTrack(TrackData trackData) {
    print("trying to play the track: Bloc listener is responding to input");
    print(trackData.trackId);

    String trackId = trackData
        .trackId; //7GhIk7Il098yCjg4BQjzvb 6q9IP7wbfpocUiOEGvQqCZ <_ random ID"s that always work
    try {
      SpotifySdk.play(spotifyUri: "spotify:track:$trackId", asRadio: true);
      print('trying to play spotify song spotify:track:$trackId');
    } catch (err) {
      print(
          "Failed with spotify error: $err; playing defailt track 7GhIk7Il098yCjg4BQjzvb");
      trackId = '7GhIk7Il098yCjg4BQjzvb';
      SpotifySdk.play(spotifyUri: 'track:$trackId', asRadio: true);
    }
  }

  Future<TrackData> _updateTrackData(TrackData trackData) async {
    // gets the current player state and updates track Data with the artist name and the song name
    // returns the TrackData updated with artist name and songs name
    Track newTrackData =
        await getPlayerState(); // gets the updated track object
    trackData.artist = newTrackData.artist.name;
    trackData.name = newTrackData.name;
    return trackData;
  }

  TrackBloc(TrackData initialState, this.repository) : super(initialState);
  @override
  Stream<TrackData> mapEventToState(TrackEvent event) async* {
    if (event is GetTrackEvent) {
      try {
        TrackData trackData =
            await repository.getAllDataThatMeetsRequirements(event.sentence);
        _playSpotifyTrack(trackData);
        sleep(Duration(seconds: 1)); // giving time for call to spotify
        trackData = await _updateTrackData(trackData);
        // updating the trackData for name and artist

        yield trackData;
      } catch (error) {
        yield TrackData(trackId: '7GhIk7Il098yCjg4BQjzvb');
        // play a really funky song on failure.
      }
    } else if (event is SkipTrackEvent) {
      TrackData trackData = TrackData(trackId: 'This Should Not play');
      trackData = await _updateTrackData(trackData);
      yield trackData;
    }
  }
}
