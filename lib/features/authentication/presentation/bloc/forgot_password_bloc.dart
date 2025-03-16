import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/reset_password.dart';
import 'forgot_password_event.dart';
import 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final ResetPassword resetPassword;

  ForgotPasswordBloc(this.resetPassword) : super(ForgotPasswordInitial()) {
    on<ResetPasswordRequested>(_onResetPasswordRequested);
  }

  Future<void> _onResetPasswordRequested(ResetPasswordRequested event, Emitter<ForgotPasswordState> emit) async {
    emit(ForgotPasswordLoading());
    final result = await resetPassword(event.email);
    result.fold(
          (failure) => emit(ForgotPasswordFailure(failure.message)),
          (_) => emit(ForgotPasswordSuccess()),
    );
  }
}