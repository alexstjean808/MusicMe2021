// this class interacts with a dart list of song history to
// build out our own back button

import 'dart:async';

import 'package:musicme/features/music_app/data/entities/track_data.dart';

class SongHistoryProvider {
  // INPUT: a song that must be added to the history
  // content: adds the song to the history at song_history.dart
  // output: nothing
  addToHistory(TrackData songToAdd) {
    //TODO: impliment contents
  }
  // INPUT: nothing
  // content: gets the song history in a list from song_history.dart
  // output: song history in a list
  Future<List<TrackData>> readHistory() async {
    //TODO: impliment contents
  }
}
