import 'package:flutter/material.dart';
import 'package:verdeviva/model/product.dart';
import 'package:verdeviva/screens/market/product_info_screen.dart';

class ShopCard extends StatelessWidget {
  final Product product;
  final double _cardWidth = 170.0;
  final double _cardHeight = 120.0;
  final double _cardElevation = 10.0;

  const ShopCard({
    super.key,
    required this.product
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final divisorColor = theme.colorScheme.surfaceBright;
    final questionMarkColor = theme.colorScheme.primary.withOpacity(0.5);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductInfoScreen(product: product)),
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
                  product.imageUrl,
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: 150,
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: 150,
                      color: Colors.transparent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/sad-face-2.png", height: 70, width: 70, color: questionMarkColor,),
                          const SizedBox(height: 15,),
                          Text("Imagem indisponível", style: TextStyle(color: questionMarkColor,fontSize: 16),),
                          //Icon(Icons.question_mark_rounded, size: 80, color: questionMarkColor,),
                        ],
                      ),
                    );
                  },
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
                        product.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.black),
                      ),
                      const SizedBox(height: 2.0),
                      Text(
                        'R\$ ${product.pricePerKilo.toString()} / kg',
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
