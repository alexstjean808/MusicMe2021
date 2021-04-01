import 'package:flutter_test/flutter_test.dart';
import 'package:musicme/features/music_app/data/data_provider/liked_songs_provider.dart';
import 'package:musicme/features/music_app/data/entities/track_data.dart';

void main() {
  test('Liked songs successfully deserialized into TrackData objects',
      () async {
    // ARRANGE
    var likedSongsProvider = LikedSongsProvider();
    // ACT
    List<TrackData> songData = await likedSongsProvider.readLikedTracks();
    // ASSERT
    expect([songData[0].mood, songData[1].mood], ['fuckin', 'stoked']);
  });
  test('Liked songs successfully added to database', () async {
    // ARRANGE
    var likedSongsProvider = LikedSongsProvider();
    TrackData song = TrackData(
        name: "billy",
        artist: "tom",
        trackId: "moreInfo5",
        mood: "still stoked");
    // ACT
    await likedSongsProvider.addLikedSong(song, 'musicme');

    List<TrackData> songData = await likedSongsProvider.readLikedTracks();
    // ASSERT
    expect(songData[songData.length - 1].artist, 'tom');
  });

  test('Liked song successfully removed from database', () async {
    // ARRANGE
    var likedSongsProvider = LikedSongsProvider();
    TrackData song = TrackData(
        name: "testName1",
        artist: "fong",
        trackId: "testId1",
        mood: "less stoked");
    // ACT
    //await likedSongsProvider.addLikedSong(song, 'musicme');
    await likedSongsProvider.removeLikedSong(song, 'musicme');
    List<TrackData> songData = await likedSongsProvider.readLikedTracks();
    // ASSERT
    expect(songData[songData.length - 1].artist, 'adam');
  });
}
