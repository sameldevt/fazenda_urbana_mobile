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

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['Id'] ?? 0,
      name: json['Nome'] ?? '',
      phone: json['Telefone'] ?? '',
      email: json['Email'] ?? '',
      street: json['Logradouro'] ?? '',
      number: json['Numero'] ?? '',
      city: json['Cidade'] ?? '',
      zipCode: json['CEP'] ?? '',
      complement: json['Complemento'] ?? '',
      state: json['Estado'] ?? '',
      additionalInformation: json['InformacoesAdicionais'] ?? '',
    );
  }
}