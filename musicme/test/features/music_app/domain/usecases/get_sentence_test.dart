import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:musicme/features/music_app/domain/entities/song_data.dart';
import 'package:musicme/features/music_app/domain/repositories/song_data_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:musicme/features/music_app/domain/usecases/get_song_data.dart';

class MockSongDataRepository extends Mock implements SongDataRepository {}

// testing to make sure the sentence is gotten from the user
void main() {
  GetSongData usecase;
  MockSongDataRepository mockSongDataRepository;

  setUp(() {
    mockSongDataRepository = MockSongDataRepository();
    usecase = GetSongData(mockSongDataRepository);
  });

  final tNumber = 1;
  final tSongData = SongData(id: "1234", name: "Magic Mustard");

  test(
    'shoud get SongData for song from the repository',
    () async {
      // arrange
      when(mockSongDataRepository.getSongData(any))
          .thenAnswer((_) async => Right(tSongData));
      // act
      final result = await usecase(Params(number: tNumber));
      // assert
      expect(result, Right(tSongData));
      verify(mockSongDataRepository.getSongData(tNumber));
      verifyNoMoreInteractions(mockSongDataRepository);
    },
  );
}
