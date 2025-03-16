import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final FirebaseAuth _firebaseAuth;

  SplashBloc(this._firebaseAuth) : super(SplashInitial()) {
    on<CheckAuthStatus>((event, emit) async {
      emit(SplashLoading());
      await Future.delayed(Duration(seconds: 2)); // Simulate splash delay
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        emit(SplashAuthenticated());
      } else {
        emit(SplashUnauthenticated());
      }
    });
  }
}