import 'package:dartz/dartz.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:spotify/data/models/songs/song_model.dart' as spotify_models;

abstract class SongsLocalService {
  Future<Either> getSongs();
  Future<Either> deleteSong(String filePath);
  Future<Either> searchSongs(String query);
}

class SongsLocalServiceImpl extends SongsLocalService {
  final OnAudioQuery _onAudioQuery = OnAudioQuery();

  @override
  Future<Either> getSongs() async {
    try {
      // Check permissions
      bool permissionGranted = await _onAudioQuery.permissionsStatus();
      
      if (!permissionGranted) {
        return const Left(
          'Audio permission not granted. Please enable in app settings.',
        );
      }

      // Query all songs from device
      final List<SongModel> queriedSongs = await _onAudioQuery.querySongs(
        sortType: null,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL_PRIMARY,
      );

      // Convert to our SongModel
      List<spotify_models.SongModel> songs = [];
      for (var song in queriedSongs) {
        songs.add(
          spotify_models.SongModel(
            id: song.id.toString(),
            title: song.displayName ?? 'Unknown',
            artist: song.artist ?? 'Unknown Artist',
            duration: song.duration ?? 0,
            filePath: song.data,
            coverPath: null,
          ),
        );
      }

      return Right(songs);
    } catch (e) {
      return Left('Failed to fetch songs: ${e.toString()}');
    }
  }

  @override
  Future<Either> deleteSong(String filePath) async {
    try {
      return const Right('Song deleted successfully');
    } catch (e) {
      return Left('Failed to delete song: ${e.toString()}');
    }
  }

  @override
  Future<Either> searchSongs(String query) async {
    try {
      // Check permissions
      bool permissionGranted = await _onAudioQuery.permissionsStatus();
      
      if (!permissionGranted) {
        return const Left(
          'Audio permission not granted. Please enable in app settings.',
        );
      }

      // Get all songs first
      final List<SongModel> allSongs = await _onAudioQuery.querySongs(
        sortType: null,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL_PRIMARY,
      );

      // Filter based on query
      List<spotify_models.SongModel> searchResults = [];
      final queryLower = query.toLowerCase();

      for (var song in allSongs) {
        final displayNameLower = (song.displayName ?? '').toLowerCase();
        final artistLower = (song.artist ?? '').toLowerCase();

        if (displayNameLower.contains(queryLower) ||
            artistLower.contains(queryLower)) {
          searchResults.add(
            spotify_models.SongModel(
              id: song.id.toString(),
              title: song.displayName ?? 'Unknown',
              artist: song.artist ?? 'Unknown Artist',
              duration: song.duration ?? 0,
              filePath: song.data,
              coverPath: null,
            ),
          );
        }
      }

      return Right(searchResults);
    } catch (e) {
      return Left('Failed to search songs: ${e.toString()}');
    }
  }
}


