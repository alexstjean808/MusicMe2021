import 'package:musicme/features/music_app/data/data_provider/track_data_provider.dart';
import 'package:musicme/features/music_app/data/entities/track_data.dart';

class TrackRepository {
  final TrackDataProvider trackDataProvider;

  TrackRepository(this.trackDataProvider);
  Future<TrackData> getFeelingLuckyTrack() async {
    final TrackData track = await trackDataProvider.getFeelingLuckyTrack();
    return track;
  }

  Future<TrackData> getAllDataThatMeetsRequirements(String sentence) async {
    final TrackData track =
        await trackDataProvider.getTrackFromSentence(sentence);
    return track;
  }

  Future<TrackData> getDataFromLastMood() async {
    final TrackData track = await trackDataProvider.getTrackFromLastMood();
    return track;
  }
}
