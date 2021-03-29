import 'package:flutter_test/flutter_test.dart';
import 'package:musicme/features/music_app/data/data_provider/liked_songs_provider.dart';
import 'package:musicme/features/music_app/data/entities/track_data.dart';

void main() {
  test('liked songs provider ...', () async {
    // ARRANGE
    var test = LikedSongsProvider();
    // ACT
    var actual = await test.removeData(TrackData(trackId: "hello"));
    // ASSERT
    expect(actual, "salmon");
  });
}
