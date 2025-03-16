import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_profile.dart';
import '../repositories/settings_repository.dart';

class FetchUserProfile {
  final SettingsRepository repository;

  FetchUserProfile(this.repository);

  Future<Either<Failure, UserProfile>> call() async {
    return await repository.fetchUserProfile();
  }
}