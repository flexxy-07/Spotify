import 'package:dartz/dartz.dart';

abstract class SongsRepository {
  Future<Either> getSongs();
  Future<Either> deleteSong(String filePath);
  Future<Either> searchSongs(String query);
}
