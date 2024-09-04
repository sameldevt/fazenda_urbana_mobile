import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:verdeviva/configuration/theme.dart';
import 'package:verdeviva/screens/access/change_password_screen.dart';
import 'package:verdeviva/screens/access/login_screen.dart';
import 'package:verdeviva/screens/access/register_screen.dart';
import 'package:verdeviva/screens/account/address_screen.dart';
import 'package:verdeviva/screens/account/personal_data_screen.dart';
import 'package:verdeviva/screens/landing/landing_screen.dart';
import 'package:verdeviva/screens/market/card_payment_screen.dart';
import 'package:verdeviva/screens/market/confirm_order_screen.dart';
import 'package:verdeviva/screens/market/home_screen.dart';
import 'package:verdeviva/screens/market/my_cart_screen.dart';
import 'package:verdeviva/screens/market/my_orders_screen.dart';
import 'package:verdeviva/screens/market/order_details_screen.dart';
import 'package:verdeviva/screens/market/payment_method.dart';
import 'package:verdeviva/screens/market/payment_status_screen.dart';
import 'package:verdeviva/screens/market/pix_payment_screen.dart';
import 'package:verdeviva/screens/market/shipping_screen.dart';
import 'package:verdeviva/screens/test_screen.dart';

void main() {
  runApp(App(isLogged: false));
}

class App extends StatelessWidget {
  final bool isLogged;

  const App({super.key, required this.isLogged});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Projeto mobile VerdeViva',
      initialRoute: 'home',
      //initialRoute: (isLogged) ? "home" : "login",
      theme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: Colors.lightGreen.shade700,
          onPrimary: Colors.white,
          secondary: Colors.lightGreen.shade300,
          onSecondary: Colors.black,
          tertiary: Colors.lightGreen.shade100,
          onTertiary: Colors.black,
          surfaceBright: Colors.lightGreen.shade50,
          error: Colors.red,
          onError: Colors.white,
          background: Colors.grey[200]!,
          onBackground: Colors.black,
          surface: Colors.white,
          onSurface: Colors.black,
        ),
      ),
      routes: {
        "landing-screen": (context) => LandingScreen(),
        "test-screen": (context) => TestScreen(),
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
        "payment-status": (context) => PaymentStatusScreen(),
        "order-details": (context) => OrderDetailsScreen(),
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
            Text('Dados pessoais',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            TextField(
              decoration: InputDecoration(labelText: 'Nome Completo'),
              // ...
            ),
            // Outros campos de texto...
            ElevatedButton(
                onPressed: () {
                  // Salvar alterações
                },
                child: Text('Alterar')),
            ElevatedButton(
                onPressed: () {
                  // Alterar senha
                },
                child: Text('Alterar senha')),
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
            Text('Endereço padrão',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            TextField(
              decoration: InputDecoration(labelText: 'Endereço'),
              // ...
            ),
            // Outros campos de texto...
            ElevatedButton(
                onPressed: () {
                  // Salvar alterações
                },
                child: Text('Alterar')),
          ],
        ),
      ),
      // ... bottomNavigationBar
    );
  }
}
