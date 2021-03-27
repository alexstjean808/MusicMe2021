import 'dart:async';
import 'dart:convert';
import 'package:musicme/features/music_app/data/entities/track_query_params.dart';
import 'dart:io';

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

  // this method will read whatever mood ranges are defined for a user
  // in track_mood_ranges.json
  // INPUT: nothing
  // CONTENT: take info from track_query_params.json
  // OUTPUT: A Track Mood Ranges object that we can use in the track_data_provider.dart
  // in order to query the correct track.
  Future<TrackQueryParams> readParamRanges() async {
    print("Current directory is ${Directory.current}");

    var filePath =
        'lib/features/music_app/data/local_data/track_query_params.json';

    print('Reading file $filePath');
    print(Directory.current);
    // This opens are reading the data from track_query_params.
    var input = await File(filePath).readAsString();
    var jsonFile = JsonDecoder().convert(input);
    var trackQueryParams = TrackQueryParams.fromJson(jsonFile);
    return trackQueryParams;
  }

  testMethod() {
    print("Is this running in the test method");
    return 1;
  }
}
