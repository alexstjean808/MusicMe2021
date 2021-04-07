import 'package:flutter_test/flutter_test.dart';
import 'package:musicme/features/music_app/core/methods/get_user.dart';
import 'package:musicme/features/music_app/data/data_provider/query_params_provider.dart';
import 'package:musicme/features/music_app/data/entities/track_data.dart';
import 'package:musicme/features/music_app/data/entities/track_query_params.dart';
import 'package:musicme/features/music_app/data/entities/user.dart';
import 'package:musicme/features/music_app/data/local_data/user_data.dart';

void main() {
  // IMPORTANT: for testing these files make sure track_query_params.json has "genres": ["Rock", "Jazz", "Pop"]
// or the test wont pass.
  test('getQueryParams correctly returns TrackQueryParams', () async {
    // ARRANGE
    var queryParamProvider = QueryParamsProvider();
    // ACT
    var trackQueryParams = await queryParamProvider.readParams(userGLOBAL);

    // ASSERT
    expect(trackQueryParams.runtimeType, TrackQueryParams);
  });
  test('we correctly read Danceability', () async {
    // ARRANGE
    var queryParamProvider = QueryParamsProvider();
    // ACT
    TrackQueryParams trackQueryParams =
        await queryParamProvider.readParams(userGLOBAL);

    // ASSERT

    expect(trackQueryParams.trackMoodRanges.sadnessParams.danceability,
        [0.0, 0.4]);
  });
  test('Correctly read the genres', () async {
    // ARRANGE
    TrackQueryParams trackQueryParams =
        await QueryParamsProvider().readParams(userGLOBAL);
    var genres = trackQueryParams.genres;
    // ACT

    // ASSERT
    expect(genres, ["Rock", "Jazz", "Pop"]);
  });

  // These tests below are to demonstrate how flutter testing works.
  test('Correctly added provided genres to the JSON file', () async {
    // ARRANGE
    var testQueryParam = QueryParamsProvider();
    // reading the current file (this is dependedt on file reading working)
    // this checks to see
    var current = await testQueryParam.readParams(userGLOBAL);
    current.genres.add('Pop');

    var expected = current.genres;
    // ACT
    // adding Pop to the list
    await testQueryParam.addUserGenres('Pop', userGLOBAL);
    var output = await testQueryParam.readParams(userGLOBAL);
    // ASSERT
    // output should be first list read + string that was added
    // in this case [..., 'Pop']
    expect(output.genres, expected);
  });
  test('Correctly does not add duplicate genres', () async {
    // ARRANGE
    var testQueryParam = QueryParamsProvider();
    // reading the current file (this is dependedt on file reading working)
    // this checks to see
    var current = await testQueryParam.readParams(userGLOBAL);
    var expected = current.genres;
    // ACT
    // adding Pop to the list
    await testQueryParam.addUserGenres('Pop', userGLOBAL);
    var output = await testQueryParam.readParams(userGLOBAL);
    // ASSERT
    // ooutput should be the same as what was in the file before cause we tried to add a
    // genre that already existed.
    // in this case [...]
    expect(output.genres, expected);
  });
  test('Correctly removes provided genres to the JSON file', () async {
    // ARRANGE
    var testQueryParam = QueryParamsProvider();
    // reading the current file (this is dependedt on file reading working)
    // this checks to see
    var current = await testQueryParam.readParams(userGLOBAL);
    current.genres.remove('Pop');
    current.genres.remove('Rock');
    current.genres.remove('Hip-Hop Rap');
    current.genres.remove('Jazz');

    var expected = current.genres;
    // ACT
    // adding Pop to the list
    await testQueryParam.removeUserGenres('Pop', userGLOBAL);
    await testQueryParam.removeUserGenres('Rock', userGLOBAL);
    await testQueryParam.removeUserGenres('Hip-Hop Rap', userGLOBAL);
    var output = await testQueryParam.readParams(userGLOBAL);
    // ASSERT
    // output should be first list read + string that was added
    // in this case [..., 'Pop']
    expect(output.genres, expected);
  });
//////////////////////////////////////////////////TESTING COUNTRIES
  test('Correctly does not add duplicate genres', () async {
    // ARRANGE
    var testQueryParam = QueryParamsProvider();
    // reading the current file (this is dependedt on file reading working)
    // this checks to see
    var current = await testQueryParam.readParams(userGLOBAL);
    var expected = current.countries;
    // ACT
    // adding Pop to the list
    await testQueryParam.addUserCountries('Uganda', userGLOBAL);
    var output = await testQueryParam.readParams(userGLOBAL);
    // ASSERT
    // ooutput should be the same as what was in the file before cause we tried to add a
    // genre that already existed.
    // in this case [...]
    expect(output.countries, expected);
  });
  test('Correctly removes provided countries to the JSON file', () async {
    // ARRANGE
    var testQueryParam = QueryParamsProvider();
    // reading the current file (this is dependedt on file reading working)
    // this checks to see
    var current = await testQueryParam.readParams(userGLOBAL);
    current.countries.remove('Uganda');

    var expected = current.countries;
    // ACT
    // adding Pop to the list
    await testQueryParam.removeUserCountries('Uganda', userGLOBAL);

    var output = await testQueryParam.readParams(userGLOBAL);
    // ASSERT
    // output should be first list read + string that was added
    // in this case [..., 'Pop']
    expect(output.countries, expected);
  });
  test('Initializes new user query parameters', () async {
    // ARRANGE
    var testQueryParam = QueryParamsProvider();
    var testUser =
        User(email: "thisisatest@testing.com", displayName: "MyDisplayName");

    // reading the current file (this is dependedt on file reading working)
    // this checks to see
    await initializeNewUser(testUser);

    // ACT
    // adding Pop to the list

    TrackQueryParams output = await testQueryParam.readParams(testUser);
    // ASSERT
    // output should be first list read + string that was added
    // in this case [..., 'Pop']
    expect(output.trackMoodRanges.angerParams.acousticness, [0, 0.6]);
  });
  test('Testing updateParamRanges', () async {
    // ARRANGE
    var testQueryParam = QueryParamsProvider();
    var testUser = User(email: "musicme", displayName: "MyDisplayName");
    TrackData dislikedTrack = TrackData(
        mood: "sadness", trackId: "6q9IP7wbfpocUiOEGvQqCZ", name: "It's fine");

    // reading the current file (this is dependedt on file reading working)
    // this checks to see
    await testQueryParam.updateParamRanges(dislikedTrack, testUser);

    // ACT
    // adding Pop to the list

    TrackQueryParams output = await testQueryParam.readParams(testUser);
    // ASSERT
    // output should be first list read + string that was added
    // in this case [..., 'Pop']
    expect(output.trackMoodRanges.angerParams.acousticness, [0, 0.6]);
  });

  test('Correctly updates query params for joy, energy', () async {
    // ARRANGE
    var testQueryParam = QueryParamsProvider();
    var testUser = User(email: "musicme", displayName: "MyDisplayName");
    TrackData dislikedTrack = TrackData(
        mood: "joy", trackId: "1igtKwX3EHjN95HanbkHNg", name: "Take Care");

    // reading the current file (this is dependant on file reading working)
    // this checks to see
    await testQueryParam.updateParamRanges(dislikedTrack, testUser);

    // ACT

    TrackQueryParams output = await testQueryParam.readParams(testUser);
    // ASSERT
    expect(output.trackMoodRanges.joyParams.energy, [0.5, 1]);
  });

  test('Correctly updates query params for joy, danceability', () async {
    // ARRANGE
    var testQueryParam = QueryParamsProvider();
    var testUser = User(email: "musicme", displayName: "MyDisplayName");
    TrackData dislikedTrack = TrackData(
        mood: "joy", trackId: "1igtKwX3EHjN95HanbkHNg", name: "Take Care");

    // reading the current file (this is dependant on file reading working)
    // this checks to see
    await testQueryParam.updateParamRanges(dislikedTrack, testUser);

    // ACT

    TrackQueryParams output = await testQueryParam.readParams(testUser);
    // ASSERT
    expect(output.trackMoodRanges.joyParams.danceability, [0.6, 1]);
  });

  test('Correctly updates query params for anger, energy', () async {
    // ARRANGE
    var testQueryParam = QueryParamsProvider();
    var testUser = User(email: "musicme", displayName: "MyDisplayName");
    TrackData dislikedTrack = TrackData(
        mood: "anger", trackId: "1igtKwX3EHjN95HanbkHNg", name: "Take Care");

    // reading the current file (this is dependent on file reading working)
    // this checks to see
    await testQueryParam.updateParamRanges(dislikedTrack, testUser);

    // ACT

    TrackQueryParams output = await testQueryParam.readParams(testUser);
    // ASSERT
    expect(output.trackMoodRanges.angerParams.energy, [0.5, 1]);
  });

  test('Correctly updates query params for anger, acousticness', () async {
    // ARRANGE
    var testQueryParam = QueryParamsProvider();
    var testUser = User(email: "musicme", displayName: "MyDisplayName");
    TrackData dislikedTrack = TrackData(
        mood: "anger", trackId: "1igtKwX3EHjN95HanbkHNg", name: "Take Care");

    // reading the current file (this is dependent on file reading working)
    // this checks to see
    await testQueryParam.updateParamRanges(dislikedTrack, testUser);

    // ACT

    TrackQueryParams output = await testQueryParam.readParams(testUser);
    // ASSERT
    expect(output.trackMoodRanges.angerParams.acousticness, [0, 0.5]);
  });

//////////////////////////////////////////////////END TESTING COUNTRIES
}
