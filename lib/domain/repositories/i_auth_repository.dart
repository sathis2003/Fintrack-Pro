import 'package:fpdart/fpdart.dart';
import '../../core/errors/failures.dart';

abstract class IAuthRepository {
  Future<Either<Failure, Unit>> signUp({
    required String email,
    required String password,
    required String name,
  });

  Future<Either<Failure, Unit>> signIn({
    required String email,
    required String password,
  });

  Future<Either<Failure, Unit>> signInWithGoogle();

  Future<Either<Failure, Unit>> signInWithApple();

  Future<Either<Failure, Unit>> signOut();

  Future<Either<Failure, Unit>> resetPassword(String email);

  Stream<String?> get authStateChanges;

  String? get currentUserId;
  String? get currentUserEmail;
}
