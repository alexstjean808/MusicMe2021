import 'package:dartz/dartz.dart';
import 'package:musicme/features/music_app/core/errors/failures..dart';
import 'package:musicme/features/music_app/domain/entities/song_data.dart';

abstract class SongDataRepository {
  // this methos will get the song data from the server
  Future<Either<Failure, SongData>> getSongData(var number);

  // in this repo we will also need to declare methods to send user feedback from skipping songs and such.
}
