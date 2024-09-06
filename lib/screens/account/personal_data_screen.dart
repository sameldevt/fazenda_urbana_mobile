import 'package:flutter/material.dart';
import 'package:verdeviva/common/buttons.dart';

class PersonalDataScreen extends StatefulWidget {
  const PersonalDataScreen({super.key});

  @override
  State<PersonalDataScreen> createState() => _PersonalDataScreenState();
}

class _PersonalDataScreenState extends State<PersonalDataScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appBarColor = theme.colorScheme.primary;
    final background = theme.colorScheme.surface;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: const Text(
          'Minha conta',
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
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
                padding: EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _Header(),
                      SizedBox(
                        height: 8,
                      ),
                      _PersonalDataForm(),
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
        'Suas informações',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }
}

class _PersonalDataForm extends StatefulWidget {
  const _PersonalDataForm();

  @override
  State<_PersonalDataForm> createState() => _PersonalDataFormState();
}

class _PersonalDataFormState extends State<_PersonalDataForm> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, String> personalData = {
    "completeName": "Mariana Santos",
    "email": "mariana.santos@email.com",
    "phone": "(11) 987654321",
    "password": "********"
  };

  bool isEditable = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Nome Completo',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                  TextFormField(
                    enabled: isEditable,
                    //controller: controller,
                    decoration: InputDecoration(
                      hintText: personalData['completeName'],
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira seu nome!';
                      }
                      return null;
                    },
                    onSaved: (value) {},
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('E-mail',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                  TextFormField(
                    enabled: isEditable,
                    //controller: controller,
                    decoration: InputDecoration(
                      hintText: personalData['email'],
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira seu email';
                      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                          .hasMatch(value)) {
                        return 'Por favor, insira um email válido';
                      }
                      return null;
                    },
                    onSaved: (value) {},
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Telefone',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  TextFormField(
                    enabled: isEditable,
                    //controller: controller,
                    decoration: InputDecoration(
                      hintText: personalData['phone'],
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira sua senha';
                      }
                      return null;
                    },
                    onSaved: (value) {},
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Senha',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  TextFormField(
                    enabled: false,
                    obscureText: true,
                    //controller: controller,
                    decoration: InputDecoration(
                      hintText: personalData['password'],
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira sua senha';
                      }
                      return null;
                    },
                    onSaved: (value) {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 160,),
            InkWell(
              onTap: () {
                setState(() {
                  isEditable = !isEditable;
                });
              },
              child: ActionPrimaryButton(
                  buttonText: isEditable ? 'Salvar alterações' : 'Editar',
                  buttonTextSize: 20),
            ),
            const SizedBox(
              height: 8,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  isEditable = false;
                });
                Navigator.pushNamed(context, 'change-pass');
              },
              child: const ActionSecondaryButton(
                  buttonText: 'Alterar senha', buttonTextSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
