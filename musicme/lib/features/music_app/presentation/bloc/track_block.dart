import 'package:bloc/bloc.dart';
import 'package:musicme/features/music_app/data/entities/track.dart';
import 'package:musicme/features/music_app/data/repository/track_repository.dart';
import 'package:musicme/features/music_app/presentation/bloc/track_event.dart';

class TrackBloc extends Bloc<GetTrackEvent, Track> {
  final TrackRepository repository;

  TrackBloc(Track initialState, this.repository) : super(initialState);
  @override
  Stream<Track> mapEventToState(GetTrackEvent event) async* {
    if (true) {
      try {
        final Track track =
            await repository.getAllDataThatMeetsRequirements(event.sentence);
        yield track;
      } catch (error) {
        yield Track(trackId: '7GhIk7Il098yCjg4BQjzvb');
        // play a really funky song on failure.
      }
    }
  }
}
