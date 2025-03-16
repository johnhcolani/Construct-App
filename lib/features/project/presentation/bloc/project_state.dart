import 'package:construct_app/features/project/domain/entities/project.dart';

abstract class ProjectState {}

class ProjectInitial extends ProjectState {}

class ProjectLoading extends ProjectState {}

class ProjectLoaded extends ProjectState {
  final List<Project> projects;

  ProjectLoaded(this.projects);
}

class ProjectError extends ProjectState {
  final String message;

  ProjectError(this.message);
}