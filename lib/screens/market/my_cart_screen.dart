import 'package:flutter/material.dart';

class MyCartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            // Ação de abrir o menu lateral
          },
        ),
        title: Text('Fazenda VerdeViva'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Ação de pesquisa
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OutlinedButton(
              onPressed: () {
                // Ação de voltar
              },
              child: Text('Voltar'),
            ),
            SizedBox(height: 16),
            Text(
              'Meu carrinho',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            CartItem(
              imageUrl: 'https://rb.gy/2xfabn',
              name: 'Batata',
              pricePerKg: 5.00,
              quantity: 1.5,
              totalPrice: 9.00,
            ),
            CartItem(
              imageUrl: 'https://rb.gy/8ly4oc',
              name: 'Maçã',
              pricePerKg: 9.99,
              quantity: 1,
              totalPrice: 9.99,
            ),
            SizedBox(height: 16),
            Text(
              'Calcular frete',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'CEP para entrega',
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    // Ação de calcular frete
                  },
                  child: Text('Calcular'),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Frete',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'R\$ 0,00',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
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
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Ação de prosseguir para compra
              },
              child: Text('Prosseguir compra'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Meu carrinho',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Meus pedidos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Minha conta',
          ),
        ],
        currentIndex: 1, // Define o item selecionado
        onTap: (int index) {
          // Ação ao clicar nos itens da BottomNavigationBar
        },
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final double pricePerKg;
  final double quantity;
  final double totalPrice;

  CartItem({
    required this.imageUrl,
    required this.name,
    required this.pricePerKg,
    required this.quantity,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            imageUrl,
            width: 100,
            height: 100,
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'R\$ ${pricePerKg.toStringAsFixed(2)} / kg',
                  style: TextStyle(fontSize: 16),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: quantity.toString(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'R\$ ${totalPrice.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              // Ação de excluir item do carrinho
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
