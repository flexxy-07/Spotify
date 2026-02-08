import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/data/models/auth/create_user_req.dart';
import 'package:spotify/data/models/auth/signin_user_req.dart';

abstract class AuthFirebaseService {
  Future<Either> signUp(CreateUserReq createUserReq);
  Future<Either> signIn(SignInUserReq signInUserReq);
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  @override
  Future<Either> signIn(SignInUserReq signInUserReq) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: signInUserReq.email,
            password: signInUserReq.password,
          );

      // Update display name if user exists
      if (userCredential.user != null) {
        await userCredential.user!.updateDisplayName(signInUserReq.email);
        await userCredential.user!.reload();
      }

      return const Right('Signed in successfully');
    } on FirebaseAuthException catch (e) {
      String mssg = '';
      if (e.code == 'user-not-found') {
        mssg = 'No user found for that email';
      } else if (e.code == 'wrong-password') {
        mssg = 'Wrong password provided for that user';
      } else if (e.code == 'invalid-email') {
        mssg = 'The email address is not valid';
      } else if (e.code == 'invalid-credential') {
        mssg =
            'Wrong password provided for that user or the email is not valid';
      } else if (e.code == 'operation-not-allowed') {
        mssg = 'Email/password accounts are not enabled';
      } else {
        mssg = e.message ?? 'An error occurred during signup';
      }
      return Left(mssg);
    } on TypeError catch (e) {
      // Handle specific type casting errors from Firebase
      return Left(
        'Firebase configuration error. Please try again or contact support.',
      );
    } catch (e) {
      return Left('An unexpected error occurred: ${e.toString()}');
    }
  }

  @override
  Future<Either> signUp(CreateUserReq createUserReq) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: createUserReq.email,
            password: createUserReq.password,
          );

      // Update display name if user exists
      if (userCredential.user != null) {
        await userCredential.user!.updateDisplayName(createUserReq.fullName);
        await userCredential.user!.reload();
      }

      return const Right('User created successfully');
    } on FirebaseAuthException catch (e) {
      String mssg = '';
      if (e.code == 'weak-password') {
        mssg = 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        mssg = 'An account already exists with the provided email';
      } else if (e.code == 'invalid-email') {
        mssg = 'The email address is not valid';
      } else if (e.code == 'operation-not-allowed') {
        mssg = 'Email/password accounts are not enabled';
      } else {
        mssg = e.message ?? 'An error occurred during signup';
      }
      return Left(mssg);
    } on TypeError catch (e) {
      // Handle specific type casting errors from Firebase
      return Left(
        'Firebase configuration error. Please try again or contact support.',
      );
    } catch (e) {
      return Left('An unexpected error occurred: ${e.toString()}');
    }
  }
}
