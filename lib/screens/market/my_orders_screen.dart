import 'package:flutter/material.dart';
import 'package:verdeviva/common/custom_widgets.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appBarColor = theme.colorScheme.primary;
    final background = theme.colorScheme.surface;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: const Text(
          'Meus pedidos',
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 30,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Produtos',style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
            Expanded(child: _OrderList()),
            Center(child: _DoubtCard())
          ],
        ),
      ),
    );
  }
}

class _OrderList extends StatefulWidget {
  const _OrderList({super.key});

  @override
  State<_OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<_OrderList> {
  final List<Map<String, String>> orders = [
    {
      "order": "654321",
      "status": "Entregue",
      "date": "23/05/2024",
      "price": "R\$ 23,99",
    },
    {
      "order": "123456",
      "status": "Em transito",
      "date": "23/05/2024",
      "price": "R\$ 33,99",
    },
    {
      "order": "321456",
      "status": "Cancelado",
      "date": "23/05/2024",
      "price": "R\$ 13,99",
    },
    {
      "order": "654321",
      "status": "Entregue",
      "date": "23/05/2024",
      "price": "R\$ 23,99",
    },
    {
      "order": "123456",
      "status": "Em transito",
      "date": "23/05/2024",
      "price": "R\$ 33,99",
    },
    {
      "order": "321456",
      "status": "Cancelado",
      "date": "23/05/2024",
      "price": "R\$ 13,99",
    },
    {
      "order": "654321",
      "status": "Entregue",
      "date": "23/05/2024",
      "price": "R\$ 23,99",
    },
    {
      "order": "123456",
      "status": "Em transito",
      "date": "23/05/2024",
      "price": "R\$ 33,99",
    },
    {
      "order": "321456",
      "status": "Cancelado",
      "date": "23/05/2024",
      "price": "R\$ 13,99",
    },
    {
      "order": "654321",
      "status": "Entregue",
      "date": "23/05/2024",
      "price": "R\$ 23,99",
    },
    {
      "order": "123456",
      "status": "Em transito",
      "date": "23/05/2024",
      "price": "R\$ 33,99",
    },
    {
      "order": "321456",
      "status": "Cancelado",
      "date": "23/05/2024",
      "price": "R\$ 13,99",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return _OrderCard(
            date: order['date']!,
            orderNumber: order['order']!,
            status: order['status']!,
            price: order['price']!);
      },
    );
  }
}

class _OrderCard extends StatelessWidget {
  final String orderNumber;
  final String status;
  final String date;
  final String price;

  const _OrderCard(
      {super.key,
      required this.orderNumber,
      required this.status,
      required this.date,
      required this.price});

  Icon _getIconForStatus(String status) {
    IconData iconData;
    Color color;

    switch (status) {
      case 'Em transito':
        iconData = Icons.access_time;
        color = Colors.black;
        break;
      case 'Entregue':
        iconData = Icons.check;
        color = Colors.green;
        break;
      case 'Cancelado':
        iconData = Icons.cancel_outlined;
        color = Colors.red;
        break;
      default:
        iconData = Icons.help;
        color = Colors.grey;
    }

    return Icon(
      iconData,
      color: color,
      size: 60,
    );
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
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Container(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  child: _getIconForStatus(status),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Pedido',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(orderNumber),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Status',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(status),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Data',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(date),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Valor',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(price),
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

class _DoubtCard extends StatelessWidget {
  const _DoubtCard({super.key});

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
          height: 150,
          width: 260,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Dúvidas? WhatsApp:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              Text(
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
                child: Text(
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
