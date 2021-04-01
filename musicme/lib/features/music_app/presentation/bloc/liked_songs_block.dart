import 'package:bloc/bloc.dart';
import 'package:musicme/features/music_app/data/data_provider/liked_songs_provider.dart';
import 'package:musicme/features/music_app/data/entities/track_data.dart';
import 'package:musicme/features/music_app/presentation/bloc/liked_songs_event.dart';
import './liked_songs_state.dart';
import 'genre_event.dart';

class LikedSongsBloc extends Bloc<LikedSongEvent, LikedSongsState> {
  final LikedSongsProvider likedSongsProvider;
  bool canEdit = false;

  LikedSongsBloc(LikedSongsState initialState, this.likedSongsProvider)
      : super(initialState);
  @override
  Stream<LikedSongsState> mapEventToState(LikedSongEvent event) async* {
    if (event is GetLikedSongsEvent) {
      List<TrackData> likedSongs;
      try {
        likedSongs = await likedSongsProvider.readLikedTracks();
      } catch (e) {
        print("LikedSongsBlock: $e");
      }
      var state = NoEditState(canEdit: false, likedSongs: likedSongs);
      yield state;
    } else if (event is EditListEvent) {
      List<TrackData> likedSongs;
      try {
        likedSongs = await likedSongsProvider.readLikedTracks();
      } catch (e) {
        print("LikedSongsBlock: $e");
      }
      this.canEdit = !canEdit;
      var state = EditState(canEdit: canEdit, likedSongs: likedSongs);
      print(canEdit);
      yield state;
    } else if (event is RemoveSongEvent) {
      await likedSongsProvider.removeLikedSong(event.song, 'musicme');
      var likedSongs = await likedSongsProvider.readLikedTracks();
      var state = NoEditState(canEdit: canEdit, likedSongs: likedSongs);
      yield state;
    }
  }
}
