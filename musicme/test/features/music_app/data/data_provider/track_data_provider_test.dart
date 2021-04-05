import 'package:flutter_test/flutter_test.dart';
import 'package:musicme/features/music_app/data/data_provider/track_data_provider.dart';
import 'package:musicme/features/music_app/data/entities/track_data.dart';
import 'package:musicme/features/music_app/data/local_data/user_data.dart';

void main() {
  test('track data provider ...', () async {
    var trackDataProvider = TrackDataProvider();

    // ARRANGE
    var trackId = await trackDataProvider.getTrackFromSentence(
        "sad sad sad sad sad sad sad sad sad sad", userGLOBAL);
    // ACT
    print(
        "${trackId.name} + ${trackId.trackId} + ${trackId.artist} + ${trackId.mood}");
    //trackID name and artist are not printing
    //ASSERT
    expect(trackId.runtimeType, TrackData);
  });
}
