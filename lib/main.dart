import 'package:flutter/material.dart';
import 'package:verdeviva/screens/access/change_password_screen.dart';
import 'package:verdeviva/screens/access/login_screen.dart';
import 'package:verdeviva/screens/access/register_screen.dart';
import 'package:verdeviva/screens/account/address_screen.dart';
import 'package:verdeviva/screens/account/personal_data_screen.dart';
import 'package:verdeviva/screens/market/card_payment_screen.dart';
import 'package:verdeviva/screens/market/confirm_order_screen.dart';
import 'package:verdeviva/screens/market/home_screen.dart';
import 'package:verdeviva/screens/market/my_cart_screen.dart';
import 'package:verdeviva/screens/market/my_orders_screen.dart';
import 'package:verdeviva/screens/market/payment_method.dart';
import 'package:verdeviva/screens/market/pix_payment_screen.dart';
import 'package:verdeviva/screens/market/shipping_screen.dart';

void main() {
  runApp(const App(isLogged: false,));
}

class App extends StatelessWidget {
  final bool isLogged;

  const App({super.key, required this.isLogged});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Projeto mobile VerdeViva',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Colors.black,
          titleTextStyle: TextStyle(color: Colors.black),
          actionsIconTheme: IconThemeData(color: Colors.black),
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
      initialRoute: (isLogged) ? "home" : "login",
      routes: {
        "login": (context) => LoginScreen(),
        "home": (context) => HomeScreen(),
        "register": (context) => const RegisterScreen(),
        "change-pass": (context) => const ChangePasswordScreen(),
        "cart": (context) => MyCartScreen(),
        "personal-data": (context) => const PersonalDataScreen(),
        "address": (context) => const AddressScreen(),
        "orders": (context) => const MyOrdersScreen(),
        "confirm-order": (context) => ConfirmOrderScreen(),
        "shipping": (context) => ShippingScreen(),
        "payment-method": (context) => PaymentMethodScreen(),
        "pix-payment": (context) => PixPaymentScreen(),
        "card-payment": (context) => CardPaymentScreen(),
      },
    );
  }
}

class DadosPessoaisScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fazenda VerdeViva'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        Text('Dados pessoais', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        TextField(
            decoration: InputDecoration(labelText: 'Nome Completo'),
        // ...
      ),
      // Outros campos de texto...
      ElevatedButton(onPressed: () {
        // Salvar alterações
      }, child: Text('Alterar')),
      ElevatedButton(onPressed: () {
        // Alterar senha
      }, child: Text('Alterar senha')),
      ],
    ),
    ),
    // ... bottomNavigationBar
    );
  }
}

class EnderecoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fazenda VerdeViva'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
          Text('Endereço padrão', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              TextField(
              decoration: InputDecoration(labelText: 'Endereço'),
          // ...
        ),
        // Outros campos de texto...
        ElevatedButton(onPressed: () {
          // Salvar alterações
        }, child: Text('Alterar')),
        ],
      ),
    ),
    // ... bottomNavigationBar
    );
  }
}

