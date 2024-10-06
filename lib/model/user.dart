import 'package:shared_preferences/shared_preferences.dart';
import 'package:verdeviva/service/user_service.dart';

class User {
  final int id;
  final String name;
  final String phone;
  final String email;
  final String street;
  final String number;
  final String city;
  final String zipCode;
  final String complement;
  final String state;
  final String additionalInformation;

  const User({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.street,
    required this.number,
    required this.city,
    required this.zipCode,
    required this.complement,
    required this.state,
    required this.additionalInformation,
  });

  bool hasAddress() {
    return street.isNotEmpty &&
        number.isNotEmpty &&
        city.isNotEmpty &&
        zipCode.isNotEmpty &&
        state.isNotEmpty &&
        complement.isNotEmpty;
  }

  factory User.simple(String name, String email){
    return User(
      id: 0,
      name: name,
      phone: '',
      email: email,
      street: '',
      number: '',
      city: '',
      zipCode: '',
      complement: '',
      state: '',
      additionalInformation: '',
    );
  }

  static Future<User?> fromSharedPreferences() async {
    final userService = UserService();
    return await userService.loadUserInfo();
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['nome'] ?? '',
      phone: json['telefone'] ?? '',
      email: json['email'] ?? '',
      street: json['logradouro'] ?? '',
      number: json['numero'] ?? '',
      city: json['cidade'] ?? '',
      zipCode: json['cEP'] ?? '',
      complement: json['complemento'] ?? '',
      state: json['estado'] ?? '',
      additionalInformation: json['informacoesAdicionais'] ?? '',
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "nome": name,
      "telefone": phone ?? '',
      "email": email,
      "logradouro": street ?? '',
      "numero": number ?? '',
      "cidade": city ?? '',
      "cEP": zipCode ?? '',
      "complemento": complement ?? '',
      "estado": state ?? '',
      "informacoesAdicionais": additionalInformation ?? ''
    };
  }
}
