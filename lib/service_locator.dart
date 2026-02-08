import 'package:get_it/get_it.dart';
import 'package:spotify/data/repository/auth/auth_repository_implementation.dart';
import 'package:spotify/data/sources/auth/auth_firebase_service.dart';
import 'package:spotify/domain/repository/auth/auth.dart';
import 'package:spotify/domain/usecases/auth/signin.dart';
import 'package:spotify/domain/usecases/auth/signup.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Register services first
  sl.registerSingleton<AuthFirebaseService>(
    AuthFirebaseServiceImpl()
  );

  // Register repositories with their dependencies
  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImplementation(
      authFirebaseService: sl<AuthFirebaseService>()
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
}
