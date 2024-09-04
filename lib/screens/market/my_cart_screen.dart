import 'package:flutter/material.dart';
import 'package:verdeviva/common/buttons.dart';
import 'package:verdeviva/common/sections.dart';
import 'package:verdeviva/screens/market/widgets/product_card.dart';

class MyCartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final background = theme.colorScheme.surfaceBright;

    return Scaffold(
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
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Fundo branco
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Sombra cinza com opacidade
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, -3), // Sombra apenas na parte superior
            ),
          ],
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 16, 16.0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Valor total da compra',
                    style: TextStyle(
                      fontSize: 16,
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
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: NavigationPrimaryButton(
                    route: 'cart',
                    buttonText: 'Continuar a compra',
                    buttonTextSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
