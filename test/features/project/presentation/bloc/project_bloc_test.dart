import 'package:bloc_test/bloc_test.dart';
import 'package:construct_app/core/error/failures.dart';
import 'package:construct_app/features/project/domain/entities/project.dart';
import 'package:construct_app/features/project/domain/usecases/get_projects_usecase.dart';
import 'package:construct_app/features/project/presentation/bloc/project_bloc.dart';
import 'package:construct_app/features/project/presentation/bloc/project_event.dart';
import 'package:construct_app/features/project/presentation/bloc/project_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'project_bloc_test.mocks.dart';


@GenerateMocks([GetProjectsUseCase])
void main() {
  late ProjectBloc projectBloc;
  late MockGetProjectsUseCase mockGetProjectsUseCase;

  setUp(() {
    mockGetProjectsUseCase = MockGetProjectsUseCase();
    projectBloc = ProjectBloc(mockGetProjectsUseCase);
  });

  final tProjects = [
    Project(id: '1', name: 'Project 1', imageUrl: 'https://example.com/image1'),
    Project(id: '2', name: 'Project 2', imageUrl: 'https://example.com/image2'),
  ];

  tearDown(() {
    projectBloc.close();
  });

  test('initial state should be ProjectInitial', () {
    expect(projectBloc.state, ProjectInitial());
  });

  blocTest<ProjectBloc, ProjectState>(
    'emits [ProjectLoading, ProjectLoaded] when fetching projects is successful',
    build: () {
      when(mockGetProjectsUseCase(any))
          .thenAnswer((_) async => Right(tProjects));
      return projectBloc;
    },
    act: (bloc) => bloc.add(FetchProjects()),
    expect: () => [ProjectLoading(), ProjectLoaded(tProjects)],
    verify: (_) {
      verify(mockGetProjectsUseCase(NoParams()));
    },
  );

  blocTest<ProjectBloc, ProjectState>(
    'emits [ProjectLoading, ProjectError] when fetching projects fails',
    build: () {
      when(mockGetProjectsUseCase(any))
          .thenAnswer((_) async => Left(ServerFailure('Fetch failed')));
      return projectBloc;
    },
    act: (bloc) => bloc.add(FetchProjects()),
    expect: () => [ProjectLoading(), ProjectError('Fetch failed')],
    verify: (_) {
      verify(mockGetProjectsUseCase(NoParams()));
    },
  );
}