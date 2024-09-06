import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:verdeviva/common/buttons.dart';
import 'package:verdeviva/screens/market/widgets/product_card.dart';

class ProductInfoScreen extends StatefulWidget {
  const ProductInfoScreen({super.key});

  @override
  State<ProductInfoScreen> createState() => _ProductInfoScreenState();
}

class _ProductInfoScreenState extends State<ProductInfoScreen> {
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
          'Detalhes',
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
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
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _Header(),
                      SizedBox(
                        height: 8,
                      ),
                      _ProductPriceSection(),
                      SizedBox(
                        height: 8,
                      ),
                      _SelectQuantitySection(),
                      SizedBox(
                        height: 16,
                      ),
                      _Buttons(),
                      SizedBox(
                        height: 16,
                      ),
                      _SeeTooSection(),
                    ],
                  ),
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
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Banana',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Center(
          child: Image.network(
            'https://rb.gy/2xfabn',
            width: 300,
            height: 300,
            fit: BoxFit.scaleDown,
            errorBuilder: (BuildContext context, Object exception,
                StackTrace? stackTrace) {
              return Container(
                width: 300,
                height: 300,
                color: Colors.transparent,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ProductPriceSection extends StatelessWidget {
  const _ProductPriceSection();

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'R\$ 7,99',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'em 3x R\$ 2,66',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        )
      ],
    );
  }
}

class _SelectQuantitySection extends StatefulWidget {
  const _SelectQuantitySection();

  @override
  State<_SelectQuantitySection> createState() => _SelectQuantitySectionState();
}

class _SelectQuantitySectionState extends State<_SelectQuantitySection> {
  final List<int> _quantities = [
    100,
    200,
    300,
    400,
    500,
    600,
    700,
    800,
    900,
    1,
    2,
    3,
    4,
    5
  ];

  int _selectedQuantity = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(10.0),
              ),
            ),
            showDragHandle: true,
            builder: (BuildContext context) {
              return Container(
                height: 300,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Escolha uma opção',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Expanded(
                      child: ListView.separated(
                        itemCount: _quantities.length,
                        itemBuilder: (BuildContext context, int index) {
                          int value = _quantities[index];
                          return ListTile(
                            title: Center(
                              child: Text(
                                '${value.toString()} ${value < 100 ? 'kg' : 'g'}',
                                style: const TextStyle(fontSize: 16.0),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                _selectedQuantity = value;
                              });
                              Navigator.pop(context);
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider(
                            color: Colors.grey,
                            thickness: 0.5,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Quantidade: ${_selectedQuantity < 100 ? ' ${_selectedQuantity.toString()} kg' : ' ${_selectedQuantity.toString()} g'}',
              style: const TextStyle(color: Colors.grey),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.lightGreen),
          ],
        ),
      ),
    );
  }
}

class _Buttons extends StatefulWidget {
  const _Buttons();

  @override
  State<_Buttons> createState() => _ButtonsState();
}

class _ButtonsState extends State<_Buttons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, 'cart');
            },
            child: const ActionPrimaryButton(
              buttonText: 'Comprar agora',
              buttonTextSize: 20,
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Center(
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(10.0),
                  ),
                ),
                showDragHandle: true,
                builder: (BuildContext context) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      height: 220,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  // Define a borda circular
                                  border: Border.all(
                                    color: Colors.green, // Cor da borda
                                    width: 3.0, // Largura da borda
                                  ),
                                ),
                                child: ClipOval(
                                  child: Image.network(
                                    'https://rb.gy/2xfabn',
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                    errorBuilder: (BuildContext context,
                                        Object exception,
                                        StackTrace? stackTrace) {
                                      return Container(
                                        width: 100,
                                        height: 100,
                                        color: Colors.transparent,
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              const SizedBox(
                                width: 200,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Item adicionado!',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Banana',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      overflow: TextOverflow.ellipsis,
                                      'Banana madura e doce, ideal para lanches e smoothies.',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      'R\$ 1,99',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Center(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, 'cart');
                                  },
                                  child: const ActionPrimaryButton(
                                    buttonText: 'Ir para o carrinho',
                                    buttonTextSize: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Center(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const ActionSecondaryButton(
                                    buttonText: 'Continuar comprando',
                                    buttonTextSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: const ActionSecondaryButton(
              buttonText: 'Adicionar ao carrinho',
              buttonTextSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}

class _SeeTooSection extends StatefulWidget {
  const _SeeTooSection();

  @override
  State<_SeeTooSection> createState() => _SeeTooSectionState();
}

class _SeeTooSectionState extends State<_SeeTooSection> {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Veja também',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        CarouselSlider(
          options: CarouselOptions(
            height: 240,
            viewportFraction: 0.6,
            enlargeCenterPage: true,
            enableInfiniteScroll: true,
            initialPage: 0,
            animateToClosest: true,
            scrollDirection: Axis.horizontal,
          ),
          items: products.map((product) {
            return Builder(
              builder: (BuildContext context) {
                return ProductCard(
                  name: product['name']!,
                  description: product['description']!,
                  price: product['price']!,
                  image: product['image']!,
                );
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
