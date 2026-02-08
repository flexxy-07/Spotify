import 'package:dartz/dartz.dart';
import 'package:spotify/data/models/auth/create_user_req.dart';
import 'package:spotify/data/models/auth/signin_user_req.dart';
import 'package:spotify/data/sources/auth/auth_firebase_service.dart';
import 'package:spotify/domain/repository/auth/auth.dart';
import 'package:spotify/service_locator.dart';

class AuthRepositoryImplementation extends AuthRepository{
  final AuthFirebaseService _authFirebaseService;

  AuthRepositoryImplementation({AuthFirebaseService? authFirebaseService})
    : _authFirebaseService = authFirebaseService ?? sl<AuthFirebaseService>();

  @override
  Future<Either> signIn(SignInUserReq signInUserReq) async {
    return await _authFirebaseService.signIn(signInUserReq);
  }

  @override
  Future<Either> signUp(CreateUserReq createUserReq) async {
    return await _authFirebaseService.signUp(createUserReq);
  }

}