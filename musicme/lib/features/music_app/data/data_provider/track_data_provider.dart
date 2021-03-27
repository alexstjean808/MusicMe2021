import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:musicme/features/music_app/data/entities/track_data.dart';
import 'package:musicme/features/music_app/data/entities/track_query_params.dart';
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
    print("Mood was confident of analytical: Generatingg a random mood.");
    var moods = ['joy', 'anger', 'sadness'];
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

  Params _getQueryParams(var moodIn) {
    var moods = ['joy', 'anger', 'sadness'];
    TrackQueryParams params = TrackQueryParams();
    params.mood = moodIn;

    if (moods.contains(moodIn) == false) {
      params.mood =
          _getRandomMood(); // if the mood doesnt exist then this function will return a random mood to work with.
    }
    print("the mood in the params object is: ${params.mood}");
    if (params.mood == 'joy') {
      return params.trackMoodRanges.joyParams;
    } else if (params.mood == 'sadness') {
      return params.trackMoodRanges.sadnessParams;
    } else if (params.mood == 'anger') {
      return params.trackMoodRanges.angerParams;
    }

    return params.trackMoodRanges.joyParams;
  }

  Future<TrackData> getFeelingLuckyTrack() async {
    var range = 15000;
    var randomNumber = Random().nextInt(range);

    //parameters are key for the firebase and a random number between 0 and the length of the database that we hardcoded
    //code taken mostly from https://curl.trillworks.com/#dart
    var params = {
      'orderBy': r'%22$key%22',
      'equalTo': '%22' + randomNumber.toString() + '%22',
    };
    var query = params.entries.map((p) => '${p.key}=${p.value}').join('&');

    var res = await http.get(
        'https://musicme-fd43b-default-rtdb.firebaseio.com/tracks.json?$query');
    if (res.statusCode != 200) {
      throw Exception('http.get error: statusCode= ${res.statusCode}');
    }
    //end code from curl.trillworks.com

    var returnJSON =
        convert.jsonDecode(res.body); //convert http response to JSON
    var trueSongNumber = returnJSON.keys.toList()[0];

    var randomSongId = returnJSON[trueSongNumber]['id'];
    var trackData = TrackData(trackId: randomSongId);
    return trackData;
  }

  Future<TrackData> getTrack(String sentence) async {
    // ignore: omit_local_variable_types
    // this gets the mood from the IBM tone analyser
    var moodDataProvider = MoodDataProvider();
    // ibmData now has a mood string in it.
    var ibmData = await moodDataProvider.readData(sentence);
    // here we are getting the document tone mood
    var mood = ibmData.documentTones.tones[0].toneId;
    // logging mood to console.
    print(mood);
    // ignore: omit_local_variable_types
    //TODO: change this to read local params in track_query_params.json
    // this will be talkging to the query Params data provider
    Params params = _getQueryParams(mood);

    // Query by energy!
    // we always sort by energy first cause every single mood will have an energy param.
    var energyQueryParams = {
      'orderBy': '"energy"',
      'startAt': '${params.energy[0]}',
      'endAt': '${params.energy[1]}',
      'limitToLast': '100',
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

    if (params.mood == 'joy' || params.mood == 'sadness') {
      returnJSON = filterTrackAttributes(
          lowRange: params.danceability[0],
          highRange: params.danceability[1],
          trackAttb: 'danceability',
          songKeyList: songKeyList,
          returnJSON: returnJSON);
    } else if (params.mood == 'anger') {
      returnJSON = filterTrackAttributes(
          lowRange: params.acousticness[0],
          highRange: params.acousticness[1],
          trackAttb: 'acousticness',
          songKeyList: songKeyList,
          returnJSON: returnJSON);
    } else {
      //default params are for joy
      returnJSON = filterTrackAttributes(
          lowRange: params.danceability[0],
          highRange: params.danceability[1],
          trackAttb: 'danceability',
          songKeyList: songKeyList,
          returnJSON: returnJSON);
      print('mood not detected');
    }

    // aslong as it works!
    var trackKeysLen = returnJSON.length;

    var randNum =
        Random().nextInt(trackKeysLen); // gives random number from 0 to length
    print('Random Number: $randNum');

    var trackID = returnJSON[randNum];

    var track = TrackData(trackId: trackID);
    print("The track id in the data layer is: ${track.trackId}");
    return track;
  }

// returns a random emotion

}
