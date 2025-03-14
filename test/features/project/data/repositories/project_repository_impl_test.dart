import 'package:construct_app/core/error/failures.dart';
import 'package:construct_app/features/project/data/datasources/project_remote_datasource.dart';
import 'package:construct_app/features/project/data/models/project_model.dart';
import 'package:construct_app/features/project/data/repositories/project_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'project_repository_impl_test.mocks.dart';


@GenerateMocks([ProjectRemoteDataSource])
void main() {
  late ProjectRepositoryImpl repository;
  late MockProjectRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockProjectRemoteDataSource();
    repository = ProjectRepositoryImpl(mockRemoteDataSource);
  });

  final tProjects = [
    ProjectModel(id: '1', name: 'Project 1', imageUrl: 'https://example.com/image1'),
    ProjectModel(id: '2', name: 'Project 2', imageUrl: 'https://example.com/image2'),
  ];

  test('should return a list of Projects when the remote data source is successful',
          () async {
        // Arrange
        when(mockRemoteDataSource.getProjects())
            .thenAnswer((_) async => tProjects);

        // Act
        final result = await repository.getProjects();

        // Assert
        expect(result, Right(tProjects));
        verify(mockRemoteDataSource.getProjects());
      });

  test('should return a ServerFailure when the remote data source fails',
          () async {
        // Arrange
        when(mockRemoteDataSource.getProjects()).thenThrow(Exception('Error'));

        // Act
        final result = await repository.getProjects();

        // Assert
        expect(result, Left(ServerFailure('Failed to fetch projects: Exception: Error')));
        verify(mockRemoteDataSource.getProjects());
      });
}