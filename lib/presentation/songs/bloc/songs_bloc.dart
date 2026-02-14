import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/domain/entities/songs/song.dart';
import 'package:spotify/domain/usecases/songs/get_songs.dart';
import 'package:spotify/domain/usecases/songs/search_songs.dart';
import 'package:spotify/service_locator.dart';

// Events
abstract class SongsEvent {}

class FetchSongsEvent extends SongsEvent {}

class SearchSongsEvent extends SongsEvent {
  final String query;
  SearchSongsEvent(this.query);
}

// States
abstract class SongsState {}

class SongsInitial extends SongsState {}

class SongsLoading extends SongsState {}

class SongsLoaded extends SongsState {
  final List<SongEntity> songs;
  SongsLoaded(this.songs);
}

class SongsError extends SongsState {
  final String message;
  SongsError(this.message);
}

// BLoC
class SongsBloc extends Bloc<SongsEvent, SongsState> {
  final GetSongsUseCase _getSongsUseCase = sl<GetSongsUseCase>();
  final SearchSongsUseCase _searchSongsUseCase = sl<SearchSongsUseCase>();

  SongsBloc() : super(SongsInitial()) {
    on<FetchSongsEvent>(_onFetchSongs);
    on<SearchSongsEvent>(_onSearchSongs);
  }

  Future<void> _onFetchSongs(
    FetchSongsEvent event,
    Emitter<SongsState> emit,
  ) async {
    emit(SongsLoading());
    final result = await _getSongsUseCase.call();

    result.fold(
      (error) => emit(SongsError(error.toString())),
      (songs) => emit(SongsLoaded(songs as List<SongEntity>)),
    );
  }

  Future<void> _onSearchSongs(
    SearchSongsEvent event,
    Emitter<SongsState> emit,
  ) async {
    emit(SongsLoading());
    final result = await _searchSongsUseCase.call(params: event.query);

    result.fold(
      (error) => emit(SongsError(error.toString())),
      (songs) => emit(SongsLoaded(songs as List<SongEntity>)),
    );
  }
}
