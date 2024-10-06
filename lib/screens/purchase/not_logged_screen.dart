import 'package:flutter/material.dart';
import 'package:verdeviva/common/buttons.dart';
import 'package:verdeviva/common/constants.dart';

class NotLoggedScreen extends StatelessWidget {
  const NotLoggedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final verticalPadding = screenHeight * 0.05; // 5% do tamanho da altura
    final theme = Theme.of(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(appPadding),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: verticalPadding,
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/user-not-found.png',
                      height: 300,
                      width: 300,
                    ),
                    const Text(
                      textAlign: TextAlign.center,
                      "Nenhuma conta conectada!",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10,),
                    const Text(
                      textAlign: TextAlign.center,
                      "Você precisará de uma conta para prosseguir com sua compra.",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 20,),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, 'login');
                      },
                      child: const ActionPrimaryButton(
                          buttonText: "Acessar conta", buttonTextSize: 18),
                    ),
                    SizedBox(height: 20,),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const ActionSecondaryButton(
                          buttonText: "Voltar", buttonTextSize: 18),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: verticalPadding,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
