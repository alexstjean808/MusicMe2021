import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:musicme/features/music_app/data/entities/track_query_params.dart';
import 'package:universal_io/io.dart.';

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

  // When a user selects a genre that genre will be added to the list of genres in track_query_params.json
  // input string of a genre the user want to query with
  // content: opens track_query_params.json and appends the file
  // returns: nothing.
  addUserGenres(String genreInput) async {
    debugger();
    var filePath =
        'lib/features/music_app/data/local_data/track_query_params.json';

    print('Reading file $filePath');
    // This opens are reading the data from track_query_params.
    var fileAsString = await File(filePath).readAsString();
    var jsonFile = JsonDecoder().convert(fileAsString);
    // adding the genre to the existing list of genres in track_query_params.json
    // it only adds the genre if it doesnt exist already in the array.
    var output;
    if (!(jsonFile['genres'].contains(genreInput))) {
      jsonFile['genres'].add(genreInput);
      // writing the appended file.
      var dataToWrite = jsonFile;
      var jsonFileOutPut = JsonEncoder().convert(dataToWrite);

      output = await File(filePath).writeAsString(jsonFileOutPut);
    }
    print(output);
  }

  // When a user selects a genre that genre will be removed to the list of genres in track_query_params.json
  // input string of a genre the user want to not query with
  // content: opens track_query_params.json and appends the file
  // returns: nothing.
  removeUserGenres(String genreInput) async {
    var filePath =
        'lib/features/music_app/data/local_data/track_query_params.json';

    print('Reading file $filePath');
    // This opens are reading the data from track_query_params.
    var fileAsString = await File(filePath).readAsString();
    var jsonFile = JsonDecoder().convert(fileAsString);
    // adding the genre to the existing list of genres in track_query_params.json
    // it only adds the genre if it doesnt exist already in the array.
    var output;
    if (jsonFile['genres'].contains(genreInput)) {
      jsonFile['genres'].remove(genreInput);
      // writing the appended file.
      var dataToWrite = jsonFile;
      var jsonFileOutPut = JsonEncoder().convert(dataToWrite);

      output = await File(filePath).writeAsString(jsonFileOutPut);
    }
    print(output);
  }

  // this method will read whatever mood ranges are defined for a user
  // in track_mood_ranges.json
  // INPUT: nothing
  // CONTENT: take info from track_query_params.json
  // OUTPUT: A Track Mood Ranges object that we can use in the track_data_provider.dart
  // in order to query the correct track.
  Future<TrackQueryParams> readParams() async {
    var filePath =
        'lib/features/music_app/data/local_data/track_query_params.json';

    print('Reading file $filePath');
    // This opens are reading the data from track_query_params.
    var fileAsString = await File(filePath).readAsString();
    var jsonFile = JsonDecoder().convert(fileAsString);
    var trackQueryParams = TrackQueryParams.fromJson(jsonFile);

    return trackQueryParams;
  }
}
