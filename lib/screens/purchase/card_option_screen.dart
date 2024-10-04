import 'package:flutter/material.dart';
import 'package:verdeviva/common/constants.dart';
import 'package:verdeviva/screens/purchase/purchase_sumary_screen.dart';

class CardOptionScreen extends StatefulWidget {
  const CardOptionScreen({super.key});

  @override
  State<CardOptionScreen> createState() => _CardOptionScreenState();
}

class _CardOptionScreenState extends State<CardOptionScreen> {
  String pixCode = 'e7a1fbe0-9c5c-4427-b0d1-f2e02d3cb6ff';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appBarColor = theme.colorScheme.primary;
    final background = theme.colorScheme.surface;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: const Text(
          'Escolher ou cadastrar cartão',
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 30,
        ),
      ),
      backgroundColor: background,
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(appPadding),
                child: Column(
                  children: [
                    _Header(),
                    SizedBox(
                      height: 8,
                    ),
                    Expanded(
                      child: _CardOptions(),
                    ),
                    _OrderInfo(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Escolher cartão',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Escolha o cartão que deseja usar',
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}

class _CardOptions extends StatefulWidget {
  const _CardOptions();

  @override
  State<_CardOptions> createState() => _CardOptionsState();
}

class _CardOptionsState extends State<_CardOptions> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, 'create-card');
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.add_card, color: Colors.grey),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cadastrar novo cartão',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ],
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.green),
            ],
          ),
        ),
        const Row(
          children: [
            Expanded(
              child: Divider(
                color: Colors.grey, // Cor do divisor
                thickness: 0.5, // Espessura do divisor
                indent: 0, // Recuo no início do divisor
                endIndent: 0, // Recuo no final do divisor
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: InkWell(
            onTap: () {
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const PurchaseSummaryScreen(paymentMethod: 'card')),
                );
              });
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.credit_card, color: Colors.grey),
                    SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Usar cartão final 0982',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ],
                ),
                Icon(Icons.arrow_forward_ios, color: Colors.green),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _OrderInfo extends StatelessWidget {
  const _OrderInfo();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.white,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Produtos (2)',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
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
              Text(
                'Frete',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
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
        ],
      ),
    );
  }
}
