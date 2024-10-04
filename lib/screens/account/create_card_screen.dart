import 'package:flutter/material.dart';
import 'package:verdeviva/common/buttons.dart';
import 'package:verdeviva/common/constants.dart';

class CreateCardScreen extends StatefulWidget {
  const CreateCardScreen({super.key});

  @override
  State<CreateCardScreen> createState() => _CreateCardScreenState();
}

class _CreateCardScreenState extends State<CreateCardScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appBarColor = theme.colorScheme.primary;
    final background = theme.colorScheme.surface;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: const Text(
          'Cadastrar cartão',
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 30,
        ),
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
              child: const Padding(
                padding: EdgeInsets.all(appPadding),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _Header(),
                      SizedBox(
                        height: 8,
                      ),
                      Center(
                        child: _CardDataForm(),
                      ),
                    ],
                  ),
                ),
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
    return const Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'Novo cartão',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }
}

class _CardDataForm extends StatefulWidget {
  const _CardDataForm();

  @override
  State<_CardDataForm> createState() => _CardDataFormState();
}

class _CardDataFormState extends State<_CardDataForm> {
  final _formKey = GlobalKey<FormState>();
  List<String> cardOptions = [
    'Crédito',
    'Débito',
    'Vale refeição',
    'Vale alimentação',
  ];

  String _selectedCardOption = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // Minimize the size of the column
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 14,
        ),
        Form(
          key: _formKey,
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Número do cartão',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    )),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: '0000 0000 0000 0000',
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um número de cartão válido!';
                  }
                  return null;
                },
                onSaved: (value) {},
              ),
              const SizedBox(height: 4.0),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Nome do titular',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    )),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Nome Sobrenome',
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um número de cartão válido!';
                  }
                  return null;
                },
                onSaved: (value) {},
              ),
              const SizedBox(height: 4.0),
              Row(
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
                                borderSide: const BorderSide(color: Colors.grey),
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
                  const SizedBox(width: 8.0),
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
                                borderSide: const BorderSide(color: Colors.grey),
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
                ],
              ),
              const SizedBox(height: 16.0),
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
                                separatorBuilder:
                                    (BuildContext context, int index) {
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
                          _selectedCardOption.isEmpty
                              ? 'Tipo do cartão'
                              : _selectedCardOption,
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_drop_down_sharp,
                        size: 36,
                        color: Colors.green.shade900,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 300.0),
              InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    // Process form submission
                    _formKey.currentState!.save();
                  }
                },
                child: const ActionPrimaryButton(
                  buttonText: 'Cadastrar',
                  buttonTextSize: 20,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
