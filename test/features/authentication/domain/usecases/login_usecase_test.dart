import 'package:construct_app/core/error/failures.dart';
import 'package:construct_app/features/authentication/domain/entities/user.dart';
import 'package:construct_app/features/authentication/domain/repositories/auth_repository.dart';
import 'package:construct_app/features/authentication/domain/usecases/login_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_usecase_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late LoginUseCase useCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = LoginUseCase(mockAuthRepository);
  });

  final tUser = User(id: '1', email: 'test@example.com');
  final tParams = LoginParams(email: 'test@example.com', password: 'password');

  test('should return a User when login is successful', () async {
    // Arrange
    when(mockAuthRepository.login(any, any))
        .thenAnswer((_) async => Right(tUser));

    // Act
    final result = await useCase(tParams);

    // Assert
    expect(result, Right(tUser));
    verify(mockAuthRepository.login(tParams.email, tParams.password));
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should return a Failure when login fails', () async {
    // Arrange
    when(mockAuthRepository.login(any, any))
        .thenAnswer((_) async => Left(ServerFailure('Login failed')));

    // Act
    final result = await useCase(tParams);

    // Assert
    expect(result, Left(ServerFailure('Login failed')));
    verify(mockAuthRepository.login(tParams.email, tParams.password));
    verifyNoMoreInteractions(mockAuthRepository);
  });
}