import 'package:bloc/bloc.dart';
import 'package:musicme/features/music_app/core/methods/get_player_state.dart';
import 'package:musicme/features/music_app/data/data_provider/liked_songs_provider.dart';
import 'package:musicme/features/music_app/data/data_provider/song_history_provider.dart';
import 'package:musicme/features/music_app/data/entities/track_data.dart';
import 'package:musicme/features/music_app/data/repository/track_repository.dart';
import 'package:musicme/features/music_app/presentation/bloc/track_event.dart';

import 'package:spotify_sdk/models/track.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class TrackBloc extends Bloc<TrackEvent, TrackData> {
  final TrackRepository repository;
  final LikedSongsProvider likedSongProvider;
  final SongHistoryProvider songHistoryProvider;

  _playSpotifyTrack(TrackData trackData) async {
    print("trying to play the track: Bloc listener is responding to input");
    print(trackData.trackId);

    String trackId = trackData
        .trackId; //7GhIk7Il098yCjg4BQjzvb 6q9IP7wbfpocUiOEGvQqCZ <_ random ID"s that always work
    try {
      await SpotifySdk.play(
          spotifyUri: "spotify:track:${trackId}", asRadio: true);

      print('trying to play spotify song spotify:track:$trackId');
      print('Adding to history');
      songHistoryProvider.addToHistory(trackData);
    } catch (err) {
      print("Failed with spotify error: $err");
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

  Future<TrackData> _getCurrentTrack() async {
    Track newTrackData = await getPlayerState();
    String trackId = newTrackData.uri;
    print("Before split $trackId");
    // splitting uri so we can extract the song id
    var array = trackId.split(':');
    print("Array split $array");
    trackId = array.last;
    print("After split $trackId");
    var currentTrack = TrackData(
        mood: '',
        trackId: trackId,
        artist: newTrackData.artist.name,
        name: newTrackData.name);
    return currentTrack;
  }

  TrackBloc(TrackData initialState, this.repository, this.likedSongProvider,
      this.songHistoryProvider)
      : super(initialState);
  @override
  Stream<TrackData> mapEventToState(TrackEvent event) async* {
    if (event is GetTrackEvent) {
      try {
        TrackData trackData =
            await repository.getAllDataThatMeetsRequirements(event.sentence);
        await _playSpotifyTrack(trackData);

        trackData = await _updateTrackData(trackData);
        // updating the trackData for name and artist

        yield trackData;
      } catch (error) {
        yield TrackData(mood: 'anger', trackId: '7GhIk7Il098yCjg4BQjzvb');
        // play a really funky song on failure.
      }
    } else if (event is SkipTrackEvent) {
      TrackData trackData = await repository.getDataFromLastMood();
      await _playSpotifyTrack(trackData);
      trackData = await _updateTrackData(trackData);
      yield trackData;
    } else if (event is SkipPreviousEvent) {
      // get the last track from history
      TrackData lastSong = songHistoryProvider.getLastTrack();
      await _playSpotifyTrack(lastSong);
      lastSong = await _updateTrackData(lastSong);
      yield lastSong;
    } else if (event is FeelingLuckyEvent) {
      TrackData trackData = await repository.getFeelingLuckyTrack();
      await _playSpotifyTrack(trackData);
      trackData = await _updateTrackData(trackData);
      // updating the trackData for name and artist
      yield trackData;
    } else if (event is LikeEvent) {
      // getting the current track from player state.
      TrackData currentSong = await _getCurrentTrack();
      await likedSongProvider.addLikedSong(currentSong);
    } else if (event is DislikeEvent) {
      //Read track parameters from JSON
      //function that changese the parameters for whatever mood range was disliked
      //update the track params json
    } else if (event is PlayLikedSongEvent) {
      TrackData likedSong = event.song;
      await _playSpotifyTrack(likedSong);
      yield likedSong;
    }
  }
}
