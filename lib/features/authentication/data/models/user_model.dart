import 'package:firebase_auth/firebase_auth.dart' as firebase_auth; // Alias Firebase User
import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({required super.uid, required super.email});

  factory UserModel.fromFirebaseUser(firebase_auth.User firebaseUser) {
    return UserModel(
      uid: firebaseUser.uid, // Now correctly references firebase_auth.User.uid
      email: firebaseUser.email ?? '',
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? json['id'], // Handle both 'uid' and 'id' for flexibility
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
    };
  }
}