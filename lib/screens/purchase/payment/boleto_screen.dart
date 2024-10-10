import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:verdeviva/common/buttons.dart';
import 'package:verdeviva/common/constants.dart';
import 'package:verdeviva/model/order.dart';
import 'package:verdeviva/model/product.dart';
import 'package:verdeviva/providers/cart_provider.dart';
import 'package:verdeviva/providers/order_provider.dart';
import 'package:verdeviva/screens/account/orders_screen.dart';

class BoletoScreen extends StatefulWidget {
  const BoletoScreen({super.key});

  @override
  State<BoletoScreen> createState() => _BoletoScreenState();
}

class _BoletoScreenState extends State<BoletoScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appBarColor = theme.colorScheme.primary;
    final background = theme.colorScheme.surface;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: const Text(
          'Pedido aguardando pagamento',
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
                            _BarCodeSection(),
                            SizedBox(
                              height: 32,
                            ),
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

class _BarCodeSection extends StatelessWidget {
  final String boletoCode = '82736491028374659120384756';

  const _BarCodeSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Image.asset('assets/purchase.png'),
        ),
        const SizedBox(
          height: 30,
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              textAlign: TextAlign.center,
              'Escaneie ou copie o código de barras abaixo para finalizar seu pagamento',
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Column(
          children: [
            Image.asset('assets/codigo-barras.png'),
            Text(
              boletoCode,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
        const SizedBox(
          height: 16.0,
        ),
        InkWell(
          onTap: () {
            Clipboard.setData(ClipboardData(text: boletoCode));
          },
          child: const ActionPrimaryButton(
              buttonText: 'Copiar código de barras', buttonTextSize: 20),
        ),
        const SizedBox(
          height: 30,
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
