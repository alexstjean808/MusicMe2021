import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class GenreEvent extends Equatable {}

class AddGenreEvent extends GenreEvent {
  final String genreInput;

  AddGenreEvent({@required this.genreInput}) : assert(genreInput != null);
  @override
  List<Object> get props => [genreInput];
}

class RemoveGenreEvent extends GenreEvent {
  final String genreInput;

  RemoveGenreEvent({@required this.genreInput}) : assert(genreInput != null);
  @override
  List<Object> get props => [genreInput];
}
