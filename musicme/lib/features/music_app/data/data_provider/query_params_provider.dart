import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:musicme/features/music_app/data/entities/track_query_params.dart';
import 'dart:convert';

import 'package:musicme/features/music_app/data/entities/user.dart';

// this is a class that will interact track_mood_ranges.json
// It will contain methods that update the paramters based on some logic that needs to be determined
//
class QueryParamsProvider {
  // When the user disliked a song this method will be called to change the paramter ranges
  // in attempt to find better songs for the user.
  // INPUT: the method takes the mood of the last song queried
  // CONTENT: changes the paramters in some way so the user gets better songs in the future.
  // the code updates the track_mood_ranges.json file
  // OUTPUT: nothing
  // this function will most likely call on the readParamRanges() function to see what is already there.
  updateParamRanges(String lastMood) async {
    //TODO impliment method!
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////USER GENRE
  // When a user selects a genre that genre will be added to the list of genres in track_query_params.json
  // input string of a genre the user want to query with
  // content: opens track_query_params.json and appends the file
  // returns: nothing.
  addUserGenres(String genreInput, [User user]) async {
    String email;
    //makes default value musicme
    if (user == null) {
      email = "musicme";
    } else {
      email = user.email.substring(0, user.email.indexOf('@'));
    }

    var res = await http.get(
        'https://musicme-fd43b-default-rtdb.firebaseio.com/queryParams/$email.json');
    if (res.statusCode != 200) {
      throw Exception('http.get error: statusCode= ${res.statusCode}');
    }
    print(res.body);
    var jsonObject = JsonDecoder().convert(res.body);
    // adding the genre to the existing list of genres in track_query_params.json
    // it only adds the genre if it doesnt exist already in the array.
    jsonObject['genres'] ??= [];
    if (!(jsonObject['genres'].contains(genreInput))) {
      jsonObject['genres'].add(genreInput);
      // writing the appended file.
      var jsonString = JsonEncoder().convert(jsonObject);

      res = await http.put(
          'https://musicme-fd43b-default-rtdb.firebaseio.com/queryParams/$email.json',
          body: jsonString);
    }
  }

  // When a user selects a genre that genre will be removed to the list of genres in track_query_params.json
  // input string of a genre the user want to not query with
  // content: opens track_query_params.json and appends the file
  // returns: nothing.
  removeUserGenres(String genreInput, [User user]) async {
    //makes default value musicme
    String email;
    if (user == null) {
      email = "musicme";
    } else {
      email = user.email.substring(0, user.email.indexOf('@'));
    }
    var res = await http.get(
        'https://musicme-fd43b-default-rtdb.firebaseio.com/queryParams/$email.json');
    if (res.statusCode != 200) {
      throw Exception('http.get error: statusCode= ${res.statusCode}');
    }
    var jsonObject = JsonDecoder().convert(res.body);
    print(res.body);
    // adding the genre to the existing list of genres in track_query_params.json
    // it only adds the genre if it doesnt exist already in the array.
    jsonObject['genres'] ??= [];
    if (jsonObject['genres'].contains(genreInput)) {
      jsonObject['genres'].remove(genreInput);
      // writing the appended file.
      var jsonString = JsonEncoder().convert(jsonObject);

      res = await http.put(
          'https://musicme-fd43b-default-rtdb.firebaseio.com/queryParams/$email.json',
          body: jsonString);
    }
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////END USER GENRE

////////////////////////////////////////////////////////////////////TESTING COUNTRY
  addUserCountries(String countryInput, [User user]) async {
    //makes default value musicme
    String email;
    if (user == null) {
      email = "musicme";
    } else {
      email = user.email.substring(0, user.email.indexOf('@'));
    }
    var res = await http.get(
        'https://musicme-fd43b-default-rtdb.firebaseio.com/queryParams/$email.json');
    if (res.statusCode != 200) {
      throw Exception('http.get error: statusCode= ${res.statusCode}');
    }
    print(res.body);
    var jsonObject = JsonDecoder().convert(res.body);
    // adding the genre to the existing list of genres in track_query_params.json
    // it only adds the genre if it doesnt exist already in the array.
    jsonObject['countries'] ??= [];
    if (!(jsonObject['countries'].contains(countryInput))) {
      jsonObject['countries'].add(countryInput);
      // writing the appended file.
      var jsonString = JsonEncoder().convert(jsonObject);

      res = await http.put(
          'https://musicme-fd43b-default-rtdb.firebaseio.com/queryParams/$email.json',
          body: jsonString);
    }
  }

  // When a user selects a country that country will be removed to the list of countries in track_query_params.json
  // input string of a genre the user want to not query with
  // content: opens track_query_params.json and appends the file
  // returns: nothing.
  removeUserCountries(String countryInput, [User user]) async {
    //makes default value musicme
    String email;
    if (user == null) {
      email = "musicme";
    } else {
      email = user.email.substring(0, user.email.indexOf('@'));
    }
    var res = await http.get(
        'https://musicme-fd43b-default-rtdb.firebaseio.com/queryParams/$email.json');
    if (res.statusCode != 200) {
      throw Exception('http.get error: statusCode= ${res.statusCode}');
    }
    var jsonObject = JsonDecoder().convert(res.body);
    print(res.body);
    // adding the genre to the existing list of genres in track_query_params.json
    // it only adds the genre if it doesnt exist already in the array.
    jsonObject['countries'] ??= [];
    if (jsonObject['countries'].contains(countryInput)) {
      jsonObject['countries'].remove(countryInput);
      // writing the appended file.
      var jsonString = JsonEncoder().convert(jsonObject);

      res = await http.put(
          'https://musicme-fd43b-default-rtdb.firebaseio.com/queryParams/$email.json',
          body: jsonString);
    }
  }

  initializeNewUser([User user]) async {
    //makes default value musicme
    String email;
    if (user == null) {
      email = "musicme";
    } else {
      email = user.email.substring(0, user.email.indexOf('@'));
    }
    var initialQueryMap = {
      "track_mood_ranges": {
        "anger_params": {
          "acousticness": [0, 0.6],
          "danceability": [0],
          "energy": [0.6, 1],
          "major": 1
        },
        "joy_params": {
          "acousticness": [0],
          "danceability": [0.5, 1],
          "energy": [0.6, 1],
          "major": 1
        },
        "sadness_params": {
          "acousticness": [0],
          "danceability": [0, 0.4],
          "energy": [0, 0.6],
          "major": 1
        }
      }
    };

    var jsonString = JsonEncoder().convert(initialQueryMap);

    var res = await http.put(
        'https://musicme-fd43b-default-rtdb.firebaseio.com/queryParams/$email.json',
        body: jsonString);
  }

/////////////////////////////////////////////////////////////////////TESTING COUNTRY

  // this method will read whatever mood ranges are defined for a user
  // in track_mood_ranges.json on the firebase server
  // INPUT: nothing
  // CONTENT: take info from track_query_params.json
  // OUTPUT: A Track Mood Ranges object that we can use in the track_data_provider.dart
  // in order to query the correct track.
  Future<TrackQueryParams> readParams([User user]) async {
    //makes default value musicme
    String email;
    if (user == null) {
      email = "musicme";
    } else {
      email = user.email.substring(0, user.email.indexOf('@'));
    }
    var res = await http.get(
        'https://musicme-fd43b-default-rtdb.firebaseio.com/queryParams/$email.json');
    if (res.statusCode != 200) {
      throw Exception('http.get error: statusCode= ${res.statusCode}');
    }
    var mapResponse = JsonDecoder().convert(res.body);
    print(res.body);

    var trackQueryParams = TrackQueryParams.fromJson(mapResponse);

    return trackQueryParams;
  }
}
