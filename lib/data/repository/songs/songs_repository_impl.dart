import 'package:dartz/dartz.dart';
import 'package:spotify/data/sources/songs/songs_local_service.dart';
import 'package:spotify/domain/entities/songs/song.dart';
import 'package:spotify/domain/repository/songs/songs.dart';

class SongsRepositoryImpl extends SongsRepository {
  final SongsLocalService songsLocalService;

  SongsRepositoryImpl({required this.songsLocalService});

  @override
  Future<Either> getSongs() async {
    final result = await songsLocalService.getSongs();
    return result.fold(
      (error) => Left(error),
      (songs) {
        // Convert SongModel to SongEntity
        final songEntities = (songs as List)
            .map((song) => song.toEntity() as SongEntity)
            .toList();
        return Right(songEntities);
      },
    );
  }

  @override
  Future<Either> deleteSong(String filePath) async {
    return await songsLocalService.deleteSong(filePath);
  }

  @override
  Future<Either> searchSongs(String query) async {
    final result = await songsLocalService.searchSongs(query);
    return result.fold(
      (error) => Left(error),
      (songs) {
        final songEntities = (songs as List)
            .map((song) => song.toEntity() as SongEntity)
            .toList();
        return Right(songEntities);
      },
    );
  }
}
