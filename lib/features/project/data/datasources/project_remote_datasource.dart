import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/project_model.dart';

abstract class ProjectRemoteDataSource {
  Future<List<ProjectModel>> getProjects();
}

class ProjectRemoteDataSourceImpl implements ProjectRemoteDataSource {
  final http.Client client;

  ProjectRemoteDataSourceImpl(this.client);

  @override
  Future<List<ProjectModel>> getProjects() async {
    // Mock API call
    final response = await client.get(
      Uri.parse('https://api.example.com/projects'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> projectJson = jsonDecode(response.body);
      return projectJson.map((json) => ProjectModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch projects');
    }
  }
}