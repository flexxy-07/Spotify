import 'package:get_it/get_it.dart';
import 'package:spotify/data/repository/auth/auth_repository_implementation.dart';
import 'package:spotify/data/repository/songs/songs_repository_impl.dart';
import 'package:spotify/data/sources/auth/auth_firebase_service.dart';
import 'package:spotify/data/sources/songs/songs_local_service.dart';
import 'package:spotify/domain/repository/auth/auth.dart';
import 'package:spotify/domain/repository/songs/songs.dart';
import 'package:spotify/domain/usecases/auth/signin.dart';
import 'package:spotify/domain/usecases/auth/signup.dart';
import 'package:spotify/domain/usecases/songs/get_songs.dart';
import 'package:spotify/domain/usecases/songs/search_songs.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Register services first
  sl.registerSingleton<AuthFirebaseService>(
    AuthFirebaseServiceImpl()
  );

  // Register songs local service
  sl.registerSingleton<SongsLocalService>(
    SongsLocalServiceImpl()
  );

  // Register repositories with their dependencies
  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImplementation(
      authFirebaseService: sl<AuthFirebaseService>()
    )
  );

  // Register songs repository
  sl.registerSingleton<SongsRepository>(
    SongsRepositoryImpl(
      songsLocalService: sl<SongsLocalService>()
    )
  );

  // Register use cases with their dependencies
  sl.registerSingleton<SignupUseCase>(
    SignupUseCase(
      authRepository: sl<AuthRepository>()
    )
  );

  sl.registerSingleton<SigninUseCase>(
    SigninUseCase(
      authRepository: sl<AuthRepository>()
    )
  );

  // Register songs use cases
  sl.registerSingleton<GetSongsUseCase>(
    GetSongsUseCase(
      songsRepository: sl<SongsRepository>()
    )
  );

  sl.registerSingleton<SearchSongsUseCase>(
    SearchSongsUseCase(
      songsRepository: sl<SongsRepository>()
    )
  );
}
