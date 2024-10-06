import 'package:flutter/material.dart';
import 'package:verdeviva/common/constants.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        title: Text('Endereço padrão'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(appPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: _AddressDataForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddressDataForm extends StatefulWidget {
  _AddressDataForm({super.key});

  @override
  State<_AddressDataForm> createState() => _AddressDataFormState();
}

class _AddressDataFormState extends State<_AddressDataForm> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, String> defaultAddress = {
    "address": "Rua das Flores",
    "number": "1000",
    "complement": "Apto 31",
    "CEP": "10101-010",
    "city": "São Paulo",
    "state": "SP",
    "aditionalInfo": "Entregar para o Sr. Fulano."
  };

  bool isEditable = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Endereço',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14,)),
                ),
                TextFormField(
                  enabled: isEditable,
                  //controller: controller,
                  decoration: InputDecoration(
                    hintText: defaultAddress['address'],
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu endereço!';
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
                          'Número',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        TextFormField(
                          enabled: isEditable,
                          decoration: InputDecoration(
                            hintText: defaultAddress['number'],
                            border: const OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira o número do seu endereço!';
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
                          'Complemento',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        TextFormField(
                          enabled: isEditable,
                          decoration: InputDecoration(
                            hintText: defaultAddress['complement'],
                            border: const OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.text,
                          autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira o complemento do seu endereço!';
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
                          'CEP',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        TextFormField(
                          enabled: isEditable,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: defaultAddress['CEP'],
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.text,
                          autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira seu CEP!';
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
                          'Cidade',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        TextFormField(
                          enabled: isEditable,
                          decoration: InputDecoration(
                            hintText: defaultAddress['city'],
                            border: const OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.text,
                          autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira a sua cidade!';
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
                          'Estado',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        TextFormField(
                          enabled: isEditable,
                          decoration: InputDecoration(
                            hintText: defaultAddress['state'],
                            border: const OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.text,
                          autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira seu estado!';
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
            Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Informações adicionais',
                      style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14,)),
                ),
                TextFormField(
                  enabled: isEditable,
                  //controller: controller,
                  decoration: InputDecoration(
                    hintText: defaultAddress['aditionalInfo'],
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {

                  },
                  onSaved: (value) {},
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(color: Colors.white)),
                  ),
                  onPressed: () {
                    setState(() {
                      isEditable = !isEditable;
                    });
                  },
                  child: Text(
                    isEditable ? 'Salvar alterações' : 'Editar',
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
