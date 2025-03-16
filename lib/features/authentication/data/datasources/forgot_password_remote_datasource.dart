import 'package:firebase_auth/firebase_auth.dart';

abstract class ForgotPasswordRemoteDataSource {
  Future<void> resetPassword(String email);
}

class ForgotPasswordRemoteDataSourceImpl implements ForgotPasswordRemoteDataSource {
  final FirebaseAuth _firebaseAuth;

  ForgotPasswordRemoteDataSourceImpl(this._firebaseAuth);

  @override
  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}