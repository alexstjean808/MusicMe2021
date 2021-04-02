import 'package:equatable/equatable.dart';
import 'package:musicme/features/music_app/data/entities/track_data.dart';

abstract class LikedSongEvent extends Equatable {}

class GetLikedSongsEvent extends LikedSongEvent {
  @override
  List<Object> get props => [];
}

class EditListEvent extends LikedSongEvent {
  @override
  List<Object> get props => [];
}

class RemoveSongEvent extends LikedSongEvent {
  final TrackData song;

  RemoveSongEvent(this.song);
  @override
  List<Object> get props => [song];
}
