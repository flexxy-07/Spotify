class SongEntity {
  final String id;
  final String title;
  final String artist;
  final num duration;
  final String filePath;
  final String? coverPath;

  SongEntity({
    required this.id,
    required this.title,
    required this.artist,
    required this.duration,
    required this.filePath,
    this.coverPath,
  });
}
