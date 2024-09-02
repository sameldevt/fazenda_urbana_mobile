import 'package:flutter/material.dart';

class MyAccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minha conta'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              child: Icon(
                Icons.person,
                size: 40,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Mariana Santos',
              style: TextStyle(fontSize: 24),
            ),
            Text('Membro desde 24/01/2018.'),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Navegação para a tela de dados pessoais
              },
              child: Text('Dados pessoais'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navegação para a tela de endereço de entrega
              },
              child: Text('Endereço de entrega'),
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
            icon: Icon(Icons.local_shipping),
            label: 'Meus pedidos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Minha conta',
          ),
        ],
        currentIndex: 3, // Seleciona a aba "Minha conta"
      ),
    );
  }
}
