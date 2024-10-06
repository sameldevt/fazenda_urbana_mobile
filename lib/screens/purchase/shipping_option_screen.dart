import 'package:flutter/material.dart';
import 'package:verdeviva/common/buttons.dart';
import 'package:verdeviva/common/constants.dart';
import 'package:verdeviva/model/user.dart';
import 'package:verdeviva/service/user_service.dart';

class ShippingOptionScreen extends StatefulWidget {
  const ShippingOptionScreen({super.key});

  @override
  State<ShippingOptionScreen> createState() => _ShippingOptionScreenState();
}

class _ShippingOptionScreenState extends State<ShippingOptionScreen> {
  User? user;
  void loadUser() async {
    final userData = await User.fromSharedPreferences();
    setState(() {
      user = userData;
    });
  }

  @override
  void initState() {
    loadUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appBarColor = theme.colorScheme.primary;
    final background = theme.colorScheme.surface;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: const Text(
          'Escolha como receber',
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 30,
        ),
      ),
      backgroundColor: background,
      body: user!.hasAddress() ? Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(appPadding),
              child: Column(
                children: [
                  _Header(),
                  SizedBox(height: 8,),
                  _ShippingOptions(),
                  _OrderInfo(),
                ],
              ),
            ),
          ),
        ],
      ) : _HasNoAddressScreen(),
    );
  }
}

class _HasNoAddressScreen extends StatelessWidget {
  const _HasNoAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final verticalPadding = screenHeight * 0.05; // 5% do tamanho da altura
    final theme = Theme.of(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(appPadding),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: verticalPadding,
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/something-wrong.png',
                      height: 300,
                      width: 300,
                    ),
                    const Text(
                      textAlign: TextAlign.center,
                      "Parece que você não tem nenhum endereço de entrega cadastrado!",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20,),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, 'create-address');
                      },
                      child: const ActionPrimaryButton(
                          buttonText: "Cadastrar endereço", buttonTextSize: 18),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: verticalPadding,
              ),
            ],
          ),
        ),
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
              'Envios',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
        Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Icon(
                Icons.pin_drop_outlined,
                color: Colors.grey,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                'Envio para rua São Paulo, 95',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _ShippingOptions extends StatefulWidget {
  const _ShippingOptions();

  @override
  State<_ShippingOptions> createState() => _ShippingOptionsState();
}

class _ShippingOptionsState extends State<_ShippingOptions> {
  int? _selectedValue;

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
                    style: const TextStyle(fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Text(
                      price,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
              Text(
                deliveryTime,
                style: const TextStyle(fontSize: 12),
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

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => const Divider(
          color: Colors.grey,
          thickness: 0.5,
        ),
        itemCount: 3,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                _selectedValue = index + 1;
              });
            },
            child: _buildShippingOption(
              value: index + 1,
              label: _getLabel(index),
              price: _getPrice(index),
              deliveryTime: _getDeliveryTime(index),
            ),
          );
        },
      ),
    );
  }
}

class _OrderInfo extends StatelessWidget {
  const _OrderInfo();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
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
          Padding(
            padding: EdgeInsets.only(top: 4.0),
            child: Center(
              child: NavigationPrimaryButton(
                  route: 'payment',
                  buttonText: 'Continuar a compra',
                  buttonTextSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
