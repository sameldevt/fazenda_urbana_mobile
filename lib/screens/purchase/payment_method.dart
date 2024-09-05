import 'package:flutter/material.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        title: Text('Confirmar forma de pagamento'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _PixCard(),
                _CreditCardCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PixCard extends StatefulWidget {
  const _PixCard({super.key});

  @override
  State<_PixCard> createState() => _PixCardState();
}

class _PixCardState extends State<_PixCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white, // Cor de fundo do Card
      elevation: 2.0, // Altura da sombra
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0), // Bordas arredondadas
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          height: 250,
          width: 320,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'Pix',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const Text(
                'Frete Grátis a partir de R\$50',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const Text(
                'Ganhe 5% de desconto!',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const Text(
                'Valor total:   R\$ 22,79',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, 'pix-payment');
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Colors.black),
                  ),
                  child: const Text(
                    'Selecionar',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ), // Cor do texto para contraste
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}

class _CreditCardCard extends StatefulWidget {
  const _CreditCardCard({super.key});

  @override
  State<_CreditCardCard> createState() => _CreditCardCardState();
}

class _CreditCardCardState extends State<_CreditCardCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white, // Cor de fundo do Card
      elevation: 2.0, // Altura da sombra
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0), // Bordas arredondadas
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          height: 250,
          width: 320,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'Cartão',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const Text(
                'Também aceitamos VA E VR',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const Text(
                'Parcele em até 3x sem juros!',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const Text(
                'Valor total:   R\$ 22,79',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, 'card-payment');
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Colors.black),
                  ),
                  child: const Text(
                    'Selecionar',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ), // Cor do texto para contraste
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
