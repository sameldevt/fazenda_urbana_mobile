import 'package:flutter/material.dart';
import 'package:verdeviva/model/product.dart';
import 'package:verdeviva/screens/market/product_info_screen.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key,
    required this.product
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final questionMarkColor = theme.colorScheme.primary.withOpacity(0.5);

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 1,
      child: InkWell(
        onTap: () {
           Navigator.push(
             context,
             MaterialPageRoute(builder: (context) => ProductInfoScreen(product: product,)),
           );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0)),
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.scaleDown,
                  width: double.infinity,
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return Container(
                      width: double.infinity,
                      color: Colors.transparent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/sad-face-2.png", height: 80, width: 80, color: questionMarkColor,),
                          const SizedBox(height: 15,),
                          Text("Imagem indisponível", style: TextStyle(color: questionMarkColor, fontSize: 16),),
                          //Icon(Icons.question_mark_rounded, size: 80, color: questionMarkColor,),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text('R\$ ${product.pricePerKilo} kg', style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
