import 'package:shared_preferences/shared_preferences.dart';
import 'package:verdeviva/model/order.dart';
import 'package:verdeviva/service/user_service.dart';

class User {
  final int id;
  final String name;
  final String profilePic;
  final Contact contact;
  final List<Address> addresses;
  List<Order>? orders;

  User({
    required this.id,
    required this.name,
    required this.profilePic,
    required this.contact,
    required this.addresses,
  });

  factory User.simple(String name, String email) {
    return User(
      id: 0,
      name: name,
      profilePic: "",
      contact: Contact.empty(),
      addresses: [],
    );
  }

  static Future<User?> fromSharedPreferences() async {
    final userService = UserService();
    return await userService.loadUserInfo();
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['nome'],
      profilePic: json['fotoPerfil'] ?? '',
      contact: Contact.fromJson(json['contato']),
      addresses: List.generate(
        json['enderecos'].length,
            (index) => Address.fromJson(json['enderecos'][index]),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nome": name,
      "contato": contact.toJson(),
      "enderecos": addresses.map((address) => address.toJson()).toList(),
    };
  }
}

class Address {
  final String street;
  final String number;
  final String city;
  final String zipCode;
  final String complement;
  final String state;

  const Address({
    required this.street,
    required this.number,
    required this.city,
    required this.zipCode,
    required this.complement,
    required this.state,
  });

  @override
  String toString() {
    return '$street $number $city $zipCode $complement $state';
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['logradouro'] ?? '',
      number: json['numero'] ?? '',
      city: json['cidade']?? '',
      zipCode: json['cep']?? '',
      complement: json['complemento']?? '',
      state: json['estado']?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'number': number,
      'city': city,
      'zipCode': zipCode,
      'complement': complement,
      'state': state,
    };
  }
}

class Contact {
  final String phone;
  final String email;

  const Contact({
    required this.phone,
    required this.email,
  });

  factory Contact.empty() {
    return const Contact(phone: '', email: '');
  }

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'email': email,
    };
  }
}