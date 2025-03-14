import 'package:construct_app/core/error/failures.dart';
import 'package:construct_app/features/project/domain/entities/project.dart';
import 'package:construct_app/features/project/domain/repositories/project_repository.dart';
import 'package:construct_app/features/project/domain/usecases/get_projects_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_projects_usecase_test.mocks.dart';


@GenerateMocks([ProjectRepository])
void main() {
  late GetProjectsUseCase useCase;
  late MockProjectRepository mockProjectRepository;

  setUp(() {
    mockProjectRepository = MockProjectRepository();
    useCase = GetProjectsUseCase(mockProjectRepository);
  });

  final tProjects = [
    Project(id: '1', name: 'Project 1', imageUrl: 'https://example.com/image1'),
    Project(id: '2', name: 'Project 2', imageUrl: 'https://example.com/image2'),
  ];

  test('should return a list of Projects when fetching is successful', () async {
    // Arrange
    when(mockProjectRepository.getProjects())
        .thenAnswer((_) async => Right(tProjects));

    // Act
    final result = await useCase(NoParams());

    // Assert
    expect(result, Right(tProjects));
    verify(mockProjectRepository.getProjects());
    verifyNoMoreInteractions(mockProjectRepository);
  });

  test('should return a Failure when fetching fails', () async {
    // Arrange
    when(mockProjectRepository.getProjects())
        .thenAnswer((_) async => Left(ServerFailure('Fetch failed')));

    // Act
    final result = await useCase(NoParams());

    // Assert
    expect(result, Left(ServerFailure('Fetch failed')));
    verify(mockProjectRepository.getProjects());
    verifyNoMoreInteractions(mockProjectRepository);
  });
}