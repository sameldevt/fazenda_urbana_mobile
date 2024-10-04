import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:verdeviva/common/buttons.dart';
import 'package:verdeviva/common/constants.dart';
import 'package:verdeviva/model/dtos/login_dto.dart';
import 'package:verdeviva/service/access_service.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                      _LoginForm(),
                      SizedBox(
                        height: 8,
                      ),
                      _ForgotPasswordSection(),
                      SizedBox(
                        height: 36,
                      ),
                      _CreateAccountSection(),
                      SizedBox(
                        height: 42,
                      ),
                      _LoginScreenFooter(),
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
    return Center(
      child: SizedBox(
          height: 280,
          child: Image.asset(fit: BoxFit.contain, 'assets/logo-fazenda.png')),
    );
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm();

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _loginService = new AccessService();

  String? _email;
  String? _password;

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
                    'Senha',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                TextFormField(
                  obscureText: true,
                  //controller: controller,
                  decoration: const InputDecoration(
                    hintText: 'Digite sua senha',
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
                  var loginDto = new LoginDto(email: _email!, password: _password!);

                  _loginService.login(loginDto).then((result) {
                    Navigator.pushReplacementNamed(context, 'home');
                  }).catchError((error) {
                    print("Erro ao fazer login: $error");
                  });
                }
              },
              child: const ActionPrimaryButton(
                  buttonText: 'Acessar conta', buttonTextSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

class _ForgotPasswordSection extends StatelessWidget {
  const _ForgotPasswordSection();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(
          text: 'Esqueceu sua senha? ',
          style: const TextStyle(color: Colors.grey),
          children: <TextSpan>[
            TextSpan(
              text: 'Toque aqui.',
              style: const TextStyle(
                color: Colors.grey,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, 'change-pass');
                },
            ),
          ],
        ),
      ),
    );
  }
}

class _CreateAccountSection extends StatelessWidget {
  const _CreateAccountSection();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Row(
            children: <Widget>[
              Expanded(
                child: Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
              ),
              Text('Ainda não tem um cadastro?'),
              Expanded(
                child: Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, 'register');
            },
            child: const ActionSecondaryButton(
                buttonText: 'Criar uma conta', buttonTextSize: 20),
          ),
        ],
      ),
    );
  }
}

class _LoginScreenFooter extends StatelessWidget {
  const _LoginScreenFooter();

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
