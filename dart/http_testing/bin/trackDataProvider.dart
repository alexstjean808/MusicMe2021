import 'dart:convert' as convert;
import 'dart:io';
import 'dart:web_audio';
import 'package:http/http.dart' as http;
import 'moodDataProvider.dart';
import 'sampleEntityIbmData.dart';
import 'dart:async';
import 'dart:math';

import 'track.dart';

/* trackDataProvider.dart
Request track from Firebase
Input void
Output track_ID
*/

class TrackDataProvider {
  String _getRandomMood() {
    var moods = ['joy', 'anger', 'sad'];
    return moods[Random().nextInt(3)];
  }

  TrackQueryParams _getQueryParams(var moodIn) {
    var mood = moodIn;
    var moods = ['joy', 'anger', 'sad'];
    TrackQueryParams params = TrackQueryParams();

    if (moods.contains(mood) == false) {
      mood =
          _getRandomMood(); // if the mood doesnt exist then this function will return a random mood to work with.
    }
    if (mood == 'joy') {
      params.major = 1;
      params.danceability = [0.5, 1];
      params.energy = [0.6, 1];
    } else if (mood == 'sadness') {
      params.major = 0;
      params.danceability = [0, 0.4];
      params.energy = [0, 0.6];
    } else if (mood == 'anger') {
      params.acousticness = [0, 0.6];
      params.energy = [0.6, 1];
    } else {
      params.major = 1;
      params.danceability = [0.5, 1];
      params.energy = [0.6, 1]; // default Params to joy
    }
  }

  Future<Track> readData(String mood) async {
    // ignore: omit_local_variable_types
    TrackQueryParams params = _getQueryParams(mood);
    // Query by energy!
    var energyQueryParams = {
      'orderBy': '"energy"',
      'startAt': '${params.energy[0]}',
      'endAt': '${params.energy[1]}',
      'limitToLast': '10',
      'print': 'pretty',
    };
    var query =
        energyQueryParams.entries.map((p) => '${p.key}=${p.value}').join('&');

    var response = await http.get(
        'https://musicme-fd43b-default-rtdb.firebaseio.com/tracks.json?$query');
    if (response.statusCode != 200)
      throw Exception('http.get error: statusCode= ${response.statusCode}');
    print(response.body);
    var returnJSON =
        convert.jsonDecode(response.body); //convert http response to JSON
    var songKeyList = returnJSON.keys.toList();
    var firstTrackKey = songKeyList[0];
    var firstTrackID = returnJSON[firstTrackKey]['id'];

    var track = Track(trackId: firstTrackID);

    return track;
  }

// returns a random emotion

  Future<void> main() async {}
}
