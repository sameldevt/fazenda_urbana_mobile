import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:verdeviva/common/buttons.dart';
import 'package:verdeviva/screens/market/orders_screen.dart';

class PixScreen extends StatefulWidget {
  const PixScreen({super.key});

  @override
  State<PixScreen> createState() => _PixScreenState();
}

class _PixScreenState extends State<PixScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appBarColor = theme.colorScheme.primary;
    final background = theme.colorScheme.surface;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: const Text(
          'Pedido aguardando pagamento',
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 30,
        ),
        centerTitle: true,
      ),
      backgroundColor: background,
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
              child: const Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            _Header(),
                            _QRCodeSection(),
                            SizedBox(
                              height: 32,
                            ),
                            _OrderInfo(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
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
    return const Center(
      child: Text(
        textAlign: TextAlign.center,
        'Pedido realizado com sucesso!',
        style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _QRCodeSection extends StatelessWidget {
  final String pixCode = 'e7a1fbe0-9c5c-4427-b0d1-f2e02d3cb6ff';

  const _QRCodeSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Center(
          child: Icon(
            Icons.check,
            color: Colors.green,
            size: 200,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              textAlign: TextAlign.center,
              'Escaneie o QR Code ou copie o código de pix abaixo para finalizar seu pagamento',
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Center(
          child: SizedBox(
            height: 220,
            width: 220,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0)),
              child: Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d0/QR_code_for_mobile_English_Wikipedia.svg/1024px-QR_code_for_mobile_English_Wikipedia.svg.png',
                fit: BoxFit.scaleDown,
                width: double.infinity,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        InkWell(
          onTap: () {
            Clipboard.setData(ClipboardData(text: pixCode));
          },
          child: const ActionPrimaryButton(
              buttonText: 'Copiar código Pix', buttonTextSize: 20),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}

class _OrderInfo extends StatelessWidget {
  const _OrderInfo();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Resumo do pedido',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Produtos (2)',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              Text(
                'R\$ 18,99',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Frete',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              Text(
                'R\$ 2,99',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
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
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OrdersScreen(),
                ),
              );
            },
            child: const ActionPrimaryButton(
              buttonText: 'Ver pedidos',
              buttonTextSize: 20,
            ),
          ),
          const NavigationSecondaryButton(
              route: 'home',
              buttonText: 'Voltar ao início',
              buttonTextSize: 20),
        ],
      ),
    );
  }
}
