import 'package:flutter/material.dart';
import 'package:verdeviva/screens/access/recover_password_screen.dart';
import 'package:verdeviva/screens/access/login_screen.dart';
import 'package:verdeviva/screens/access/register_screen.dart';
import 'package:verdeviva/screens/account/account_screen.dart';
import 'package:verdeviva/screens/account/address_screen.dart';
import 'package:verdeviva/screens/account/change_password_screen.dart';
import 'package:verdeviva/screens/account/create_card_screen.dart';
import 'package:verdeviva/screens/account/personal_data_screen.dart';
import 'package:verdeviva/screens/market/cart_screen.dart';
import 'package:verdeviva/screens/market/confirm_order_screen.dart';
import 'package:verdeviva/screens/market/home_screen.dart';
import 'package:verdeviva/screens/market/order_details_screen.dart';
import 'package:verdeviva/screens/market/orders_screen.dart';
import 'package:verdeviva/screens/purchase/card_option_screen.dart';
import 'package:verdeviva/screens/purchase/payment/order_confirmation_screen.dart';
import 'package:verdeviva/screens/purchase/payment/pix_screen.dart';
import 'package:verdeviva/screens/purchase/payment_option_screen.dart';
import 'package:verdeviva/screens/purchase/payment_status_screen.dart';
import 'package:verdeviva/screens/purchase/shipping_option_screen.dart';
import 'package:verdeviva/screens/test_screen.dart';

import 'screens/purchase/not_logged_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Projeto mobile VerdeViva',
      initialRoute: "home",
      theme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: Colors.lightGreen.shade700,
          onPrimary: Colors.white,
          secondary: Colors.lightGreen.shade300,
          onSecondary: Colors.black,
          tertiary: Colors.lightGreen.shade100,
          onTertiary: Colors.black,
          surfaceBright: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          surface: Colors.white,
          onSurface: Colors.black,
        ),
      ),
      routes: {
        "test": (context) => const TestScreen(),
        "login": (context) => const LoginScreen(),
        "home": (context) => const HomeScreen(),
        "account": (context) => const AccountScreen(),
        "register": (context) => const RegisterScreen(),
        "recover-pass": (context) => const RecoverPasswordScreen(),
        "change-pass": (context) => ChangePasswordScreen(),
        "cart": (context) => const CartScreen(),
        "personal-data": (context) => const PersonalDataScreen(),
        "address": (context) => const ShippingOptionScreen(),
        "create-address": (context) => AddressScreen(),
        "orders": (context) => const OrdersScreen(),
        "confirm-order": (context) => const ConfirmOrderScreen(),
        "shipping": (context) => const ShippingOptionScreen(),
        "payment": (context) => const PaymentOptionScreen(),
        "pix-payment": (context) => const PixScreen(),
        "card-payment": (context) => const CardOptionScreen(),
        "payment-status": (context) => const PaymentStatusScreen(),
        "order-details": (context) => const OrderDetailsScreen(),
        "order-confirmation-screen": (context) => const OrderConfirmationScreen(),
        "create-card": (context) => const CreateCardScreen(),
        "card": (context) => const CardOptionScreen(),
        "not-logged": (context) => const NotLoggedScreen()
        //"purchase-sumary": (context) => PurchaseSumaryScreen(),
      },
    );
  }
}
