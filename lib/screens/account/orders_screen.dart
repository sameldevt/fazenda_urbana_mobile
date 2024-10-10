import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:verdeviva/common/buttons.dart';
import 'package:verdeviva/common/constants.dart';
import 'package:verdeviva/model/order.dart';
import 'package:verdeviva/providers/order_provider.dart';
import 'package:verdeviva/providers/user_provider.dart';
import 'package:verdeviva/screens/account/order_details_screen.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.getOrders(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appBarColor = theme.colorScheme.primary;
    final background = theme.colorScheme.surface;

    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        final orders = userProvider.orders;

        return Scaffold(
          backgroundColor: background,
          appBar: AppBar(
            backgroundColor: appBarColor,
            title: const Text(
              'Meus pedidos',
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            iconTheme: const IconThemeData(color: Colors.white, size: 30),
          ),
          body: Padding(
            padding: EdgeInsets.all(appPadding),
            child: orders == null || orders.isEmpty
                ? _NoOrdersScreen()
                : Column(
              children: [
                Align(alignment: Alignment.centerLeft, child: _Header()),
                Expanded(
                  child: _OrderList(
                    orders: orders,
                  ),
                ),
                //Center(child: _DoubtCard())
              ],
            ),
          ),
        );
      },
    );
  }
}


class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Pedidos',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _OrderList extends StatefulWidget {
  final List<Order> orders;

  const _OrderList({required this.orders});

  @override
  State<_OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<_OrderList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.orders.length,
        itemBuilder: (context, index) {
          final order = widget.orders[index];
          return _OrderCard(order: order);
        });
  }
}

class _NoOrdersScreen extends StatefulWidget {
  const _NoOrdersScreen({super.key});

  @override
  State<_NoOrdersScreen> createState() => _NoOrdersScreenState();
}

class _NoOrdersScreenState extends State<_NoOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final verticalPadding = screenHeight * 0.08;

    return Padding(
      padding: const EdgeInsets.all(appPadding),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: verticalPadding),
        child: Column(
          children: [
            Image.asset(
              'assets/item-not-found.png',
              height: 400,
              width: 400,
            ),
            const Text(
              "Você não tem pedidos!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 37,),
            InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, 'home');
              },
              child: const ActionPrimaryButton(
                  buttonText: "Buscar produtos", buttonTextSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final Order order;

  const _OrderCard({
    required this.order,
  });

  Text _convertOrderStatus(String orderStatus) {
    String? text;
    Color? color;

    switch (orderStatus) {
      case 'ENTREGUE':
        text = 'Entregue';
        color = Colors.green;
        break;
      case 'EM_TRANSITO':
        text = 'Em transito';
        color = Colors.grey;
        break;
      case 'PAGO':
        text = 'Pago';
        color = Colors.yellow;
        break;
      case 'AGUARDANDO_PAGAMENTO':
        text = 'Pendente';
        color = Colors.grey;
      case 'CANCELADO':
        text = 'Cancelado';
        color = Colors.red;
    }

    return Text(
      text!,
      style:
          TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color!),
    );
  }

  Text _converMessage(status) {
    String? text;

    switch (status) {
      case 'ENTREGUE':
        text = 'Pedido entregue.';
        break;
      case 'EM_TRANSITO':
        text = 'Seu pedido está em transito.';
        break;
      case 'PAGO':
        text = 'Seu pedido foi pago e logo será enviado.';
        break;
      case 'AGUARDANDO_PAGAMENTO':
        text = 'Estamos aguardando o pagamento do pedido.';
      case 'CANCELADO':
        text = 'Este pedido foi cancelado';
    }

    return Text(
      text!,
      softWrap: true,
      maxLines: 2,
      style: const TextStyle(
          fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
    );
  }

  String formatDate(String isoString) {
    DateTime date = DateTime.parse(isoString);
    String formattedDate = DateFormat('MMMM d, yyyy').format(date);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        color: Colors.white,
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: SizedBox(
          height: 165,
          child: Padding(
            padding: const EdgeInsets.all(appPadding),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formatDate(order.orderDate!),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'R\$ ${order.finalPrice!.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.green),
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.grey,
                  thickness: 0.5,
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.network(
                        order.items.first.productImage,
                        fit: BoxFit.contain,
                        width: 100,
                        height: 100,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return Container(
                            width: 100,
                            height: 100,
                            color: Colors.white,
                            //child: Image.asset('assets/.png', fit: BoxFit.contain,),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _convertOrderStatus(order.status!),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 200,
                            child: _converMessage(order.status!),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}