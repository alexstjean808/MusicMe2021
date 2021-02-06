import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class SongData extends Equatable {
  final String id;
  final String name;

  SongData({
    @required this.id,
    @required this.name,
  });

  @override
  List<Object> get props => [id, name];
}
