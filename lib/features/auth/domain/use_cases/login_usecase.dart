import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:verta/core/errors/failures.dart';
import 'package:verta/features/auth/domain/entities/user_entity.dart';
import 'package:verta/features/auth/domain/repositories/auth_repository.dart';
@injectable
class LoginUseCase {

  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, UserEntity>>
  call({
    required String email,
    required String password,
  }) {

    return repository.login(
      email: email,
      password: password,
    );
  }
}