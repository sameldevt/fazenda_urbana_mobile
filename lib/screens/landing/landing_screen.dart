import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:verdeviva/common/buttons.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/vegetais.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            // Ajuste os valores para mais ou menos desfoque
            child: Container(
              color: Colors.black.withOpacity(
                  0), // Mantém a área transparente, apenas aplicando o blur
            ),
          ),
          const Positioned(
              bottom: 120,
              right: 50,
              child: NavigationPrimaryButton(
                  route: 'login', buttonText: 'Entrar', buttonTextSize: 20)),
          const Positioned(
            bottom: 50,
            right: 50,
            child: NavigationSecondaryButton(
                route: 'home', buttonText: 'Ver produtos', buttonTextSize: 20),
          ),
        ],
      ),
    );
  }
}
