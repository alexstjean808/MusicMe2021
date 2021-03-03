import 'package:musicme/features/music_app/data/data_provider/track_data_provider.dart';
import 'package:musicme/features/music_app/data/entities/track.dart';

class TrackRepository {
  final TrackDataProvider trackDataProvider;

  TrackRepository(this.trackDataProvider);

  Future<Track> getAllDataThatMeetsRequirements(String sentence) async {
    final Track track = await trackDataProvider.readData(sentence);
    return track;
  }
}
