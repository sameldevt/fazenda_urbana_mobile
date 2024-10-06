import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:verdeviva/common/constants.dart';
import 'package:verdeviva/model/user.dart';
import 'package:http/http.dart' as http;

class UserService {
  final String _userKey = "user_info";

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
}
