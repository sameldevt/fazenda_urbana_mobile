import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verdeviva/common/cards.dart';
import 'package:verdeviva/common/constants.dart';
import 'package:verdeviva/common/custom_widgets.dart';
import 'package:verdeviva/model/product.dart';
import 'package:verdeviva/model/user.dart';
import 'package:verdeviva/providers/cart_provider.dart';
import 'package:verdeviva/providers/product_provider.dart';
import 'package:verdeviva/screens/access/recover_password_screen.dart';
import 'package:verdeviva/screens/account/account_screen.dart';
import 'package:verdeviva/screens/account/personal_data_screen.dart';
import 'package:verdeviva/screens/market/cart_screen.dart';
import 'package:verdeviva/screens/account/orders_screen.dart';

import '../../providers/user_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _screens = [
    const _MainPageScreen(),
    const CartScreen(),
    const OrdersScreen(),
    const AccountScreen(),
    const RecoverPasswordScreen(),
    const PersonalDataScreen(),
  ];
  int _currentPageIndex = 0;

  void _onItemSelected(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        final user = userProvider.user;
        final theme = Theme.of(context);
        final background = theme.colorScheme.surface;

        return Scaffold(
          backgroundColor: background,
          appBar: const CustomAppBar(),
          drawer: user == null
              ? const NotLoggedDrawer()
              : LoggedDrawer(
                  onItemSelected: _onItemSelected,
                ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: _screens[_currentPageIndex],
          ),
        );
      },
    );
  }
}

class _MainPageScreen extends StatefulWidget {
  const _MainPageScreen();

  @override
  State<_MainPageScreen> createState() => _MainPageScreenState();
}

class _MainPageScreenState extends State<_MainPageScreen> {
  Future<void> _refreshList() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          final products = productProvider.products;
          return Column(
        children: [
          const _FilterSection(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshList,
              child: products.isEmpty
                  ? const _NoProductsScreen()
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 1.0,
                        mainAxisSpacing: 1.0,
                        childAspectRatio: 0.80,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final item = products[index];
                        return ShopCard(
                          product: item,
                        );
                      },
                    ),
            ),
          ),
        ],
      );
    });
  }
}

class _NoProductsScreen extends StatefulWidget {
  const _NoProductsScreen();

  @override
  State<_NoProductsScreen> createState() => _NoProductsScreenState();
}

class _NoProductsScreenState extends State<_NoProductsScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final verticalPadding = screenHeight * 0.10;

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(appPadding),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: verticalPadding,
                ),
                Column(
                  children: [
                    Image.asset(
                      'assets/server-error.png',
                      height: 400,
                      width: 400,
                    ),
                    const Text(
                      "Não foi possível carregar a lista de produtos",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: verticalPadding,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _FilterSection extends StatefulWidget {
  const _FilterSection();

  @override
  State<_FilterSection> createState() => _FilterSectionState();
}

class _FilterSectionState extends State<_FilterSection> {
  String? selectedValue;

  final List<String> filterOptions = [
    "Preço crescente",
    "Preço decrescente",
    "Mais avaliados",
    "Mais recentes",
    "Mais procurados"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Todos os itens',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          // Container(
          //   height: 30,
          //   width: 180,
          //   padding: const EdgeInsets.symmetric(horizontal: 4.0),
          //   decoration: BoxDecoration(
          //     border: Border.all(color: Colors.grey),
          //     borderRadius: BorderRadius.circular(20),
          //   ),
          //   child: DropdownButton<String>(
          //     dropdownColor: Colors.white,
          //     borderRadius: BorderRadius.circular(20),
          //     value: selectedValue,
          //     alignment: AlignmentDirectional.center,
          //     hint: const Text(
          //       "Filtrar itens",
          //       style: TextStyle(color: Colors.grey),
          //     ),
          //     icon: const Icon(
          //       Icons.filter_list,
          //       color: Colors.grey,
          //       size: 20,
          //     ),
          //     onChanged: (String? newValue) {
          //       setState(() {
          //         selectedValue = newValue!;
          //       });
          //     },
          //     items: filterOptions.map<DropdownMenuItem<String>>(
          //       (String value) {
          //         return DropdownMenuItem<String>(
          //           value: value,
          //           child: Text(
          //             value,
          //             style: const TextStyle(color: Colors.grey),
          //           ),
          //         );
          //       },
          //     ).toList(),
          //   ),
          // ),
        ],
      ),
    );
  }
}
