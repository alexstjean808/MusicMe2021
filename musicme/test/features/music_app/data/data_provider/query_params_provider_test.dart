import 'package:flutter_test/flutter_test.dart';
import 'package:musicme/features/music_app/data/data_provider/query_params_provider.dart';
import 'package:musicme/features/music_app/data/entities/track_query_params.dart';

void main() {
  // IMPORTANT: for testing these files make sure track_query_params.json has "genres": ["Rock", "Jazz", "Pop"]
// or the test wont pass.
  test('getQueryParams correctly returns TrackQueryParams', () async {
    // ARRANGE
    var queryParamProvider = QueryParamsProvider();
    // ACT
    var trackQueryParams = await queryParamProvider.readParams("musicme");

    // ASSERT
    expect(trackQueryParams.runtimeType, TrackQueryParams);
  });
  test('we correctly read Danceability', () async {
    // ARRANGE
    var queryParamProvider = QueryParamsProvider();
    // ACT
    TrackQueryParams trackQueryParams =
        await queryParamProvider.readParams("musicme");

    // ASSERT

    expect(trackQueryParams.trackMoodRanges.sadnessParams.danceability,
        [0.0, 0.4]);
  });
  test('Correctly read the genres', () async {
    // ARRANGE
    TrackQueryParams trackQueryParams =
        await QueryParamsProvider().readParams("musicme");
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
    var current = await testQueryParam.readParams("musicme");
    current.genres.add('Pop');

    var expected = current.genres;
    // ACT
    // adding Pop to the list
    await testQueryParam.addUserGenres('Pop');
    var output = await testQueryParam.readParams("musicme");
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
    var current = await testQueryParam.readParams("musicme");
    var expected = current.genres;
    // ACT
    // adding Pop to the list
    await testQueryParam.addUserGenres('Pop');
    var output = await testQueryParam.readParams("musicme");
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
    var current = await testQueryParam.readParams("musicme");
    current.genres.remove('Pop');
    current.genres.remove('Rock');
    current.genres.remove('Hip-Hop Rap');
    current.genres.remove('Jazz');

    var expected = current.genres;
    // ACT
    // adding Pop to the list
    await testQueryParam.removeUserGenres('Pop');
    await testQueryParam.removeUserGenres('Rock');
    await testQueryParam.removeUserGenres('Hip-Hop Rap');
    await testQueryParam.removeUserGenres('Jazz');
    var output = await testQueryParam.readParams("musicme");
    // ASSERT
    // output should be first list read + string that was added
    // in this case [..., 'Pop']
    expect(output.genres, expected);
  });
}
