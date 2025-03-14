import 'package:construct_app/features/authentication/data/datasources/auth_remote_datasource.dart';
import 'package:construct_app/features/authentication/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../../project/data/datasources/project_remote_datasource_test.mocks.dart';


@GenerateMocks([http.Client])
void main() {
  late AuthRemoteDataSourceImpl dataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = AuthRemoteDataSourceImpl(mockHttpClient);
  });

  final tEmail = 'test@example.com';
  final tPassword = 'password';
  final tUserModel = UserModel(id: '1', email: tEmail);

  test('should return a UserModel when the API call is successful', () async {
    // Arrange
    when(mockHttpClient.post(any,
        headers: anyNamed('headers'), body: anyNamed('body')))
        .thenAnswer((_) async => http.Response(
        '{"id": "1", "email": "test@example.com"}', 200));

    // Act
    final result = await dataSource.login(tEmail, tPassword);

    // Assert
    expect(result, tUserModel);
    verify(mockHttpClient.post(
      Uri.parse('https://api.example.com/login'),
      headers: {'Content-Type': 'application/json'},
      body: '{"email":"$tEmail","password":"$tPassword"}',
    ));
  });

  test('should throw an Exception when the API call fails', () async {
    // Arrange
    when(mockHttpClient.post(any,
        headers: anyNamed('headers'), body: anyNamed('body')))
        .thenAnswer((_) async => http.Response('Not Found', 404));

    // Act & Assert
    expect(() => dataSource.login(tEmail, tPassword), throwsException);
  });
}