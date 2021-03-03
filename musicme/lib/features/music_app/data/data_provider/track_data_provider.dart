import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:musicme/features/music_app/data/entities/track.dart';
import 'dart:async';
import 'dart:math';
import 'mood_data_provider.dart';

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

  List filterTrackAttributes(
      {double lowRange,
      double highRange,
      String trackAttb,
      List songKeyList,
      var returnJSON}) {
    //allows you to filter tracks based on a JSON key in the song... must be one of the attributes that is in doubles
    // ignore: omit_local_variable_types
    List suitableTracks = [];
    var startIndex = 0;
    for (var i = startIndex; i < songKeyList.length; i++) {
      var currentSongKey = songKeyList[
          i]; //currentSongKey is the highest identifier of a song from the database
      var currentSong = returnJSON['$currentSongKey'];
      //JSON object of one song in the loop
      var currentSpotifyID = currentSong['id']; //spotify ID
      var currentAttribute =
          currentSong[trackAttb]; //danceability, energy, etc.
      var cont =
          (currentAttribute >= lowRange) && (currentAttribute <= highRange);
      //returns true when the track attribute fits in the range
      if (cont) {
        suitableTracks.add(currentSpotifyID);
      }
    }
    return suitableTracks;
  }

  TrackQueryParams _getQueryParams(var moodIn) {
    var mood = moodIn;
    var moods = ['joy', 'anger', 'sadness'];
    TrackQueryParams params = TrackQueryParams();

    if (moods.contains(mood) == false) {
      mood =
          _getRandomMood(); // if the mood doesnt exist then this function will return a random mood to work with.
    }
    if (mood == 'joy') {
      params.major = 1;
      params.danceability = [0.5, 1];
      params.energy = [0.8, 1];
    } else if (mood == 'sadness') {
      params.major = 0;
      params.danceability = [0, 0.4];
      params.energy = [0, 0.6];
    } else if (mood == 'anger') {
      params.acousticness = [0, 0.6];
      params.energy = [0.5, .9];
    } else {
      params.major = 1;
      params.danceability = [0.5, 1];
      params.energy = [0.6, 1]; // default Params to joy
    }
    params.mood = mood;
    return params;
  }

  Future<Track> readData(String sentence) async {
    // ignore: omit_local_variable_types
    var moodDataProvider = MoodDataProvider();
    var ibmData = await moodDataProvider.readData(sentence);
    var mood = ibmData.documentTones.tones[0].toneId;
    print(mood);
    // ignore: omit_local_variable_types
    TrackQueryParams params = _getQueryParams(mood);

    // Query by energy!
    var energyQueryParams = {
      'orderBy': '"energy"',
      'startAt': '${params.energy[0]}',
      'endAt': '${params.energy[1]}',
      'limitToLast': '20',
      'print': 'pretty',
    };
    var query =
        energyQueryParams.entries.map((p) => '${p.key}=${p.value}').join('&');

    var response = await http.get(
        'https://musicme-fd43b-default-rtdb.firebaseio.com/tracks.json?$query');
    if (response.statusCode != 200) {
      throw Exception('http.get error: statusCode= ${response.statusCode}');
    }

    var returnJSON =
        convert.jsonDecode(response.body); //convert http response to JSON

    var songKeyList = returnJSON.keys.toList();

    if (mood == 'joy' || mood == 'sadness') {
      returnJSON = filterTrackAttributes(
          lowRange: params.danceability[0],
          highRange: params.danceability[1],
          trackAttb: 'danceability',
          songKeyList: songKeyList,
          returnJSON: returnJSON);
    } else if (mood == 'anger') {
      returnJSON = filterTrackAttributes(
          lowRange: params.acousticness[0],
          highRange: params.acousticness[1],
          trackAttb: 'acousticness',
          songKeyList: songKeyList,
          returnJSON: returnJSON);
    } else {
      print('mood not detected');
    }

    // aslong as it works!
    var trackKeysLen = returnJSON.length;

    var randNum =
        Random().nextInt(trackKeysLen); // gives random number from 0 to length
    print('Random Number: $randNum');

    var trackID = returnJSON[randNum];

    var track = Track(trackId: trackID);

    return track;
  }

// returns a random emotion

}
