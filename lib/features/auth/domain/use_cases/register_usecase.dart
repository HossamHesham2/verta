import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:verta/core/errors/failures.dart';
import 'package:verta/features/auth/domain/entities/user_entity.dart';
import 'package:verta/features/auth/domain/repositories/auth_repository.dart';

@injectable
class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call({
    required String username,
    required String email,
    required String password,
  }) {
    return repository.register(
      username: username,
      email: email,
      password: password,
    );
  }
}
