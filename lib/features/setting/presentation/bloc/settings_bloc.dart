import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/fetch_user_profile.dart';
import '../../domain/usecases/sign_out.dart';
import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final FetchUserProfile fetchUserProfile;
  final SignOut signOut;

  SettingsBloc(this.fetchUserProfile, this.signOut) : super(SettingsInitial()) {
    on<FetchUserProfileRequested>(_onFetchUserProfileRequested);
    on<SignOutRequested>(_onSignOutRequested);
  }

  Future<void> _onFetchUserProfileRequested(FetchUserProfileRequested event, Emitter<SettingsState> emit) async {
    emit(SettingsLoading());
    final result = await fetchUserProfile();
    result.fold(
          (failure) => emit(SettingsError(failure.message)),
          (userProfile) => emit(SettingsLoaded(userProfile)),
    );
  }

  Future<void> _onSignOutRequested(SignOutRequested event, Emitter<SettingsState> emit) async {
    emit(SettingsLoading());
    final result = await signOut();
    result.fold(
          (failure) => emit(SettingsError(failure.message)),
          (_) => emit(SignOutSuccess()),
    );
  }
}