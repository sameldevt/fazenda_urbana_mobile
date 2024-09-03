import 'package:flutter/material.dart';
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
      style: TextStyle(fontSize: 16, color: Colors.grey),
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
        title: Text('Informações do pedido'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.only(right: 8),
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
            Expanded(child: _CartList()),
            Center(child: _DoubtCard())
          ],
        ),
      ),
    );
  }
}

class _MoreInfoDialog extends StatelessWidget {
  const _MoreInfoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Overlay();
  }
}

class _OrderDetailsSection extends StatelessWidget {
  const _OrderDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16.0, // Espaçamento horizontal entre os elementos
      runSpacing: 8.0, // Espaçamento vertical entre as linhas
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // Alinha os textos à esquerda
            children: [
              Text('Data do pedido'),
              Text('23/05/2024 18:37'),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Forma de pagamento'),
              Text('Crédito em 2x sem juros'),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Endereço de entrega'),
              Text(
                'Rua das Flores, 100, apto 31, CEP 01010-010 São Paulo, SP',
                maxLines: 2, // Limita o número de linhas
                overflow: TextOverflow
                    .ellipsis, // Adiciona reticências se o texto ultrapassar o limite
              ),
            ],
          ),
        ),
      ],
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
  const _CartList({super.key});

  @override
  State<_CartList> createState() => _CartListState();
}

class _CartListState extends State<_CartList> {
  final List<Map<String, String>> products = [
    {
      "name": "Banana",
      "price": "7.99",
      "image": "https://rb.gy/2xfabn",
      "description": "Banana madura e doce, ideal para lanches e smoothies."
    },
    {
      "name": "Maçã",
      "price": "6.49",
      "image": "https://rb.gy/8ly4oc",
      "description":
          "Maçã crocante e suculenta, perfeita para uma alimentação saudável."
    },
    {
      "name": "Couve",
      "price": "5.99",
      "image": "https://rb.gy/s2fpd2",
      "description":
          "Couve fresca, rica em nutrientes e ideal para sucos verdes."
    },
    {
      "name": "Cenoura",
      "price": "4.99",
      "image": "https://rb.gy/0fiy0z",
      "description":
          "Cenoura crocante e adocicada, ótima para saladas e petiscos."
    },
    {
      "name": "Batata",
      "price": "3.99",
      "image": "https://rb.gy/2ot2ch",
      "description": "Batata versátil, ideal para fritar, assar ou cozinhar."
    },
    {
      "name": "Batata doce",
      "price": "4.49",
      "image": "https://t.ly/obCYL",
      "description":
          "Batata doce nutritiva e adocicada, excelente para receitas saudáveis."
    },
    {
      "name": "Beterraba",
      "price": "5.49",
      "image": "https://t.ly/-YCSe",
      "description": "Beterraba rica em ferro, ótima para saladas e sucos."
    },
    {
      "name": "Manga",
      "price": "6.99",
      "image": "https://t.ly/WGNKn",
      "description": "Manga suculenta e doce, perfeita para sobremesas e sucos."
    },
    {
      "name": "Alface",
      "price": "4.49",
      "image": "https://t.ly/kGI0v",
      "description": "Alface fresca e crocante, ideal para saladas."
    },
    {
      "name": "Pêra",
      "price": "7.49",
      "image": "https://t.ly/QM99N",
      "description": "Pêra doce e suculenta, ótima para lanches e sobremesas."
    },
    {
      "name": "Laranja",
      "price": "5.99",
      "image": "https://l1nq.com/nmBNt",
      "description":
          "Laranja refrescante e rica em vitamina C, perfeita para sucos."
    },
    {
      "name": "Alho",
      "price": "1.99",
      "image": "https://l1nq.com/7cqrk",
      "description":
          "Alho aromático e saboroso, essencial para temperar pratos."
    },
    {
      "name": "Cebola",
      "price": "6,49",
      "image": "https://l1nq.com/f4Mkz",
      "description":
          "Cebola versátil e essencial na cozinha, ideal para diversos pratos."
    },
    {
      "name": "Tomate",
      "price": "7.49",
      "image": "https://encurtador.com.br/kAgBR",
      "description":
          "Tomate maduro e suculento, excelente para saladas e molhos."
    },
    {
      "name": "Salsa",
      "price": "3.99",
      "image": "https://encurtador.com.br/LbyRY",
      "description":
          "Salsa fresca e aromática, ideal para temperar e enfeitar pratos."
    }
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return _CartItem(
          productCard: ProductCard(
            name: product['name']!,
            description: product['description']!,
            price: product['price']!,
            image: product['image']!,
          ),
        );
      },
    );
  }
}

class _CartItem extends StatefulWidget {
  final ProductCard productCard;

  const _CartItem({super.key, required this.productCard});

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
              widget.productCard.image,
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
                  widget.productCard.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'R\$ ${widget.productCard.price} / kg',
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
                  'R\$ ${(widget.productCard.price * 1)}',
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
  const _SubTotalSection({super.key});

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
