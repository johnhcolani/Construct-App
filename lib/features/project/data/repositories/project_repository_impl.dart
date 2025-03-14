import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/project.dart';
import '../../domain/repositories/project_repository.dart';
import '../datasources/project_remote_datasource.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final ProjectRemoteDataSource remoteDataSource;

  ProjectRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Project>>> getProjects() async {
    try {
      final projects = await remoteDataSource.getProjects();
      return Right(projects);
    } catch (e) {
      return Left(ServerFailure('Failed to fetch projects: $e'));
    }
  }
}