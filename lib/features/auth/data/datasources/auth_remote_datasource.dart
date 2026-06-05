import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/http_client.dart';
import '../models/user_model.dart';


abstract class AuthRemoteDataSource {
  Future<String> login(String email, String password);
  Future<UserModel> register(String name, String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final HttpClient httpClient;

  AuthRemoteDataSourceImpl(this.httpClient);

  @override
  Future<String> login(String email, String password) async {
    final response = await http.post(
      httpClient.buildUrl(ApiConstants.login),
      headers: httpClient.headers,
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return '${data['token']}|${data['name']}';
    } else if (response.statusCode == 401) {
      throw UnauthorizedException(jsonDecode(response.body)['message']);
    } else {
      throw ServerException(jsonDecode(response.body)['message']);
    }
  }

  @override
  Future<UserModel> register(String name, String email, String password) async {
    final response = await http.post(
      httpClient.buildUrl(ApiConstants.register),
      headers: httpClient.headers,
      body: jsonEncode({'name': name, 'email': email, 'password': password}),
    );

    if (response.statusCode == 201) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException(jsonDecode(response.body)['message']);
    }
  }
}