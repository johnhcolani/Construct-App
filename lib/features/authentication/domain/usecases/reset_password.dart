import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/forgot_password_repository.dart';

class ResetPassword {
  final ForgotPasswordRepository repository;

  ResetPassword(this.repository);

  Future<Either<Failure, void>> call(String email) async {
    return await repository.resetPassword(email);
  }
}
