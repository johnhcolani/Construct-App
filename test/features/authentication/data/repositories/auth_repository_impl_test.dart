import 'package:construct_app/core/error/failures.dart';
import 'package:construct_app/features/authentication/data/datasources/auth_remote_datasource.dart';
import 'package:construct_app/features/authentication/data/models/user_model.dart';
import 'package:construct_app/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repository_impl_test.mocks.dart';


@GenerateMocks([AuthRemoteDataSource])
void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockAuthRemoteDataSource();
    repository = AuthRepositoryImpl(mockRemoteDataSource);
  });

  final tEmail = 'test@example.com';
  final tPassword = 'password';
  final tUserModel = UserModel(id: '1', email: tEmail);

  test('should return a User when the remote data source is successful',
          () async {
        // Arrange
        when(mockRemoteDataSource.login(any, any))
            .thenAnswer((_) async => tUserModel);

        // Act
        final result = await repository.login(tEmail, tPassword);

        // Assert
        expect(result, Right(tUserModel));
        verify(mockRemoteDataSource.login(tEmail, tPassword));
      });

  test('should return a ServerFailure when the remote data source fails',
          () async {
        // Arrange
        when(mockRemoteDataSource.login(any, any)).thenThrow(Exception('Error'));

        // Act
        final result = await repository.login(tEmail, tPassword);

        // Assert
        expect(result, Left(ServerFailure('Failed to login: Exception: Error')));
        verify(mockRemoteDataSource.login(tEmail, tPassword));
      });
}