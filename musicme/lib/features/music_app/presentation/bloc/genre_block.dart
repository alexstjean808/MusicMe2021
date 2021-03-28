import 'package:bloc/bloc.dart';
import 'package:musicme/features/music_app/data/data_provider/query_params_provider.dart';

import 'genre_event.dart';

class GenreBloc extends Bloc<GenreEvent, List> {
  final QueryParamsProvider genreProvider;

  GenreBloc(List initialState, this.genreProvider) : super(initialState);
  @override
  Stream<List> mapEventToState(GenreEvent event) async* {
    if (event is AddGenreEvent) {
      var params;
      try {
        await genreProvider.addUserGenres(event.genreInput);
      } catch (e) {
        print("we could not write to the file");
      }
      try {
        params = await genreProvider.readParams('musicme');
      } catch (e) {
        print("we could not read to the file");
      }

      yield params.genres;
    } else if (event is RemoveGenreEvent) {
      await genreProvider.removeUserGenres(event.genreInput);
      var params = await genreProvider.readParams('musicme');
      yield params.genres;
    } else if (event is LoadGenreEvent) {
      var params = await genreProvider.readParams('musicme');
      yield params.genres;
    }
  }
}
