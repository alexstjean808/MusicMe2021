import 'package:flutter_test/flutter_test.dart';
import 'package:musicme/features/music_app/data/data_provider/query_params_provider.dart';
import 'package:musicme/features/music_app/data/entities/track_query_params.dart';

void main() {
  test('getQueryParams correctly returns TrackQueryParams', () async {
    // ARRANGE
    var queryParamProvider = QueryParamsProvider();
    // ACT
    var trackQueryParams = await queryParamProvider.readParams();

    // ASSERT
    expect(trackQueryParams.runtimeType, TrackQueryParams);
  });
  test('we correctly read Danceability', () async {
    // ARRANGE
    var queryParamProvider = QueryParamsProvider();
    // ACT
    TrackQueryParams trackQueryParams = await queryParamProvider.readParams();

    // ASSERT

    expect(trackQueryParams.trackMoodRanges.sadnessParams.danceability,
        [0.0, 0.4]);
  });
  test('Correctly read the genres', () async {
    // ARRANGE
    TrackQueryParams trackQueryParams =
        await QueryParamsProvider().readParams();
    var genres = trackQueryParams.genres;
    // ACT

    // ASSERT
    expect(genres, ['Hip-Hop / Rap']);
  });
  // These tests below are to demonstrate how flutter testing works.
  test('when testMethod is called then it return 1', () async {
    // ARRANGE
    var testQueryParam = QueryParamsProvider();
    // ACT
    var output = testQueryParam.testMethod();
    // ASSERT
    expect(output, 1);
  });
}
