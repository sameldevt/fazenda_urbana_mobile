import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verdeviva/common/buttons.dart';
import 'package:verdeviva/common/constants.dart';
import 'package:verdeviva/model/user.dart';
import 'package:verdeviva/providers/user_provider.dart';
import 'package:verdeviva/service/user_service.dart';

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
              child: Padding(
                padding: const EdgeInsets.all(appPadding),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const _Header(),
                      const SizedBox(
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
  final _userService = UserService();
  bool isEditable = false;

  @override
  Widget build(BuildContext context) {
    final verticalPadding = MediaQuery.of(context).size.height * 0.29;
    final user = Provider.of<UserProvider>(context).user!;

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
                      hintText: user.name,
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
                      hintText: user.contact.email,
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
                      hintText: user.contact.phone,
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
                    onSaved: (value) {

                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: verticalPadding,),
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
