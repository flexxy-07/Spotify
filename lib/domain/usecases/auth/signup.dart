import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/data/models/auth/create_user_req.dart';
import 'package:spotify/domain/repository/auth/auth.dart';
import 'package:spotify/service_locator.dart';

class SignupUseCase implements UseCase<Either,CreateUserReq> {
  final AuthRepository _authRepository;

  SignupUseCase({AuthRepository? authRepository}) 
    : _authRepository = authRepository ?? sl<AuthRepository>();

  @override
  Future<Either<dynamic, dynamic>> call({CreateUserReq ?params}) {
    return _authRepository.signUp(params!);
  }

}