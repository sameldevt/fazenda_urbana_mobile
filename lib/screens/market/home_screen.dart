import 'package:flutter/material.dart';
import 'package:verdeviva/common/buttons.dart';
import 'package:verdeviva/common/cards.dart';
import 'package:verdeviva/common/constants.dart';
import 'package:verdeviva/common/custom_widgets.dart';
import 'package:verdeviva/model/product.dart';
import 'package:verdeviva/model/user.dart';
import 'package:verdeviva/screens/access/recover_password_screen.dart';
import 'package:verdeviva/screens/account/account_screen.dart';
import 'package:verdeviva/screens/account/personal_data_screen.dart';
import 'package:verdeviva/screens/market/cart_screen.dart';
import 'package:verdeviva/screens/market/orders_screen.dart';
import 'package:verdeviva/service/product_service.dart';

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
  User? user;

  void _onItemSelected(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  void loadUser() async {
    User? loadedUser = await User.fromSharedPreferences();
    setState(() {
      user = loadedUser;
    });
  }

  @override
  void initState() {
    loadUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final background = theme.colorScheme.surface;
    return Scaffold(
      backgroundColor: background,
      appBar: const CustomAppBar(),
      drawer: user == null
          ? const NotLoggedDrawer()
          : LoggedDrawer(
              onItemSelected: _onItemSelected,
              user: user!,
            ),
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
  final ProductService _productService = ProductService();
  final List<Product> _products = [];

  Future<void> _loadProducts() async {
    final products = await _productService.getAll();
    setState(() {
      _products.addAll(products);
    });
  }

  @override
  void initState() {
    _loadProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _FilterSection(),
        Expanded(
          child: RefreshIndicator(
            onRefresh: _loadProducts, // A função de atualização
            child: _products.isEmpty
                ? _NoProductsScreen() // Mostra tela de "sem produtos"
                : GridView.builder(
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Define 2 colunas no grid
                    crossAxisSpacing: 1.0,
                    mainAxisSpacing: 1.0,
                    childAspectRatio: 0.85,
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
        ),
      ],
    );
  }
}

class _NoProductsScreen extends StatefulWidget {
  const _NoProductsScreen({super.key});

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
                Container(
                  child: Column(
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
