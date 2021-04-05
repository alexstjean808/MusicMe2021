import 'package:musicme/features/music_app/data/data_provider/track_data_provider.dart';
import 'package:musicme/features/music_app/data/entities/track_data.dart';
import 'package:musicme/features/music_app/data/entities/user.dart';
import 'package:musicme/features/music_app/data/local_data/user_data.dart';

class TrackRepository {
  final TrackDataProvider trackDataProvider;

  TrackRepository(this.trackDataProvider);
  Future<TrackData> getFeelingLuckyTrack(User user) async {
    final TrackData track = await trackDataProvider.getFeelingLuckyTrack();
    return track;
  }

  Future<TrackData> getAllDataThatMeetsRequirements(String sentence) async {
    final TrackData track =
        await trackDataProvider.getTrackFromSentence(sentence, userGLOBAL);
    return track;
  }

  Future<TrackData> getDataFromLastMood(User user) async {
    final TrackData track =
        await trackDataProvider.getTrackFromLastMood(userGLOBAL);
    return track;
  }
}
