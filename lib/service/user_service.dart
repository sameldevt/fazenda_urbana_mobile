import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:verdeviva/common/constants.dart';
import 'package:verdeviva/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:verdeviva/service/access_service.dart';

class UserService {
  final String _userKey = "user_info";
  final String contextUrl = "usuario";

  Future<void> saveUserInfo(User user) async {
    final prefs = await SharedPreferences.getInstance();
    String userInfo = jsonEncode(user.toJson());

    await prefs.setString(_userKey, userInfo);
  }

  Future<User?> loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    String userInfoJson = prefs.getString(_userKey) ?? "";

    if (userInfoJson.isNotEmpty) {
      Map<String, dynamic> userMap = jsonDecode(userInfoJson);
      return User.fromJson(userMap);
    }

    return null;
  }

  Future<void> deleteUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_userKey);
  }

  Future<void> updateAddress(Map<String, String> info) async {
    final prefs = await SharedPreferences.getInstance();
    String userInfoJson = prefs.getString(_userKey) ?? "";

    return null;
  }

  Future<void> createAddress(Map<String, String> address) async {
    http.Response response = await http.post(
      Uri.parse("$baseApiUrl/$contextUrl/cadastrar-endereco"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({"email": "", "senha": ""}),
    );

    if(response.statusCode == 500){
      throw ServerErrorException();
    }

    if(response.statusCode == 404){
      throw UserNotFoundException();
    }

    if (response.statusCode == 400) {
      throw InvalidCredentialsException();
    }

    final service = UserService();

    service.saveUserInfo(User.fromJson(jsonDecode(response.body)));
    //return saveInfosFromResponse(response.body);
  }
}
