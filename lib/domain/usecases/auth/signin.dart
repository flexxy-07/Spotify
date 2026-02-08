import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/data/models/auth/create_user_req.dart';
import 'package:spotify/data/models/auth/signin_user_req.dart';
import 'package:spotify/domain/repository/auth/auth.dart';
import 'package:spotify/service_locator.dart';

class SigninUseCase implements UseCase<Either,SignInUserReq> {
  final AuthRepository _authRepository;

  SigninUseCase({AuthRepository? authRepository}) 
    : _authRepository = authRepository ?? sl<AuthRepository>();

  @override
  Future<Either<dynamic, dynamic>> call({SignInUserReq ?params}) {
    return _authRepository.signIn(params!);
  }

}