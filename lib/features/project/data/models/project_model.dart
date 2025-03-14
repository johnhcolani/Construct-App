import '../../domain/entities/project.dart';

class ProjectModel extends Project {
  ProjectModel({
    required String id,
    required String name,
    required String imageUrl,
  }) : super(id: id, name: name, imageUrl: imageUrl);

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
    );
  }
}