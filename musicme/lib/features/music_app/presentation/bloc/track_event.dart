import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:musicme/features/music_app/data/entities/track_data.dart';

abstract class TrackEvent extends Equatable {}

class GetTrackEvent extends TrackEvent {
  final String sentence;

  GetTrackEvent({@required this.sentence}) : assert(sentence != null);

  @override
  List<Object> get props => [sentence];
}

class SkipTrackEvent extends TrackEvent {
  @override
  List<Object> get props => [];
}

class SkipPreviousEvent extends TrackEvent {
  @override
  List<Object> get props => [];
}

class FeelingLuckyEvent extends TrackEvent {
  @override
  List<Object> get props => [];
}

class LikeEvent extends TrackEvent {
  @override
  List<Object> get props => [];
}

class DislikeEvent extends TrackEvent {
  @override
  List<Object> get props => [];
}

class PlayLikedSongEvent extends TrackEvent {
  final TrackData song;

  PlayLikedSongEvent(this.song);
  @override
  List<Object> get props => [];
}
