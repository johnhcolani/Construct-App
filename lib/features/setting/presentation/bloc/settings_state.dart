import '../../domain/entities/user_profile.dart';

abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final UserProfile userProfile;

  SettingsLoaded(this.userProfile);
}

class SettingsError extends SettingsState {
  final String message;

  SettingsError(this.message);
}

class SignOutSuccess extends SettingsState {}