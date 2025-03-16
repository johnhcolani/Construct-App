import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_profile_model.dart';

abstract class SettingsRemoteDataSource {
  Future<UserProfileModel> fetchUserProfile();
  Future<void> signOut();
}

class SettingsRemoteDataSourceImpl implements SettingsRemoteDataSource {
  final FirebaseAuth _firebaseAuth;

  SettingsRemoteDataSourceImpl(this._firebaseAuth);

  @override
  Future<UserProfileModel> fetchUserProfile() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      throw Exception('No user is currently signed in');
    }
    return UserProfileModel(
      name: user.displayName ?? 'User',
      email: user.email ?? '',
    );
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}