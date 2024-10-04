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
                      width: 300,
                      height: 300,
                      color: Colors.transparent,
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
