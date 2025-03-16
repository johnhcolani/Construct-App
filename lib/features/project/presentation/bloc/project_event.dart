abstract class ProjectEvent {}

class LoadProjects extends ProjectEvent {}

class CreateProject extends ProjectEvent {
  final String name;
  final String imageUrl;

  CreateProject({required this.name, required this.imageUrl});
}