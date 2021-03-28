import 'package:flutter_test/flutter_test.dart';
import 'package:musicme/features/music_app/data/data_provider/track_data_provider.dart';
import 'package:musicme/features/music_app/data/entities/track_data.dart';

void main() {
  test('track data provider ...', () async {
    var trackDataProvider = TrackDataProvider();

    // ARRANGE
    var trackId = await trackDataProvider
        .getTrackFromSentence("happy happy happy happy happy");
    // ACT
    print("${trackId.name} + ${trackId.trackId} + ${trackId.artist}");
    //ASSERT
    expect(trackId.runtimeType, TrackData);
  });
}
