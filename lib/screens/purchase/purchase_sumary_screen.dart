import 'package:flutter/material.dart';
import 'package:verdeviva/common/buttons.dart';
import 'package:verdeviva/screens/market/widgets/product_card.dart';
import 'package:verdeviva/screens/purchase/payment/boleto_screen.dart';
import 'package:verdeviva/screens/purchase/payment/card_screen.dart';
import 'package:verdeviva/screens/purchase/payment/pix_screen.dart';

class PurchaseSummaryScreen extends StatelessWidget {
  final String paymentMethod;

  const PurchaseSummaryScreen({super.key, required this.paymentMethod});

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
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const _Header(),
                    const SizedBox(
                      height: 8,
                    ),
                    _SummaryItemsSection(),
                    _ConfirmPurchaseSection(
                      paymentMethod: paymentMethod,
                    ),
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
  final List<Map<String, String>> items = [
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

  _SummaryItemsSection();

  @override
  Widget build(BuildContext context) {
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
                  return _SummaryItemCard(
                    productCard: ProductCard(
                      name: product['name']!,
                      description: product['description']!,
                      price: product['price']!,
                      image: product['image']!,
                    ),
                  );
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
  }
}

class _SummaryItemCard extends StatefulWidget {
  final ProductCard productCard;

  const _SummaryItemCard({required this.productCard});

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
            widget.productCard.image,
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
                    widget.productCard.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  const Column(
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
                        '1 kg',
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
                  'R\$ ${widget.productCard.price} / kg',
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
  final String paymentMethod;

  const _ConfirmPurchaseSection({required this.paymentMethod});

  @override
  State<_ConfirmPurchaseSection> createState() =>
      _ConfirmPurchaseSectionState();
}

class _ConfirmPurchaseSectionState extends State<_ConfirmPurchaseSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Forma de pagamento: '),
              Text(() {
                switch (widget.paymentMethod) {
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
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Produtos (2)',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              Text(
                'R\$ 18,99',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Frete',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              Text(
                'R\$ 2,99',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const Row(
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
                'R\$ 18,99',
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

                    switch (widget.paymentMethod) {
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

                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => screen),
                      (Route<dynamic> route) => false,
                    );
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
  }
}
