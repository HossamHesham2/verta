import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:verta/core/errors/exceptions.dart';
import 'package:verta/core/errors/failures.dart';
import 'package:verta/features/auth/data/data_sources/auth_remote.dart';
import 'package:verta/features/auth/domain/entities/user_entity.dart';
import 'package:verta/features/auth/domain/repositories/auth_repository.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl(this.authRemoteDataSource);

  // --------------------Login Method--------------------
  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final result = await authRemoteDataSource.login(
        email: email,
        password: password,
      );

      return Right(result);
    } on RemoteException catch (e) {
      return Left(FirebaseFailure(e.message));
    }
  }

  // --------------------Register Method--------------------

  @override
  Future<Either<Failure, UserEntity>> register({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final result = await authRemoteDataSource.register(
        username: username,
        email: email,
        password: password,
      );
      return Right(result);
    } on RemoteException catch (e) {
      return Left(FirebaseFailure(e.message));
    }
  }
}
