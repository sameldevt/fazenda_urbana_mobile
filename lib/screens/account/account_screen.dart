import 'package:flutter/material.dart';
import 'package:verdeviva/common/buttons.dart';
import 'package:verdeviva/common/constants.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

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
                fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
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
                  padding: EdgeInsets.all(appPadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _Header(),
                      _AccountInfo(),
                      _Buttons(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Mariana Santos',
        style: TextStyle(fontSize: 34),
      ),
    );
  }
}

class _AccountInfo extends StatelessWidget {
  const _AccountInfo();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Center(
          child: Icon(
            Icons.account_circle_sharp,
            size: 200,
          ),
        ),
        Text(
          'mariana.santos@gmail.com',
          style: TextStyle(fontSize: 20, color: Colors.grey),
        ),
        Text(
          'Membro desde 24/01/2018',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }
}

class _Buttons extends StatelessWidget {
  const _Buttons();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        NavigationPrimaryButton(
            route: 'personal-data',
            buttonText: 'Dados pessoais',
            buttonTextSize: 20),
        SizedBox(
          height: 8,
        ),
        NavigationSecondaryButton(
          route: 'address',
          buttonText: 'Endereços',
          buttonTextSize: 20,
        ),
      ],
    );
  }
}
