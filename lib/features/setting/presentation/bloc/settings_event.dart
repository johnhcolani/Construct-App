import 'package:equatable/equatable.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class FetchUserProfileRequested extends SettingsEvent {}

class SignOutRequested extends SettingsEvent {}