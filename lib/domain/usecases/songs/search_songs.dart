import 'package:dartz/dartz.dart';
import 'package:spotify/domain/repository/songs/songs.dart';
import 'package:spotify/core/usecase/usecase.dart';

class SearchSongsUseCase extends UseCase<Either, String> {
  final SongsRepository songsRepository;

  SearchSongsUseCase({required this.songsRepository});

  @override
  Future<Either> call({String params = ''}) async {
    return await songsRepository.searchSongs(params);
  }
}
