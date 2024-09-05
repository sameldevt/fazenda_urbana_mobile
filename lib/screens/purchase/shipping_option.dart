import 'package:flutter/material.dart';
import 'package:verdeviva/common/buttons.dart';

class ShippingOptionScreen extends StatefulWidget {
  const ShippingOptionScreen({super.key});

  @override
  State<ShippingOptionScreen> createState() => _ShippingOptionScreenState();
}

class _ShippingOptionScreenState extends State<ShippingOptionScreen> {
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
          'Escolha uma opção de entrega',
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
                        'Envios',
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
                          Icon(Icons.pin_drop_outlined, color: Colors.grey,),
                          SizedBox(width: 8,),
                          Text(
                            'Envio para rua São Paulo, 95',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold,color: Colors.grey),
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
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return _buildShippingOption(
                        value: index + 1,
                        label: _getLabel(index),
                        price: _getPrice(index),
                        deliveryTime: _getDeliveryTime(index),
                      );
                    },
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    color: Colors
                        .white, // Garanta que a cor de fundo do container esteja definida
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Frete',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text('R\$ 10,99',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        NavigationPrimaryButton(
                            route: 'payment',
                            buttonText: 'Continuar',
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

  Widget _buildShippingOption({
    required int value,
    required String label,
    required String price,
    required String deliveryTime,
  }) {
    return Row(
      children: [
        Radio<int>(
          value: value,
          groupValue: _selectedValue,
          onChanged: (int? newValue) {
            setState(() {
              _selectedValue = newValue;
            });
          },
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label,
                    style: TextStyle(fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      price,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  deliveryTime,
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getLabel(int index) {
    switch (index) {
      case 0:
        return 'Envio normal';
      case 1:
        return 'Envio expresso';
      case 2:
        return 'Envio turbo';
      default:
        return '';
    }
  }

  String _getPrice(int index) {
    switch (index) {
      case 0:
        return 'R\$ 5,99';
      case 1:
        return 'R\$ 10,99';
      case 2:
        return 'R\$ 15,99';
      default:
        return '';
    }
  }

  String _getDeliveryTime(int index) {
    switch (index) {
      case 0:
        return 'Entrega em até 1 semana';
      case 1:
        return 'Entrega em até 3 dias';
      case 2:
        return 'Entrega em 1 dia';
      default:
        return '';
    }
  }
}
