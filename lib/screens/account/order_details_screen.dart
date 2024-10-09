import 'package:flutter/material.dart';
import 'package:verdeviva/common/constants.dart';
import 'package:verdeviva/model/product.dart';
import 'package:verdeviva/screens/market/widgets/product_card.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
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
      size: 40,
    );
  }

  Text _getDescriptionForStatus(String status) {
    String description = '';
    switch (status) {
      case 'Em transito':
        description = 'Em trânsito. Será entregue até 24/05/2024 às 18:37.';
        break;
      case 'Entregue':
        description = 'Pedido entregue! Aproveite seus produtos.';
        break;
      case 'Cancelado':
        description = 'Pedido cancelado..';
        break;
    }

    return Text(
      textAlign: TextAlign.center,
      description,
      style: const TextStyle(fontSize: 16, color: Colors.grey),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        title: const Text('Informações do pedido'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(appPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: _getIconForStatus('Em transito')),
                  const Text(
                    'Pedido 0104937',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: _getDescriptionForStatus('Em transito'),
            ),
            const Expanded(child: _CartList()),
            const Center(child: _DoubtCard())
          ],
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
          height: 150,
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
              InkWell(
                onTap: () {},
                child: Container(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CartList extends StatefulWidget {
  const _CartList();

  @override
  State<_CartList> createState() => _CartListState();
}

class _CartListState extends State<_CartList> {
  final List<Product> products = [];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return _CartItem(
          product: product
        );
      },
    );
  }
}

class _CartItem extends StatefulWidget {
  final Product product;

  const _CartItem({required this.product});

  @override
  State<_CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<_CartItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Imagem do produto
          SizedBox(
            width: 100,
            height: 100,
            child: Image.network(
              widget.product.imageUrl,
              fit: BoxFit.scaleDown,
            ),
          ),
          // Coluna do nome e preço do produto
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.product.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'R\$ ${widget.product.pricePerKilo} / kg',
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                ),
              ],
            ),
          ),
          // Coluna da quantidade
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Quantidade (kg)',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: const Text(
                    '1,5',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          // Coluna do valor
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Valor',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'R\$ ${(widget.product.pricePerKilo * 1)}',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SubTotalSection extends StatefulWidget {
  const _SubTotalSection();

  @override
  State<_SubTotalSection> createState() => _SubTotalSectionState();
}

class _SubTotalSectionState extends State<_SubTotalSection> {
  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Valor total da compra',
              style: TextStyle(
                fontSize: 16,
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
      ),
    );
  }
}
