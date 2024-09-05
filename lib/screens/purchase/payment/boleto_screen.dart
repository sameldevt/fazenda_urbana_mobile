import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:verdeviva/common/buttons.dart';
import 'package:verdeviva/screens/market/my_orders_screen.dart';

class BoletoScreen extends StatefulWidget {
  const BoletoScreen({super.key});

  @override
  State<BoletoScreen> createState() => _BoletoScreenState();
}

class _BoletoScreenState extends State<BoletoScreen> {
  String boletoCode = '82736491028374659120384756';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appBarColor = theme.colorScheme.primary;
    final background = theme.colorScheme.surface;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
          title: const Text(
            'Pagamento',
            style: TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
            size: 30,
          ),
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 64.0, 16.0, 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Boleto bancário',
                  style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
                ),
              ),
              Column(
                children: [
                  //Image.network('https://img.freepik.com/psd-gratuitas/ilustracao-de-codigo-de-barras-isolada_23-2150584086.jpg?w=1060&t=st=1725577597~exp=1725578197~hmac=24cd5957a59062c88ebaf060cbc5e731833f064d5f62f064f2871efa181ce4e8'),
                  Image.asset('assets/codigo-barras.png'),
                  // Espaço reduzido entre a imagem e o texto
                  Text(
                    boletoCode,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              Column(
                children: [
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
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'R\$ 5,00',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Valor total',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'R\$ 23,99',
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
                            'Valor final (-5%)',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'R\$ 22,79',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  // Espaço entre os valores e os botões
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: boletoCode));
                        },
                        child: ActionPrimaryButton(
                            buttonText: 'Copiar código de barras',
                            buttonTextSize: 20),
                      ),
                      SizedBox(height: 10.0),
                      NavigationSecondaryButton(
                        route: 'orders',
                        buttonText: 'Ver pedidos',
                        buttonTextSize: 16,
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
