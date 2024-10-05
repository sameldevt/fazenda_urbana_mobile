import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verdeviva/common/constants.dart';
import 'package:verdeviva/model/dtos/login_dto.dart';
import 'dart:convert';

class AccessService {
  final String contextUrl = "usuario";

  // Future<String> login(LoginDto loginDto) async {
  //   final response = await http.post(
  //     Uri.parse('$baseApiUrl/$contextUrl/entrar'),
  //     body: loginDto.toJson(),
  //   );
  //
  //   return response.body;
  // }
  //
  // Future<String> register(LoginDto loginDto) async {
  //   final response = await http.post(
  //     Uri.parse('$baseApiUrl/$contextUrl/entrar'),
  //     body: loginDto.toJson(),
  //   );
  //
  //   return response.body;
  // }

  Future<String> recoverPassword(LoginDto loginDto) async {
    final response = await http.post(
      Uri.parse('$baseApiUrl/$contextUrl/entrar'),
      body: loginDto.toJson(),
    );

    return response.body;
  }

  Future<String> login(String email, String password) async {
    http.Response response = await http.post(
      Uri.parse("$baseApiUrl/$contextUrl/entrar"),
      body: {"email": email, "password": password},
    );

    if (response.statusCode == 400 &&
        json.decode(response.body) == "Cannot find user") {
      throw UserNotFoundException();
    }

    if (response.statusCode != 200) {
      //throw const HttpException("");
    }

    return saveInfosFromResponse(response.body);
  }

  Future<String> register(String email, String password) async {
    http.Response response = await http.post(
      Uri.parse("$baseApiUrl/$contextUrl/registrar"),
      body: {"email": email, "password": password},
    );

    if (response.statusCode != 200) {
      //TODO: Implementar outros casos
      switch (response.body) {
        case "Email already exists":
          throw UserAlreadyExists();
      }
    }

    return saveInfosFromResponse(response.body);
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