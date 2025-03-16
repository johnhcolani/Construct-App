import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_profile.dart';

abstract class SettingsRepository {
  Future<Either<Failure, UserProfile>> fetchUserProfile();
  Future<Either<Failure, void>> signOut();
}