import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:musicme/features/music_app/core/methods/global_functions.dart';
import 'package:musicme/features/music_app/data/data_provider/query_params_provider.dart';
import 'package:musicme/features/music_app/data/entities/track_data.dart';
import 'package:musicme/features/music_app/data/entities/track_query_params.dart';
import 'package:musicme/features/music_app/data/entities/user.dart';
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

  List extractTrackIDs(Map trackMap) {
    List suitableTrackId = [];
    trackMap.forEach((key, value) {
      suitableTrackId.add(trackMap[key]['id']);
    });
    return suitableTrackId;
  }

  Map filterTrackAttributes(
      {String genre = 'none',
      dynamic lowRange,
      dynamic highRange,
      String trackAttb,
      Map returnJSON}) {
    //allows you to filter tracks based on a JSON key in the song... must be one of the attributes that is in doubles
    // ignore: omit_local_variable_types
    var startIndex = 0;
    var songKeyList = returnJSON.keys.toList();

    for (var i = startIndex; i < songKeyList.length; i++) {
      //currentSongKey is the highest identifier of a song from the database
      var currentSongKey = songKeyList[i];
      var currentSong = returnJSON['$currentSongKey'];
      //JSON object of one song in the loop
      //var currentSpotifyID = currentSong['id']; //spotify ID
      var currentAttribute =
          currentSong[trackAttb]; //danceability, energy, etc.
      var inRange =
          (currentAttribute >= lowRange) && (currentAttribute <= highRange);
      //returns true when the track attribute fits in the range

      // when no genre was inputted by user then skip this code.

      if (!inRange) {
        returnJSON.remove(currentSongKey);
      }
    }

    return returnJSON;
  }

// method that takes in queryParams and the mood and returns the correct param Ranges
  Ranges _selectParamRangeFromMood(TrackQueryParams queryParams, var moodIn) {
    if (moodIn == 'joy') {
      return queryParams.trackMoodRanges.joyParams;
    } else if (moodIn == 'sadness') {
      return queryParams.trackMoodRanges.sadnessParams;
    } else if (moodIn == 'anger') {
      return queryParams.trackMoodRanges.angerParams;
    }

    return queryParams.trackMoodRanges.joyParams;
  }

  Future<TrackData> getFeelingLuckyTrack() async {
    var range = 800000;
    var randomNumber = Random().nextInt(range);

    //parameters are key for the firebase and a random number between 0 and the length of the database that we hardcoded
    //code taken mostly from https://curl.trillworks.com/#dart
    var query = randomNumber.toString();
//https://musicme-fd43b-default-rtdb.firebaseio.com/finalTracks/100000.json
//https://musicme-fd43b-default-rtdb.firebaseio.com/finalTracks/100000/id.json

    var res = await http.get(
        'https://musicme-fd43b-default-rtdb.firebaseio.com/finalTracks/$query.json');
    if (res.statusCode != 200) {
      throw Exception('http.get error: statusCode= ${res.statusCode}');
    }
    //end code from curl.trillworks.com

    var returnJSON =
        convert.jsonDecode(res.body); //convert http response to JSON

    var randomSongId = returnJSON['id'];
    var trackData = TrackData(mood: _getRandomMood(), trackId: randomSongId);
    return trackData;
  }

// this gets a track from the database!
  Future<TrackData> getTrackFromSentence(String sentence, User user) async {
    //makes default value musicme
    //makes default value musicme

    // all possible moods
    var moods = ['joy', 'anger', 'sadness'];
    // this gets the mood from the IBM tone analyser
    var moodDataProvider = MoodDataProvider();
    // ibmData now has a mood string in it.
    var ibmData = await moodDataProvider.readData(sentence);
    // here we are getting the document tone mood
    var mood = ibmData.documentTones.tones[0].toneId;
    // logging mood to console.
    print(mood);

    // when IBM doesnt give us a mood of joy anger or sadness we generate a random mood
    // from the moods array.
    if (moods.contains(mood) == false) {
      mood =
          _getRandomMood(); // if the mood doesnt exist then this function will return a random mood to work with.
    }
    // Reading the data from track_query_params
    var trackQueryParams = await QueryParamsProvider().readParams(user);
    // now we will get all the ranges for whatever mood we got from IBM
    Ranges ranges = _selectParamRangeFromMood(trackQueryParams, mood);

    // Query by energy!
    // we always sort by energy first if there is no genre cause every single mood will have an energy param.
    var energyQueryParams = {
      'orderBy': '"energy"',
      'startAt': '${ranges.energy[0]}',
      'endAt': '${ranges.energy[1]}',
      'limitToLast': '500',
      'print': 'pretty',
    };

    // gets a genre that we can query to the firebase database
    // this function is defined in the global functions area of the project.
    List inter = [];
    int counter = 0;
    // these three variables are attached to the
    var firstResponse;
    var songsFromFirstQuery;
    while (inter.length == 0) {
      //used to remember the first query to the database for error handling
      counter = counter + 1;
      var queryGenre;
      // precedence is as follows: country > genre > energy
      // when countries are selected, ignore the genre selections and query by country
      if (trackQueryParams.countries.length == 0) {
        queryGenre = filterToQueryGenre(trackQueryParams.genres);
      } else {
        queryGenre = filterToQueryGenre(trackQueryParams.countries);
      }
      var genreQueryParams = {
        'orderBy': '"genres"',
        'equalTo': '%22${queryGenre}%22',
        'limitToLast': '20',
        'print': 'pretty'
      };
      // initializing query variable in method scope
      var query;

      if (trackQueryParams.genres.length == 0 &&
          trackQueryParams.countries.length == 0) {
        //when there are no genres, query by energy
        query = energyQueryParams.entries
            .map((p) => '${p.key}=${p.value}')
            .join('&');
      } else {
        //when there are genres, query by genres
        query = genreQueryParams.entries
            .map((p) => '${p.key}=${p.value}')
            .join('&');
      }
      var queryUrl =
          'https://musicme-fd43b-default-rtdb.firebaseio.com/finalTracks.json?$query';
      print(queryUrl);

      var response = await http.get(queryUrl);
      if (response.statusCode != 200) {
        throw Exception('http.get error: statusCode= ${response.statusCode}');
      }

      print(response.statusCode);
      Map returnJSON =
          convert.jsonDecode(response.body); //convert http response to JSON

      // save the first response from the database in case we overfilter the mood
      print('While Loop Count: $counter');
      if (counter == 1) {
        firstResponse = returnJSON;
        songsFromFirstQuery = extractTrackIDs(firstResponse);
      }

      // skipped initial query by energy if we started with the Genre query instead
      if (trackQueryParams.genres.length != 0) {
        returnJSON = filterTrackAttributes(
            genre: queryGenre,
            lowRange: ranges.energy[0],
            highRange: ranges.energy[1],
            trackAttb: 'danceability',
            returnJSON: returnJSON);
      }

      if (mood == 'joy' || mood == 'sadness') {
        returnJSON = filterTrackAttributes(
            lowRange: ranges.danceability[0],
            highRange: ranges.danceability[1],
            trackAttb: 'danceability',
            returnJSON: returnJSON);
      } else if (mood == 'anger') {
        returnJSON = filterTrackAttributes(
            lowRange: ranges.acousticness[0],
            highRange: ranges.acousticness[1],
            trackAttb: 'acousticness',
            returnJSON: returnJSON);
      } else {
        //default ranges are for joy
        returnJSON = filterTrackAttributes(
            lowRange: ranges.danceability[0],
            highRange: ranges.danceability[1],
            trackAttb: 'danceability',
            returnJSON: returnJSON);
        print('mood not detected');
      }

      // this gets a random track ID that fits our filter params.
      print(returnJSON.length);

      // stops the loop after 10 attemps and assigns inter to the list of all the unfiltered trackID's
      if (counter > 10) {
        inter = songsFromFirstQuery;
      } else {
        inter = extractTrackIDs(returnJSON);
      }
      print(inter);
      print("inter bool:");
      print(inter == []);
    }
    var trackID = getRandomFromList(inter);
    // we  give the track a mood so we can update the background in the application.
    var track = TrackData(mood: mood, trackId: trackID);
    print("The track id in the data layer is: ${track.trackId}");
    return track;
  }

  Future<TrackData> getTrackFromLastMood(User user) async {
    // this gets the mood from the IBM tone analyser
    var moodDataProvider = MoodDataProvider();
    // ibmData now has a mood string in it.

    // here we are getting the document tone mood
    var mood = moodDataProvider.getLastMoodFromHistory();
    // logging mood to console.
    print(mood);

    // Reading the data from track_query_params
    var trackQueryParams = await QueryParamsProvider().readParams(user);
    // now we will get all the ranges for whatever mood we got from IBM
    Ranges ranges = _selectParamRangeFromMood(trackQueryParams, mood);

    // Query by energy!
    // we always sort by energy first if there is no genre cause every single mood will have an energy param.
    var energyQueryParams = {
      'orderBy': '"energy"',
      'startAt': '${ranges.energy[0]}',
      'endAt': '${ranges.energy[1]}',
      'limitToLast': '500',
      'print': 'pretty',
    };

    // gets a genre that we can query to the firebase database
    // this function is defined in the global functions area of the project.
    List inter = [];
    int counter = 0;
    // these three variables are attached
    var firstResponse;
    var songsFromFirstQuery;
    while (inter.length == 0) {
      //used to remember the first query to the database for error handling
      counter = counter + 1;
      var queryGenre;
      // precedence is as follows: country > genre > energy
      // when countries are selected, ignore the genre selections and query by country
      if (trackQueryParams.countries.length == 0) {
        queryGenre = filterToQueryGenre(trackQueryParams.genres);
      } else {
        queryGenre = filterToQueryGenre(trackQueryParams.countries);
      }
      var genreQueryParams = {
        'orderBy': '"genres"',
        'equalTo': '%22${queryGenre}%22',
        'limitToLast': '20',
        'print': 'pretty'
      };
      // initializing query variable in method scope
      var query;

      if (trackQueryParams.genres.length == 0 &&
          trackQueryParams.countries.length == 0) {
        //when there are no genres, query by energy
        query = energyQueryParams.entries
            .map((p) => '${p.key}=${p.value}')
            .join('&');
      } else {
        //when there are genres, query by genres
        query = genreQueryParams.entries
            .map((p) => '${p.key}=${p.value}')
            .join('&');
      }
      var queryUrl =
          'https://musicme-fd43b-default-rtdb.firebaseio.com/finalTracks.json?$query';
      print(queryUrl);

      var response = await http.get(queryUrl);
      if (response.statusCode != 200) {
        throw Exception('http.get error: statusCode= ${response.statusCode}');
      }

      print(response.statusCode);
      Map returnJSON =
          convert.jsonDecode(response.body); //convert http response to JSON

      // save the first response from the database in case we overfilter the mood
      print('While Loop Count: ${counter}');
      if (counter == 1) {
        firstResponse = returnJSON;
        songsFromFirstQuery = extractTrackIDs(firstResponse);
      }

      // skipped initial query by energy if we started with the Genre query instead
      if (trackQueryParams.genres.length != 0) {
        returnJSON = filterTrackAttributes(
            genre: queryGenre,
            lowRange: ranges.energy[0],
            highRange: ranges.energy[1],
            trackAttb: 'danceability',
            returnJSON: returnJSON);
      }

      if (mood == 'joy' || mood == 'sadness') {
        returnJSON = filterTrackAttributes(
            lowRange: ranges.danceability[0],
            highRange: ranges.danceability[1],
            trackAttb: 'danceability',
            returnJSON: returnJSON);
      } else if (mood == 'anger') {
        returnJSON = filterTrackAttributes(
            lowRange: ranges.acousticness[0],
            highRange: ranges.acousticness[1],
            trackAttb: 'acousticness',
            returnJSON: returnJSON);
      } else {
        //default ranges are for joy
        returnJSON = filterTrackAttributes(
            lowRange: ranges.danceability[0],
            highRange: ranges.danceability[1],
            trackAttb: 'danceability',
            returnJSON: returnJSON);
        print('mood not detected');
      }

      // this gets a random track ID that fits our filter params.
      print(returnJSON.length);

      // stops the loop after 10 attemps and assigns inter to the list of all the unfiltered trackID's
      if (counter > 10) {
        inter = songsFromFirstQuery;
      } else {
        inter = extractTrackIDs(returnJSON);
      }
      print(inter);
      print("inter bool:");
      print(inter == []);
    }
    var trackID = getRandomFromList(inter);
    // we  give the track a mood so we can update the background in the application.
    var track = TrackData(mood: mood, trackId: trackID);
    print("The track id in the data layer is: ${track.trackId}");
    return track;
  }
}
