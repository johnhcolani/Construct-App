import 'package:bloc_test/bloc_test.dart';
import 'package:construct_app/core/error/failures.dart';
import 'package:construct_app/features/authentication/domain/entities/user.dart';
import 'package:construct_app/features/authentication/domain/usecases/login_usecase.dart';
import 'package:construct_app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:construct_app/features/authentication/presentation/bloc/auth_event.dart';
import 'package:construct_app/features/authentication/presentation/bloc/auth_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_bloc_test.mocks.dart';


@GenerateMocks([LoginUseCase])
void main() {
  late AuthBloc authBloc;
  late MockLoginUseCase mockLoginUseCase;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    authBloc = AuthBloc(mockLoginUseCase);
  });

  final tUser = User(id: '1', email: 'test@example.com');
  final tEmail = 'test@example.com';
  final tPassword = 'password';

  tearDown(() {
    authBloc.close();
  });

  test('initial state should be AuthInitial', () {
    expect(authBloc.state, AuthInitial());
  });

  blocTest<AuthBloc, AuthState>(
    'emits [AuthLoading, AuthSuccess] when login is successful',
    build: () {
      when(mockLoginUseCase(any)).thenAnswer((_) async => Right(tUser));
      return authBloc;
    },
    act: (bloc) => bloc.add(LoginSubmitted(email: tEmail, password: tPassword)),
    expect: () => [AuthLoading(), AuthSuccess(tUser)],
    verify: (_) {
      verify(mockLoginUseCase(LoginParams(email: tEmail, password: tPassword)));
    },
  );

  blocTest<AuthBloc, AuthState>(
    'emits [AuthLoading, AuthFailure] when login fails',
    build: () {
      when(mockLoginUseCase(any))
          .thenAnswer((_) async => Left(ServerFailure('Login failed')));
      return authBloc;
    },
    act: (bloc) => bloc.add(LoginSubmitted(email: tEmail, password: tPassword)),
    expect: () => [AuthLoading(), AuthFailure('Login failed')],
    verify: (_) {
      verify(mockLoginUseCase(LoginParams(email: tEmail, password: tPassword)));
    },
  );
}