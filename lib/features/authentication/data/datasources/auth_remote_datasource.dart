import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl(this.client);

  @override
  Future<UserModel> login(String email, String password) async {
    // Mock API call
    final response = await client.post(
      Uri.parse('https://api.example.com/login'),
      body: jsonEncode({'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to login');
    }
  }
}