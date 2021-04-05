// this class interacts with a dart list of song history to
// build out our own back button

import '../local_data/song_history.dart';
import 'package:musicme/features/music_app/data/entities/track_data.dart';

// GLOBAL VARIABE CALLED SONG HISTOY
class SongHistoryProvider {
  // INPUT: a song that must be added to the history
  // content: adds the song to the history at song_history.dart
  // output: nothing
  addToHistory(TrackData songToAdd) {
    songHistory.add(songToAdd);
  }

  // INPUT: nothing
  // content: gets the song history in a list from song_history.dart
  // output: song history in a list
  TrackData getLastTrack() {
    if (songHistory.length == 1) {
      // if there is only one song in the histroy then return that song.
      return songHistory.removeLast();
    }
    if (songHistory.isEmpty) {
      //adding blank for return so no error will be thrown.
      songHistory.add(TrackData(mood: ''));
      songHistory.add(TrackData(mood: ''));
    }

    // returning second last element and remove it
    return songHistory.removeAt(songHistory.length - 2);
  }
}
