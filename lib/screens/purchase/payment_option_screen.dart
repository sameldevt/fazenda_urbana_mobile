import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verdeviva/common/constants.dart';
import 'package:verdeviva/model/order.dart';
import 'package:verdeviva/model/product.dart';
import 'package:verdeviva/providers/cart_provider.dart';
import 'package:verdeviva/providers/order_provider.dart';
import 'package:verdeviva/screens/purchase/card_option_screen.dart';
import 'package:verdeviva/screens/purchase/payment/card_screen.dart';
import 'package:verdeviva/screens/purchase/purchase_sumary_screen.dart';

class PaymentOptionScreen extends StatefulWidget {
  const PaymentOptionScreen({super.key});

  @override
  State<PaymentOptionScreen> createState() => _PaymentOptionScreenState();
}

class _PaymentOptionScreenState extends State<PaymentOptionScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appBarColor = theme.colorScheme.primary;
    final background = theme.colorScheme.surface;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: const Text(
          'Escolha como pagar',
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
                    _PaymentOptions(),
                    _OrderInfo()
                  ],
                ),
              ),
            ),
          ),
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
            'Métodos de Pagamento',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Escolha o método de pagamento',
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}

class _PaymentOptions extends StatelessWidget {
  const _PaymentOptions();

  Widget _buildPaymentOption({
    required int value,
    required String label,
    required IconData icon,
    required String details,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.grey),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 20),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    details,
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ],
        ),
        const Icon(Icons.arrow_forward_ios, color: Colors.green),
      ],
    );
  }

  String _getPaymentLabel(int index) {
    switch (index) {
      case 0:
        return 'Boleto Bancário';
      case 1:
        return 'Pix';
      default:
        return '';
    }
  }

  IconData _getPaymentIcon(int index) {
    switch (index) {
      case 0:
        return Icons.picture_as_pdf;
      case 1:
        return Icons.pix;
      default:
        return Icons.payment;
    }
  }

  String _getPaymentDetails(int index) {
    switch (index) {
      case 0:
        return 'Pague com boleto bancário.';
      case 1:
        return 'Com desconto de 8%.';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, orderProvider, child) {
        return Expanded(
          child: ListView.separated(
            separatorBuilder: (context, index) => const Divider(
              color: Colors.grey,
              thickness: 0.5,
              indent: 10.0,
              endIndent: 10.0,
            ),
            itemCount: 2,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Widget screen;

                  switch (index) {
                    case 0:
                      screen = const PurchaseSummaryScreen();
                      orderProvider.addPaymentMethod('boleto');
                      break;
                    case 1:
                      screen = const PurchaseSummaryScreen();
                      orderProvider.addPaymentMethod('pix');
                      break;
                    default:
                      screen = const CardScreen();
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => screen),
                  );
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
        );
      }
    );
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
        height: 100,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
          ],
        ),
      );
    });
  }
}

