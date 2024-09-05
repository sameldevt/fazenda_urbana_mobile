import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:verdeviva/common/buttons.dart';
import 'package:verdeviva/screens/market/my_orders_screen.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  String pixCode = 'e7a1fbe0-9c5c-4427-b0d1-f2e02d3cb6ff';
  List<String> cardOptions = [
    'Crédito',
    'Débito',
    'Vale refeição',
    'Vale alimentação',
  ];

  String _selectedCardOption = '';

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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Cartão',
                style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
              ),
            ),
            _CardDataForm(),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
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
            ),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10.0),
                    ),
                  ),
                  showDragHandle: true,
                  builder: (BuildContext context) {
                    return Container(
                      height: 300,
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Escolha uma opção',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Expanded(
                            child: ListView.separated(
                              itemCount: cardOptions.length,
                              itemBuilder: (BuildContext context, int index) {
                                String value = cardOptions[index];
                                return ListTile(
                                  title: Center(
                                    child: Text(
                                      value,
                                      style: const TextStyle(fontSize: 16.0),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _selectedCardOption = value;
                                    });
                                    Navigator.pop(context);
                                  },
                                );
                              },
                              separatorBuilder: (BuildContext context, int index) {
                                return const Divider(
                                  color: Colors.grey,
                                  thickness: 0.5,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Container(
                width: 400,
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _selectedCardOption.isEmpty ? 'Selecione uma opção' : _selectedCardOption, // Exibe o valor selecionado ou uma mensagem padrão
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.black, // Ajuste a cor conforme necessário
                        ),
                      ),
                    ),
                    Icon(Icons.arrow_drop_down_sharp, size: 36,color: Colors.green.shade900,),
                  ],
                ),
              ),
            ),

            NavigationPrimaryButton(route: 'payment-status', buttonText: 'Confirmar pagamento', buttonTextSize: 20),

          ],
        ),
      ),
    );
  }
}

class _CardDataForm extends StatefulWidget {
  _CardDataForm({super.key});

  @override
  State<_CardDataForm> createState() => _CardDataFormState();
}

class _CardDataFormState extends State<_CardDataForm> {
  final _formKey = GlobalKey<FormState>();
  String? selectedValue;

  final List<String> filterOptions = [
    "Crédito",
    "Débito",
    "Vale refeição",
    "Vale alimentação"
  ];

  String? selectMethod;

  final List<String> paymentMethod = [
    "1x de R\$ 23,99",
    "2x de R\$ 12,99",
    "3x de R\$ 8,99",
  ];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Número do cartão',
                    style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14,)),
              ),
              TextFormField(
                //controller: controller,
                decoration: InputDecoration(
                  hintText: '0000 0000 0000 0000',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um número de cartão válido!!';
                  }
                  return null;
                },
                onSaved: (value) {},
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'CVV',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: '000',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        autovalidateMode:
                        AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira um CVV válido!';
                          }
                          return null;
                        },
                        onSaved: (value) {},
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Vencimento',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: '01/2029',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        keyboardType: TextInputType.datetime,
                        autovalidateMode:
                        AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira uma data de vencimento válida!';
                          }
                          return null;
                        },
                        onSaved: (value) {},
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Categoria',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      DropdownButtonFormField<String>(
                        isExpanded: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          border: InputBorder.none, // Remove o underline
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey), // Ajuste a cor da borda se necessário
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey), // Ajuste a cor da borda se necessário
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        dropdownColor: Colors.white,
                        value: selectMethod,
                        hint: const Text(
                          "Escolher",
                          style: TextStyle(color: Colors.grey),
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectMethod = newValue!;
                          });
                        },
                        items: filterOptions.map<DropdownMenuItem<String>>(
                              (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(color: Colors.grey),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Nome do titular',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Nome Sobrenome',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        autovalidateMode:
                        AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira um nome válido!';
                          }
                          return null;
                        },
                        onSaved: (value) {},
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Forma de pagamento',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      DropdownButtonFormField<String>(
                        isExpanded: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          border: InputBorder.none, // Remove o underline
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey), // Ajuste a cor da borda se necessário
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey), // Ajuste a cor da borda se necessário
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        dropdownColor: Colors.white,
                        value: selectMethod,
                        hint: const Text(
                          "Escolher",
                          style: TextStyle(color: Colors.grey),
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectMethod = newValue!;
                          });
                        },
                        items: paymentMethod.map<DropdownMenuItem<String>>(
                              (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(color: Colors.grey),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
