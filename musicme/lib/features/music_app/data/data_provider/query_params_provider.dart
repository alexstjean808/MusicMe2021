import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:musicme/features/music_app/data/entities/track_data.dart';
import 'package:musicme/features/music_app/data/entities/track_query_params.dart';
import 'dart:convert';
import '../../core/methods/dislike_update.dart';
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
  Future<void> updateParamRanges(TrackData dislikedTrack, User user) async {
    // get all the current data on the disliked track.
    var params = {
      'orderBy': '%22id%22',
      'equalTo': '%22${dislikedTrack.trackId}%22',
      'limitToFirst': '10',
      'print': 'pretty',
    };
    var query = params.entries.map((p) => '${p.key}=${p.value}').join('&');
    var res = await http.get(
        'https://musicme-fd43b-default-rtdb.firebaseio.com/finalTracks.json?$query');
    if (res.statusCode != 200)
      throw Exception('http.get error: statusCode= ${res.statusCode}');

    // now we have a map with all the information on the song.
    Map dislikedSongParams = JsonDecoder().convert(res.body);
    var keys = dislikedSongParams.keys;

    Map newParams = updateQueryRanges(
        dislikedSongParams[keys.elementAt(0)]["energy"],
        dislikedSongParams[keys.elementAt(0)]["danceability"],
        dislikedSongParams[keys.elementAt(0)]["acousticness"],
        dislikedTrack.mood,
        user.email);

    // now write map to server

    res = await http.get(
        'https://musicme-fd43b-default-rtdb.firebaseio.com/queryParams/${user.email}.json');
    if (res.statusCode != 200) {
      throw Exception('http.get error: statusCode= ${res.statusCode}');
    }
    print("resbody before update: ${res.body}");
    var jsonObject = JsonDecoder().convert(res.body);
    // adding the genre to the existing list of genres in track_query_params.json
    // it only adds the genre if it doesnt exist already in the array.
    jsonObject['track_mood_ranges'] ??= [];

    jsonObject['track_mood_ranges'] = newParams;
    // writing the appended file.
    var jsonString = JsonEncoder().convert(jsonObject);

    res = await http.put(
        'https://musicme-fd43b-default-rtdb.firebaseio.com/queryParams/${user.email}.json',
        body: jsonString);
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////USER GENRE
  // When a user selects a genre that genre will be added to the list of genres in track_query_params.json
  // input string of a genre the user want to query with
  // content: opens track_query_params.json and appends the file
  // returns: nothing.
  addUserGenres(String genreInput, User user) async {
    String email = user.email;

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
  removeUserGenres(String genreInput, User user) async {
    //makes default value musicme
    String email = user.email;

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
  addUserCountries(String countryInput, User user) async {
    //makes default value musicme
    String email = user.email;

    var res = await http.get(
        'https://musicme-fd43b-default-rtdb.firebaseio.com/queryParams/${email}.json');
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
  removeUserCountries(String countryInput, User user) async {
    //makes default value musicme
    String email = user.email;
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

/////////////////////////////////////////////////////////////////////TESTING COUNTRY

  // this method will read whatever mood ranges are defined for a user
  // in track_mood_ranges.json on the firebase server
  // INPUT: nothing
  // CONTENT: take info from track_query_params.json
  // OUTPUT: A Track Mood Ranges object that we can use in the track_data_provider.dart
  // in order to query the correct track.
  Future<TrackQueryParams> readParams(User user) async {
    //makes default value musicme
    String email = user.email;

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
