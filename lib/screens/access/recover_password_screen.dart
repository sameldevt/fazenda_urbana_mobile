import 'package:flutter/material.dart';
import 'package:verdeviva/common/buttons.dart';
import 'package:verdeviva/common/constants.dart';

class RecoverPasswordScreen extends StatelessWidget {
  const RecoverPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final background = theme.colorScheme.surface;

    return Scaffold(
      backgroundColor: background,
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(appPadding),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 36,
                      ),
                      _Header(),
                      _ChangePasswordForm(),
                      SizedBox(
                        height: 20,
                      ),
                      _ChangePasswordScreenFooter(),
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
    return Column(
      children: [
        Center(
          child: SizedBox(
              height: 280,
              child:
                  Image.asset(fit: BoxFit.contain, 'assets/logo-fazenda.png')),
        ),
        const Text(
          'Alterar senha',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _ChangePasswordForm extends StatefulWidget {
  const _ChangePasswordForm();

  @override
  State<_ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<_ChangePasswordForm> {
  final _formKey = GlobalKey<FormState>();

  String? _email;
  String? _newPassword;
  String? _newPasswordAgain;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('E-mail',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
                TextFormField(
                  //controller: controller,
                  decoration: const InputDecoration(
                    hintText: 'Digite seu e-mail',
                    border: OutlineInputBorder(),
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
                  onSaved: (value) {
                    _email = value;
                  },
                ),
              ],
            ),
            Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Nova Senha',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                TextFormField(
                  obscureText: true,
                  //controller: controller,
                  decoration: const InputDecoration(
                    hintText: 'Digite a nova senha',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira sua senha';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _newPassword = value;
                  },
                ),
              ],
            ),
            Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Confirmação da nova senha',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                TextFormField(
                  obscureText: true,
                  //controller: controller,
                  decoration: const InputDecoration(
                    hintText: 'Digite a nova senha novamente',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira sua senha';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _newPassword = value;
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                // if (_formKey.currentState!.validate()) {
                //   _formKey.currentState!.save();
                //   // Processar dados aqui
                // }
              },
              child: const ActionPrimaryButton(
                buttonText: 'Alterar senha',
                buttonTextSize: 20,
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const ActionSecondaryButton(
                buttonText: 'Cancelar',
                buttonTextSize: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ChangePasswordScreenFooter extends StatelessWidget {
  const _ChangePasswordScreenFooter();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          '© 2024 Fazenda VerdeViva, Inc.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
          ),
        ),
        Text(
          'Todos os direitos reservados.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
