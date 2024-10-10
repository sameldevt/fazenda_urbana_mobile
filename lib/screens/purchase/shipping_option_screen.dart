import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verdeviva/common/buttons.dart';
import 'package:verdeviva/common/constants.dart';
import 'package:verdeviva/model/order.dart';
import 'package:verdeviva/model/product.dart';
import 'package:verdeviva/providers/cart_provider.dart';
import 'package:verdeviva/providers/order_provider.dart';
import 'package:verdeviva/providers/user_provider.dart';
import 'package:verdeviva/screens/account/address_screen.dart';
import 'package:verdeviva/screens/account/create_or_modify_address_screen.dart';

class ShippingOptionScreen extends StatefulWidget {
  const ShippingOptionScreen({super.key});

  @override
  State<ShippingOptionScreen> createState() => _ShippingOptionScreenState();
}

class _ShippingOptionScreenState extends State<ShippingOptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, child) {
      final user = userProvider.user;
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
        body: user!.hasAddress()
            ? const Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(appPadding),
                      child: Column(
                        children: [
                          _Header(),
                          SizedBox(
                            height: 8,
                          ),
                          _ShippingOptions(),
                          _OrderInfo(),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : const _HasNoAddressScreen(),
      );
    });
  }
}
class _HasNoAddressScreen extends StatelessWidget {
  const _HasNoAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final verticalPadding = screenHeight * 0.05;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(appPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: verticalPadding,
            ),
            Container(
              child: Column(
                children: [
                  Image.asset(
                    'assets/missing.png',
                    height: 300,
                    width: 300,
                  ),
                  const Text(
                    textAlign: TextAlign.center,
                    "Parece que você não tem nenhum endereço de entrega cadastrado!",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: verticalPadding,
            ),
            InkWell(
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateAddressScreen(),
                  ),
                );

                if (result != null) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShippingOptionScreen(),
                    ),
                  );
                }
              },
              child: const ActionPrimaryButton(
                  buttonText: "Cadastrar endereço", buttonTextSize: 18),
            )
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, child) {
      final user = userProvider.user!;
      final address = user.addresses[0];

      return Column(
        children: [
          const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Envios',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                const Icon(
                  Icons.pin_drop_outlined,
                  color: Colors.grey,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  'Envio para ${address.street}, ${address.number}',
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                )
              ],
            ),
          ),
        ],
      );
    });
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

  double _getPrice(int index) {
    switch (index) {
      case 0:
        return 5.99;
      case 1:
        return 10.99;
      case 2:
        return 15.99;
      default:
        return 0;
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
    return Consumer<OrderProvider>(builder: (context, orderProvider, child) {
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
                  orderProvider.addShippingCost(_getPrice(index));
                });
              },
              child: _buildShippingOption(
                value: index + 1,
                label: _getLabel(index),
                price: 'R\$ ${_getPrice(index).toStringAsFixed(2)}',
                deliveryTime: _getDeliveryTime(index),
              ),
            );
          },
        ),
      );
    });
  }
}

class _OrderInfo extends StatefulWidget {
  const _OrderInfo();

  @override
  State<_OrderInfo> createState() => _OrderInfoState();
}

class _OrderInfoState extends State<_OrderInfo> {
  String calculateTotalPrice(Set<ProductToCart> products, Order order) {
    final shippingCost = order.shippingCost;

    double total =
        products.fold(0.0, (total, product) => total + product.totalPrice) +
            shippingCost;

    return total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(builder: (context, orderProvider, child) {
      final products = Provider.of<CartProvider>(context).products;
      final order = orderProvider.order!;

      return Container(
        height: 180,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Produtos (${products.length})',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                Text(
                  'R\$ ${products.fold(0.0, (total, product) => total + product.totalPrice).toStringAsFixed(2)}',
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
                  'R\$ ${order.shippingCost.toStringAsFixed(2)}',
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
                  'R\$ ${calculateTotalPrice(products, order)}',
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
    });
  }
}
