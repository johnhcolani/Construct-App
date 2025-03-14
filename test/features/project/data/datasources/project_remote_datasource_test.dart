import 'package:construct_app/features/project/data/datasources/project_remote_datasource.dart';
import 'package:construct_app/features/project/data/models/project_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import 'project_remote_datasource_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late ProjectRemoteDataSourceImpl dataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = ProjectRemoteDataSourceImpl(mockHttpClient);
  });

  final tProjects = [
    ProjectModel(id: '1', name: 'Project 1', imageUrl: 'https://example.com/image1'),
    ProjectModel(id: '2', name: 'Project 2', imageUrl: 'https://example.com/image2'),
  ];

  test('should return a list of ProjectModels when the API call is successful', () async {
    // Arrange
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(
        '[{"id": "1", "name": "Project 1", "imageUrl": "https://example.com/image1"},'
            '{"id": "2", "name": "Project 2", "imageUrl": "https://example.com/image2"}]',
        200));

    // Act
    final result = await dataSource.getProjects();

    // Assert
    expect(result, tProjects);
    verify(mockHttpClient.get(
      Uri.parse('https://api.example.com/projects'),
      headers: {'Content-Type': 'application/json'},
    ));
  });

  test('should throw an Exception when the API call fails', () async {
    // Arrange
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Not Found', 404));

    // Act & Assert
    expect(() => dataSource.getProjects(), throwsException);
  });
}