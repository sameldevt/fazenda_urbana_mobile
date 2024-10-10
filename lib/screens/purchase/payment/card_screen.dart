import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verdeviva/common/buttons.dart';
import 'package:verdeviva/common/constants.dart';
import 'package:verdeviva/model/order.dart';
import 'package:verdeviva/model/product.dart';
import 'package:verdeviva/providers/cart_provider.dart';
import 'package:verdeviva/providers/order_provider.dart';
import 'package:verdeviva/screens/account/orders_screen.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appBarColor = theme.colorScheme.primary;
    final background = theme.colorScheme.surface;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: const Text(
          'Pedido confirmado',
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 30,
        ),
        centerTitle: true,
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
              child: const Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(appPadding),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            _Header(),
                            SizedBox(
                              height: 32,
                            ),
                            _OkSection(),
                            _OrderInfo(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
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
    return const Center(
      child: Text(
        textAlign: TextAlign.center,
        'Pedido realizado com sucesso!',
        style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _OkSection extends StatelessWidget {
  const _OkSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Image.asset('assets/purchase.png'),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              textAlign: TextAlign.center,
              'Seu pedido foi realizado com sucesso! Assim que o pagamento for confirmado, seu pedido será imediatamente processado e enviado. Se tiver alguma dúvida ou precisar de mais informações, estamos à disposição para ajudar.',
              style: TextStyle(color: Colors.grey, fontSize: 14),
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
    String calculateTotalPrice(Set<ProductToCart> products, Order order) {
      final shippingCost = order.shippingCost;

      double total =
          products.fold(0.0, (total, product) => total + product.totalPrice) +
              shippingCost;

      return total.toStringAsFixed(2);
    }

    String calculateTotalItemsPrice(Set<ProductToCart> products) {
      double total =
      products.fold(0.0, (total, product) => total + product.totalPrice);
      return total.toStringAsFixed(2);
    }

    return Consumer<OrderProvider>(
        builder: (context, orderProvider, child){
          final cartProvider = Provider.of<CartProvider>(context);
          final products = cartProvider.products;
          final order = orderProvider.order!;

          return Container(
            height: 250,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Resumo do pedido',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Produtos (${order.items.length})',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'R\$ ${calculateTotalItemsPrice(products)}',
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
                      'R\$ ${order.shippingCost}',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
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
                InkWell(
                  onTap: () {
                    cartProvider.clearCart();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OrdersScreen(),
                      ),
                    );
                  },
                  child: const ActionPrimaryButton(
                    buttonText: 'Ver pedidos',
                    buttonTextSize: 20,
                  ),
                ),
                InkWell(
                  onTap: (){
                    cartProvider.clearCart();
                    Navigator.pushReplacementNamed(context, 'home');
                  },
                  child: const ActionSecondaryButton(
                      buttonText: 'Voltar ao início',
                      buttonTextSize: 18),
                ),
              ],
            ),
          );
        }
    );
  }
}
