import 'package:flutter/material.dart';
import 'package:verdeviva/common/cards.dart';
import 'package:verdeviva/common/custom_widgets.dart';
import 'package:verdeviva/common/sections.dart';
import 'package:verdeviva/model/product.dart';
import 'package:verdeviva/screens/access/change_password_screen.dart';
import 'package:verdeviva/screens/account/account_screen.dart';
import 'package:verdeviva/screens/account/personal_data_screen.dart';
import 'package:verdeviva/screens/market/cart_screen.dart';
import 'package:verdeviva/screens/market/orders_screen.dart';
import 'package:verdeviva/services/product_service.dart';

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
    const ChangePasswordScreen(),
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
    final theme = Theme.of(context);
    final background = theme.colorScheme.surface;

    return Scaffold(
      backgroundColor: background,
      appBar: const CustomAppBar(),
      drawer: CustomDrawer(onItemSelected: _onItemSelected),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _screens[_currentPageIndex],
      ),
    );
  }
}

class _MainPageScreen extends StatefulWidget {
  const _MainPageScreen();

  @override
  State<_MainPageScreen> createState() => _MainPageScreenState();
}

class _MainPageScreenState extends State<_MainPageScreen> {
  final ProductService _productService = new ProductService();
  final List<Product> _products = [];

  @override
  void initState() {
    _productService.getAll().then((result) {
      _products.addAll(result);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _FilterSection(),
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 1.0,
                    mainAxisSpacing: 1.0,
                    childAspectRatio: 3 / 4,
                  ),
                  itemCount: _products.length,
                  itemBuilder: (context, index) {
                    final item = _products[index];
                     return ShopCard(
                      product: item,
                     );
                  },
                ),
              ),
            ],
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Todos os itens',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Container(
            height: 30,
            width: 180,
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(20),
            ),
            child: DropdownButton<String>(
              dropdownColor: Colors.white,
              borderRadius: BorderRadius.circular(20),
              value: selectedValue,
              alignment: AlignmentDirectional.center,
              hint: const Text(
                "Filtrar itens",
                style: TextStyle(color: Colors.grey),
              ),
              icon: const Icon(
                Icons.filter_list,
                color: Colors.grey,
                size: 20,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  selectedValue = newValue!;
                });
              },
              items: filterOptions.map<DropdownMenuItem<String>>(
                (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

