import 'package:firebase_auth/firebase_auth.dart' as firebase_auth; // Alias Firebase User
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final firebase_auth.FirebaseAuth _firebaseAuth;

  AuthRemoteDataSourceImpl(this._firebaseAuth);

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final firebase_auth.User? user = userCredential.user; // Explicitly type as firebase_auth.User
      if (user == null) {
        throw Exception('User not found after login');
      }
      return UserModel.fromFirebaseUser(user); // Use the factory method
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }
}