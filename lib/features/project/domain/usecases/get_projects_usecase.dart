import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/project.dart';
import '../repositories/project_repository.dart';

class GetProjectsUseCase implements UseCase<List<Project>, NoParams> {
  final ProjectRepository repository;

  GetProjectsUseCase(this.repository);

  @override
  Future<Either<Failure, List<Project>>> call(NoParams params) async {
    return await repository.getProjects();
  }
}

class NoParams {}