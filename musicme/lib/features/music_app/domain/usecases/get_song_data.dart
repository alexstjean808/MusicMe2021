import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:musicme/features/music_app/core/errors/failures..dart';
import 'package:musicme/features/music_app/core/usecases/usecase.dart';
import 'package:musicme/features/music_app/domain/entities/song_data.dart';
import 'package:musicme/features/music_app/domain/repositories/song_data_repository.dart';
import 'package:meta/meta.dart';

// the usecase declaration class for getting a song name and song Id from a json file
class GetSongData implements UseCase<SongData, Params> {
  final SongDataRepository songDataRepository;
  GetSongData(this.songDataRepository);

  @override
  Future<Either<Failure, SongData>> call(Params params) async {
    return await songDataRepository.getSongData(params.number);
  }
}

// hold all paramters for the call method get_song_data.

class Params extends Equatable {
  final int number;

  Params({this.number});

  @override
  List get props => [number];
}
