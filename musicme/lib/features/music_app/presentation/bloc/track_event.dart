import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

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
