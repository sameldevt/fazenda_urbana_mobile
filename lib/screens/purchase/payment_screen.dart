import 'package:flutter/material.dart';
import 'package:verdeviva/common/buttons.dart';

class PaymentOptionScreen extends StatefulWidget {
  const PaymentOptionScreen({super.key});

  @override
  State<PaymentOptionScreen> createState() => _PaymentOptionScreenState();
}

class _PaymentOptionScreenState extends State<PaymentOptionScreen> {
  int? _selectedValue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appBarColor = theme.colorScheme.primary;
    final background = theme.colorScheme.surface;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: const Text(
          'Escolha uma opção de pagamento',
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 30,
        ),
      ),
      backgroundColor: background,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Métodos de Pagamento',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      )),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Icon(Icons.payment_outlined, color: Colors.grey),
                          SizedBox(width: 8),
                          Text(
                            'Escolha o método de pagamento',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
                          )
                        ],
                      )),
                ),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const Divider(
                      color: Colors.grey, // Cor do divisor
                      thickness: 0.5, // Espessura do divisor
                      indent: 10.0, // Recuo no início do divisor
                      endIndent: 10.0, // Recuo no final do divisor
                    ),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            Navigator.pushReplacementNamed(context, 'home');
                          });
                        },
                        child: _buildPaymentOption(
                          value: index + 1,
                          label: _getPaymentLabel(index),
                          icon: _getPaymentIcon(index),
                          details: _getPaymentDetails(index),
                        ),
                      );
                    },
                  ),
                ),
                const Divider(
                  color: Colors.grey,
                ),
                Container(
                  height: 150,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    color: Colors.white, // Garanta que a cor de fundo do container esteja definida
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text('R\$ 10,99',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        NavigationPrimaryButton(
                            route: 'order-details',
                            buttonText: 'Finalizar Compra',
                            buttonTextSize: 20),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentOption({
    required int value,
    required String label,
    required IconData icon,
    required String details,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.grey),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      details,
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Icon(Icons.arrow_forward_ios, color: Colors.green),
        ],
      ),
    );
  }

  String _getPaymentLabel(int index) {
    switch (index) {
      case 0:
        return 'Cartão de Crédito';
      case 1:
        return 'Cartão de Débito';
      case 2:
        return 'Vale Refeição';
      case 3:
        return 'Vale Alimentação';
      case 4:
        return 'Boleto Bancário';
      default:
        return '';
    }
  }

  IconData _getPaymentIcon(int index) {
    switch (index) {
      case 0:
        return Icons.credit_card;
      case 1:
        return Icons.credit_card; // Usando o mesmo ícone para cartão de crédito e débito
      case 2:
        return Icons.card_giftcard; // Exemplo de ícone para vale refeição
      case 3:
        return Icons.card_giftcard; // Usando o mesmo ícone para vale alimentação
      case 4:
        return Icons.picture_as_pdf; // Ícone para boleto bancário
      default:
        return Icons.payment;
    }
  }

  String _getPaymentDetails(int index) {
    switch (index) {
      case 0:
        return 'Pague com cartão de crédito.';
      case 1:
        return 'Pague com cartão de débito.';
      case 2:
        return 'Pague com vale refeição.';
      case 3:
        return 'Pague com vale alimentação.';
      case 4:
        return 'Pague com boleto bancário.';
      default:
        return '';
    }
  }
}
