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
        trackId: "1psvnQxSDdIKTDM2Jm8QKt",
        mood: "still stoked");
    // ACT
    await likedSongsProvider.addLikedSong(song, 'musicme');

    List<TrackData> songData = await likedSongsProvider.readLikedTracks();
    // ASSERT
    expect(songData[songData.length - 1].trackId, '0hvxqftYCZT406ElE03giM');
  });

  test('Liked song successfully removed from database', () async {
    // ARRANGE
    var likedSongsProvider = LikedSongsProvider();
    TrackData song = TrackData(
        name: "testName1",
        artist: "fong",
        trackId: "4v9rHzCDgQXbDdB7t4Nwcz",
        mood: "less stoked");
    // ACT
    //await likedSongsProvider.addLikedSong(song, 'musicme');
    await likedSongsProvider.removeLikedSong(song, 'musicme');
    List<TrackData> songData = await likedSongsProvider.readLikedTracks();
    // ASSERT
    expect(songData[songData.length - 1].trackId, '1psvnQxSDdIKTDM2Jm8QKt');
  });
}


// in database
//  [{"artist":"Kid Quill","id":"0QXbKnplTUrae3P1P7xdq2","mood":"","name":"Playlist"},{"artist":"Freddie Gibbs","id":"4wmZtoif8SGm7PDqgKrEXr","mood":"","name":"4 Thangs (feat. Big Sean & Hit-Boy)"},{"artist":"Freestyle","id":"6F4Scj944RJCZPgcGuAqym","mood":"","name":"So Slow"}]