import 'package:flutter/material.dart';

final double _cardWidth = 170.0;
final double _cardHeight = 120.0;
final RoundedRectangleBorder _cardBorder = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(40.0),
);
final double _cardElevation = 10.0;

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
    final cardInfoColor = theme.colorScheme.primary;
    final cardInfoTextColor = theme.colorScheme.onPrimary;

    return SizedBox(
      width: _cardWidth,
      height: _cardHeight,
      child: ClipRRect(
        borderRadius: _cardBorder.borderRadius,
        child: Card(
          shape: _cardBorder,
          elevation: _cardElevation,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.network(
                image,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 170,
              ),
              Expanded(
                child: Container(
                  color: cardInfoColor,
                  padding: const EdgeInsets.fromLTRB(16, 4.0, 0, 4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: cardInfoTextColor),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'R\$ $price / kg',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                            color: cardInfoTextColor),
                      ),
                    ],
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
