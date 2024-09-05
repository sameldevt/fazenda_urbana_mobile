import 'package:flutter/material.dart';
import 'package:verdeviva/common/sections.dart';
import 'package:verdeviva/main.dart';
import 'package:verdeviva/screens/market/widgets/product_card.dart';

final double _cardWidth = 170.0;
final double _cardHeight = 150.0;
const double _cardElevation = 10.0;

class ShopCard extends StatelessWidget {
  final String name;
  final String description;
  final String price;
  final String image;

  const ShopCard({
    super.key,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final divisorColor = theme.colorScheme.surfaceBright;

    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductInfoScreen()),
        );
      },
      child: SizedBox(
        width: _cardWidth,
        height: _cardHeight,
        child: ClipRRect(
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.network(
                  image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 150,
                ),
                Divider(
                  thickness: 1,
                  color: divisorColor,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 0, 1.0, 4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.black),
                      ),
                      const SizedBox(height: 2.0),
                      Text(
                        'R\$ $price / kg',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CartItemCard extends StatefulWidget {
  final ProductCard productCard;

  const CartItemCard({super.key, required this.productCard});

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  final List<int> _quantities = List.generate(10, (index) => index + 1);
  int _selectedQuantity = 1;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductInfoScreen()),
        );
      },
      child: Card(
        color: Colors.white,
        elevation: 0.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              widget.productCard.image,
              width: 100,
              height: 100,
              fit: BoxFit.scaleDown,
              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                return Container(
                  width: 100,
                  height: 100,
                  color: Colors.transparent, // Deixa em branco
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
                      overflow: TextOverflow.ellipsis, // Evita overflow de texto
                    ),
                    const SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Quantidade',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        DropdownButton<int>(
                          value: _selectedQuantity,
                          onChanged: (int? newValue) {
                            setState(() {
                              _selectedQuantity = newValue!;
                            });
                          },
                          items:
                              _quantities.map<DropdownMenuItem<int>>((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text('${value.toString()} kg'),
                            );
                          }).toList(),
                          underline: Container(
                            height: 2,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Valor e botão de excluir
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 40,
                    ),
                    onPressed: () {
                    },
                  ),
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
      ),
    );
  }
}
