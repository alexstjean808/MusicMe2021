import 'package:flutter_test/flutter_test.dart';
import 'package:musicme/features/music_app/data/data_provider/song_history_provider.dart';
import 'package:musicme/features/music_app/data/entities/track_data.dart';

void main() {
  test('Stores songs history and can read it the last track', () async {
    var songHistoryProvider = SongHistoryProvider();

    // Arrange
    songHistoryProvider.addToHistory(TrackData(mood: "hello"));
    songHistoryProvider.addToHistory(TrackData(mood: "hello2"));
    songHistoryProvider.addToHistory(TrackData(mood: "hello3"));
    // Act
    var test = songHistoryProvider.getLastTrack();
    // Assert
    expect(test.mood, 'hello3');
  });
  test('Stores songs history and can read it the last track', () async {
    var songHistoryProvider = SongHistoryProvider();

    // Arrange
    songHistoryProvider.addToHistory(TrackData(mood: "hello"));
    songHistoryProvider.addToHistory(TrackData(mood: "hello2"));
    songHistoryProvider.addToHistory(TrackData(mood: "hello3"));
    // Act
    songHistoryProvider.getLastTrack();
    var test2 = songHistoryProvider.getLastTrack();
    // Assert
    expect(test2.mood, 'hello2');
  });

  test('Will not throw an error when no song history', () async {
    var songHistoryProvider = SongHistoryProvider();

    // Arrange

    // Act
    var test2 = songHistoryProvider.getLastTrack();
    print(test2.mood);
    // Assert
    expect(test2, null);
  });
}
