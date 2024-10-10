import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verdeviva/common/buttons.dart';
import 'package:verdeviva/common/constants.dart';
import 'package:verdeviva/model/order.dart';
import 'package:verdeviva/model/product.dart';
import 'package:verdeviva/providers/cart_provider.dart';
import 'package:verdeviva/providers/order_provider.dart';
import 'package:verdeviva/screens/market/widgets/product_card.dart';
import 'package:verdeviva/screens/purchase/payment/boleto_screen.dart';
import 'package:verdeviva/screens/purchase/payment/card_screen.dart';
import 'package:verdeviva/screens/purchase/payment/pix_screen.dart';

class PurchaseSummaryScreen extends StatelessWidget {
  const PurchaseSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appBarColor = theme.colorScheme.primary;
    final background = theme.colorScheme.surface;

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: const Text(
          'Resumo do pedido',
          style: TextStyle(
              fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
      ),
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
              child: Padding(
                padding: const EdgeInsets.all(appPadding),
                child: Column(
                  children: [
                    const _Header(),
                    const SizedBox(
                      height: 8,
                    ),
                    _SummaryItemsSection(),
                    _ConfirmPurchaseSection(),
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
    return const Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'Produtos',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _SummaryItemsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(builder: (context, cartProvider, child) {
      final items = cartProvider.products.toList();

      return SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.60,
                child: ListView.separated(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final product = items[index];
                    return _SummaryItemCard(product: product);
                  },
                  separatorBuilder: (context, index) => const Divider(
                    color: Colors.grey,
                    thickness: 0.5,
                    indent: 10.0,
                    endIndent: 10.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _SummaryItemCard extends StatefulWidget {
  final ProductToCart product;

  const _SummaryItemCard({required this.product});

  @override
  State<_SummaryItemCard> createState() => _SummaryItemCardState();
}

class _SummaryItemCardState extends State<_SummaryItemCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            widget.product.imageUrl,
            width: 100,
            height: 100,
            fit: BoxFit.scaleDown,
            errorBuilder: (BuildContext context, Object exception,
                StackTrace? stackTrace) {
              return Container(
                width: 100,
                height: 100,
                color: Colors.transparent,
              );
            },
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Quantidade',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${widget.product.quantity > 5 ? '${widget.product.quantity} g' : '${widget.product.quantity} kg'}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'R\$ ${widget.product.totalPrice.toStringAsFixed(2)} ',
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                  overflow: TextOverflow.ellipsis, // Evita overflow de texto
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ConfirmPurchaseSection extends StatefulWidget {
  const _ConfirmPurchaseSection();

  @override
  State<_ConfirmPurchaseSection> createState() =>
      _ConfirmPurchaseSectionState();
}

class _ConfirmPurchaseSectionState extends State<_ConfirmPurchaseSection> {
  String calculateTotalPrice(Set<ProductToCart> products, Order order) {
    final shippingCost = order.shippingCost;

    double total =
        products.fold(0.0, (total, product) => total + product.totalPrice) +
            shippingCost;
    order.finalPrice = total;

    return total.toStringAsFixed(2);
  }

  String calculateTotalItemsPrice(Set<ProductToCart> products) {
    double total =
        products.fold(0.0, (total, product) => total + product.totalPrice);
    return total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(builder: (context, orderProvider, child) {
      final cartProvider = Provider.of<CartProvider>(context);
      final orderProducts = cartProvider.products;
      final order = orderProvider.order!;

      return Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Forma de pagamento: '),
                Text(() {
                  switch (order.paymentMethod) {
                    case 'card':
                      return 'Cartão';
                    case 'pix':
                      return 'Pix';
                    case 'boleto':
                      return 'Boleto';
                    default:
                      return '';
                  }
                }()),
              ],
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
                  'R\$ ${calculateTotalItemsPrice(orderProducts)}',
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
                Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'R\$ ${calculateTotalPrice(orderProducts, order)}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Center(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      Widget screen;

                      switch (order.paymentMethod) {
                        case 'card':
                          screen = const CardScreen();
                          break;
                        case 'boleto':
                          screen = const BoletoScreen();
                          break;
                        case 'pix':
                          screen = const PixScreen();
                          break;
                        default:
                          screen = const Scaffold();
                      }

                      orderProvider.confirmOrder().then((value) {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => screen),
                          (Route<dynamic> route) => false,
                        );
                      });
                    });
                  },
                  child: const ActionPrimaryButton(
                    buttonText: 'Confirmar pedido',
                    buttonTextSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
