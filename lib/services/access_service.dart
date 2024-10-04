import 'package:http/http.dart' as http;
import 'package:verdeviva/common/constants.dart';
import 'package:verdeviva/model/dtos/login_dto.dart';
import 'dart:convert';

class AccessService {
  final String contextUrl = "usuario";

  Future<String> login(LoginDto loginDto) async {
    final response = await http.post(
      Uri.parse('$baseApiUrl/$contextUrl/entrar'),
      body: loginDto.toJson(),
    );

    return response.body;
  }

  Future<String> register(LoginDto loginDto) async {
    final response = await http.post(
      Uri.parse('$baseApiUrl/$contextUrl/entrar'),
      body: loginDto.toJson(),
    );

    return response.body;
  }

  Future<String> recoverPassword(LoginDto loginDto) async {
    final response = await http.post(
      Uri.parse('$baseApiUrl/$contextUrl/entrar'),
      body: loginDto.toJson(),
    );

    return response.body;
  }
}
