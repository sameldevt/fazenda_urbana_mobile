import 'package:flutter/material.dart';
import 'package:verdeviva/common/custom_widgets.dart';
import 'package:verdeviva/common/buttons.dart';
import 'package:verdeviva/common/cards.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  int onSelected(int value) {
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(onItemSelected: onSelected),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // NavigationPrimaryButton(
            //   route: '',
            //   buttonText: 'Teste',
            //   buttonTextSize: 20,
            // ),
            // NavigationSecondaryButton(
            //   route: '',
            //   buttonText: 'Teste 2',
            //   buttonTextSize: 20,
            // ),
            // ActionButton(
            //   buttonText: 'Teste 3',
            //   buttonTextSize: 20,
            // ),
            //ShopCard(name: 'teste', description: 'teste', price: '1', image: 'https://rb.gy/2xfabn'),
          ],
        ),
      ),
    );
  }
}
