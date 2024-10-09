import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verdeviva/common/constants.dart';
import 'package:verdeviva/model/user.dart';
import 'package:verdeviva/service/user_service.dart';

class AccessService {
  final String contextUrl = "usuario";

  Future<void> recoverPassword(String email, String newPassword) async {
    final response = await http.post(
      Uri.parse('$baseApiUrl/$contextUrl/alterar-senha'),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({"email": email, "novaSenha": newPassword}),
    );

    if (response.statusCode == 500) {
      throw ServerErrorException();
    }

    if (response.statusCode == 404) {
      throw UserNotFoundException();
    }

    final service = UserService();
    service.saveUserInfo(User.fromJson(jsonDecode(response.body)));
  }

  Future<User> login(String email, String password) async {
    http.Response response = await http.post(
      Uri.parse("$baseApiUrl/$contextUrl/entrar"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({"email": email, "senha": password}),
    );

    if (response.statusCode == 500) {
      throw ServerErrorException();
    }

    if (response.statusCode == 404) {
      throw UserNotFoundException();
    }

    if (response.statusCode == 400) {
      throw InvalidCredentialsException();
    }

    return User.fromJson(jsonDecode(response.body));
    //return saveInfosFromResponse(response.body);
  }

  Future<void> register(String name, String email, String password) async {
    http.Response response = await http.post(
      Uri.parse("$baseApiUrl/$contextUrl/registrar"),
      headers: {
        "Content-Type": "application/json", // Especifica o tipo como JSON
      },
      body: jsonEncode({
        "nome": name,
        "senha": password,
        "contato": {"telefone": "", "email": email}
      }),
    );

    if (response.statusCode == 500) {
      throw ServerErrorException();
    }

    if (response.statusCode == 400) {
      throw UserAlreadyExists();
    }

    final service = UserService();

    service.saveUserInfo(User.fromJson(jsonDecode(response.body)));
    //return saveInfosFromResponse(response.body);
  }

  Future<String> saveInfosFromResponse(String body) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    Map<String, dynamic> map = json.decode(body);

    sharedPreferences.setString("accessToken", map["accessToken"]);
    sharedPreferences.setString("id", map["user"]["id"].toString());
    sharedPreferences.setString("email", map["user"]["email"]);

    return map["accessToken"];
  }
}

class UserNotFoundException implements Exception {}

class UserAlreadyExists implements Exception {}

class InvalidCredentialsException implements Exception {}

class ServerErrorException implements Exception {}
