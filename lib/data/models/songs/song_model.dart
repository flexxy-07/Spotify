import 'package:spotify/domain/entities/songs/song.dart';

class SongModel {
  final String id;
  final String title;
  final String artist;
  final num duration;
  final String filePath;
  final String? coverPath;

  SongModel({
    required this.id,
    required this.title,
    required this.artist,
    required this.duration,
    required this.filePath,
    this.coverPath,
  });

  /// Convert SongModel to SongEntity
  SongEntity toEntity() {
    return SongEntity(
      id: id,
      title: title,
      artist: artist,
      duration: duration,
      filePath: filePath,
      coverPath: coverPath,
    );
  }

  /// Create SongModel from SongEntity
  factory SongModel.fromEntity(SongEntity entity) {
    return SongModel(
      id: entity.id,
      title: entity.title,
      artist: entity.artist,
      duration: entity.duration,
      filePath: entity.filePath,
      coverPath: entity.coverPath,
    );
  }
}
