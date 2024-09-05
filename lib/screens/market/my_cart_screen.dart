import 'package:flutter/material.dart';
import 'package:verdeviva/common/buttons.dart';
import 'package:verdeviva/common/sections.dart';
import 'package:verdeviva/screens/market/widgets/product_card.dart';

class MyCartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appBarColor = theme.colorScheme.primary;
    final background = theme.colorScheme.surface;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: const Text(
          'Carrinho',
          style: TextStyle(
              fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
      ),
      backgroundColor: background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CartItemsSection(),
          ),
          _ContinuePurchaseSection(),
        ],
      ),
    );
  }
}

class _ContinuePurchaseSection extends StatefulWidget {
  const _ContinuePurchaseSection({super.key});

  @override
  State<_ContinuePurchaseSection> createState() =>
      _ContinuePurchaseSectionState();
}

class _ContinuePurchaseSectionState extends State<_ContinuePurchaseSection> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.white,
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Produtos (2)',style: TextStyle(
                    fontSize: 14,
                  ),),
                  Text(
                    'R\$ 18,99',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Frete',style: TextStyle(
                    fontSize: 14,
                  ),),
                  Text(
                    'R\$ 2,99',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'R\$ 18,99',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 4.0),
                child: Center(
                  child: NavigationPrimaryButton(
                      route: 'address',
                      buttonText: 'Continuar a compra',
                      buttonTextSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
