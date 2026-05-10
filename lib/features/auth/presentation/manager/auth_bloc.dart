import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:verta/features/auth/domain/use_cases/login_usecase.dart';
import 'package:verta/features/auth/domain/use_cases/register_usecase.dart';

part 'auth_event.dart';

part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;

  AuthBloc(this.loginUseCase, this.registerUseCase) : super(AuthInitial()) {
    on<LoginEvent>(_login);
    on<RegisterEvent>(_register);
  }

  Future<void> _login(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await loginUseCase(
      email: event.email,
      password: event.password,
    );

    result.fold(
      (failure) {
        emit(AuthError(failure.message));
      },

      (user) {
        emit(AuthSuccess());
      },
    );
  }

  Future<void> _register(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await registerUseCase(
      username: event.username,
      email: event.email,
      password: event.password,
    );

    result.fold(
      (failure) {
        emit(AuthError(failure.message));
      },

      (user) {
        emit(AuthSuccess());
      },
    );
  }
}
