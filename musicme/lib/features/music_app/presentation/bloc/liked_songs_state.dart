import 'package:equatable/equatable.dart';
import 'package:musicme/features/music_app/data/entities/track_data.dart';

class LikedSongsState extends Equatable {
  final bool canEdit;
  final List<TrackData> likedSongs;

  LikedSongsState(this.canEdit, this.likedSongs);
  @override
  List<Object> get props => [];
}

class EditState extends LikedSongsState {
  final bool canEdit;
  final List<TrackData> likedSongs;

  EditState({this.canEdit, this.likedSongs}) : super(false, null);
  @override
  List<Object> get props => [canEdit, likedSongs];
}

class NoEditState extends LikedSongsState {
  final bool canEdit;
  final List<TrackData> likedSongs;

  NoEditState({this.canEdit, this.likedSongs}) : super(false, null);

  @override
  List<Object> get props => [canEdit, likedSongs];
}
