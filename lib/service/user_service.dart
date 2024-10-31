import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verdeviva/common/constants.dart';
import 'package:verdeviva/model/order.dart';
import 'package:verdeviva/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:verdeviva/providers/user_provider.dart';
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

  Future<List<Address>> loadAddresses(BuildContext context) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final userId = userProvider.user!.id;

      final response = await http.get(
        Uri.parse('$baseApiUrl/cliente/buscar/$userId'),
      );

      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      print(responseBody);
      List<dynamic> addressesJson = responseBody['enderecos'];

      return addressesJson.map((address) => Address.fromJson(address)).toList();
    } catch (e) {
      print('Erro ao carregar endereços: $e');
      return [];
    }
  }

  Future<void> deleteUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_userKey);
  }

  Future<List<Order>> getOrders(BuildContext context) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final userId = userProvider.user!.id;
      final response = await http.get(
          Uri.parse('$baseApiUrl/$contextUrl/buscar-pedidos?id=${userId}'));
      List<dynamic> responseBody = jsonDecode(response.body);

      return responseBody.map((product) => Order.fromJson(product)).toList();
    } catch (Exception) {
      return [];
    }
  }

  Future<void> updateAddress(Map<String, String> info) async {
    final prefs = await SharedPreferences.getInstance();
    String userInfoJson = prefs.getString(_userKey) ?? "";

    return null;
  }

  Future<void> deleteAddress(Address address) async {
    final prefs = await SharedPreferences.getInstance();
    String userInfoJson = prefs.getString(_userKey) ?? "";

    return null;
  }

  Future<void> createAddress(Map<String, String> address, context) async {
    final userService = UserService();
    userService.loadUserInfo().then((user) async {
      final email = user!.contact.email;
      http.Response response = await http.post(
        Uri.parse("$baseApiUrl/$contextUrl/cadastrar-endereco"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "email": email,
          "logradouro": address['street'],
          "numero": address['number'],
          "cidade": address['city'],
          "cep": address['zipCode'],
          "complemento": address['complement'],
          "estado": address['state'],
          "informacoesAdicionais": address['additionalInfo']
        }),
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

      userService.saveUserInfo(User.fromJson(jsonDecode(response.body)));
    });
  }
}
