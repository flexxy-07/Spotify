import 'package:dartz/dartz.dart';
import 'package:spotify/domain/repository/songs/songs.dart';
import 'package:spotify/core/usecase/usecase.dart';

class GetSongsUseCase extends UseCase<Either, void> {
  final SongsRepository songsRepository;

  GetSongsUseCase({required this.songsRepository});

  @override
  Future<Either> call({void params}) async {
    return await songsRepository.getSongs();
  }
}
