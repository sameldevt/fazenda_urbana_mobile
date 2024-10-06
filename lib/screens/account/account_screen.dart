import 'package:flutter/material.dart';
import 'package:verdeviva/common/buttons.dart';
import 'package:verdeviva/common/constants.dart';
import 'package:verdeviva/model/user.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  User? user;

  void loadUser() async {
    final userData = await User.fromSharedPreferences();
    setState(() {
      user = userData;
    });
  }

  @override
  void initState() {
    loadUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final verticalPadding = screenHeight * 0.18;

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
              child: Padding(
                padding: EdgeInsets.all(appPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: verticalPadding,),
                    _Header(user: user!,),
                    _AccountInfo(user: user!),
                    SizedBox(height: verticalPadding,),
                    _Buttons(),
                  ],
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
  User user;
  _Header({required this.user});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        user.name,
        style: TextStyle(fontSize: 34),
      ),
    );
  }
}

class _AccountInfo extends StatelessWidget {
  User user;
  _AccountInfo({required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Icon(
            Icons.account_circle_sharp,
            size: 200,
          ),
        ),
        Text(
          user.contact.email,
          style: TextStyle(fontSize: 20, color: Colors.grey),
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
          route: 'address-list',
          buttonText: 'Endereços',
          buttonTextSize: 20,
        ),
      ],
    );
  }
}
