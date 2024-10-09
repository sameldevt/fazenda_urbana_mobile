import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:verdeviva/common/constants.dart';
import 'package:verdeviva/providers/order_provider.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

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
          'Meus pedidos',
          style: TextStyle(
              fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
      ),
      body: const Padding(
        padding: EdgeInsets.all(appPadding),
        child: Column(
          children: [
            Align(alignment: Alignment.centerLeft, child: _Header()),
            Expanded(child: _OrderList()),
            //Center(child: _DoubtCard())
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
  const _OrderList();

  @override
  State<_OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<_OrderList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(builder: (context, orderProvider, child) {
      orderProvider.getAll();
      final orders = orderProvider.orders;

      return ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return _OrderCard(
                orderImage: 'https://rb.gy/2xfabn',
                //orderImage: order.items[0].productImage,
                date: order.orderDate!,
                orderNumber: order.id.toString(),
                status: order.status!,
                price: order.finalPrice!.toStringAsFixed(2));
          });
    });
  }
}

class _OrderCard extends StatelessWidget {
  final String orderImage;
  final String orderNumber;
  final String status;
  final String date;
  final String price;

  const _OrderCard(
      {required this.orderImage,
      required this.orderNumber,
      required this.status,
      required this.date,
      required this.price});

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
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, 'order-details');
        },
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
                        formatDate(date),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'R\$ $price',
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
                          orderImage,
                          fit: BoxFit.contain,
                          width: 100,
                          height: 100,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return Container(
                              width: 50,
                              height: 50,
                              color: Colors.transparent,
                              child: Image.asset('assets/sad-face.png'),
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
                            _convertOrderStatus(status),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: 200,
                              child: _converMessage(status),
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
      ),
    );
  }
}

class _DoubtCard extends StatelessWidget {
  const _DoubtCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white, // Cor de fundo do Card
      elevation: 1.0, // Altura da sombra
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0), // Bordas arredondadas
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          height: 120,
          width: 260,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'Dúvidas? WhatsApp:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const Text(
                '+55 (11) 98888-7777',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              Container(
                alignment: Alignment.center,
                height: 50,
                width: 220,
                decoration: BoxDecoration(
                  color: const Color(0xEE45DB4B),
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Colors.black),
                ),
                child: const Text(
                  'Mande uma mensagem!',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight:
                          FontWeight.bold), // Cor do texto para contraste
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
