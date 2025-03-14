import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/login_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;

  AuthBloc(this.loginUseCase) : super(AuthInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(AuthLoading());
      final result = await loginUseCase(
        LoginParams(email: event.email, password: event.password),
      );
      result.fold(
            (failure) => emit(AuthFailure(failure.message)),
            (user) => emit(AuthSuccess(user)),
      );
    });
  }
}