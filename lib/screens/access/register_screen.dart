import 'package:flutter/material.dart';
import 'package:verdeviva/common/buttons.dart';
import 'package:verdeviva/common/constants.dart';
import 'package:verdeviva/model/user.dart';
import 'package:verdeviva/service/access_service.dart';
import 'package:verdeviva/service/user_service.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
                      _RegisterForm(),
                      SizedBox(
                        height: 18,
                      ),
                      _RegisterScreenFooter(),
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
          'Cadastrar',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _RegisterForm extends StatefulWidget {
  const _RegisterForm();

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _loginService = new AccessService();

  String? _nomeCompleto;
  String? _email;
  String? _password;

  void _showDialog(error){
    String title = "";
    String content = "";

    switch(error){
      case UserAlreadyExists _:
        title = "Usuário já cadastrado.";
        content = "O e-mail informado já possui cadastro.";
        break;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: const Text("Fechar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Nome Completo',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Nome Sobrenome',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu nome completo!';
                  }
                  return null;
                },
                onSaved: (value) {
                  _nomeCompleto = value;
                },
              ),
            ],
          ),
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
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
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
                  'Senha',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Digite sua senha',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira sua senha';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value;
                },
              ),
            ],
          ),
          const SizedBox(
            height: 32,
          ),
          InkWell(
            onTap: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
              _loginService.register(_nomeCompleto!, _email!, _password!).then((result) {
                UserService userService = UserService();
                userService.saveUserInfo(User.simple(_nomeCompleto!, _email!));

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Conta criada com sucesso!"),
                    duration: Duration(seconds: 2), // Duração do SnackBar
                    action: SnackBarAction(
                      label: "Undo",
                      onPressed: () {
                          // Ação ao clicar no botão do SnackBar
                      },
                    ),
                  ),);
                  Navigator.pushReplacementNamed(context, 'login');
                }).catchError((error) {
                  _showDialog(error);
                });
              };
            },
            child: const ActionPrimaryButton(
              buttonText: 'Criar conta',
              buttonTextSize: 20,
            ),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const ActionSecondaryButton(
              buttonText: 'Voltar',
              buttonTextSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class _RegisterScreenFooter extends StatelessWidget {
  const _RegisterScreenFooter();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'Clicando em cadastrar, você aceita nossos Termos de Serviço e Política de Privacidade',
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
