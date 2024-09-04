import 'package:flutter/material.dart';

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

    return SizedBox(
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
    );
  }
}
