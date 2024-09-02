import 'package:flutter/material.dart';
import 'package:verdeviva/screens/access/change_password_screen.dart';
import 'package:verdeviva/screens/account/my_account_screen.dart';
import 'package:verdeviva/screens/account/personal_data_screen.dart';
import 'package:verdeviva/screens/market/my_cart_screen.dart';
import 'package:verdeviva/screens/market/my_orders_screen.dart';
import 'package:verdeviva/screens/market/product_detail_screen.dart';
import 'package:verdeviva/screens/market/widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _screens = [
    const _MainPageScreen(),
    MyCartScreen(),
    const MyOrdersScreen(),
    MyAccountScreen(),
    const ChangePasswordScreen(),
    const PersonalDataScreen(),
  ];

  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    print('Current Page Index: ${_screens.length}');
    print('Current Page Index: $_currentPageIndex');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                size: 30,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        title: const Text('Fazenda VerdeViva'),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(0),
            bottomRight: Radius.circular(0),
          ),
        ),
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(24.0, 24, 0, 24),
              child: Text(
                'Fazenda VerdeViva',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(24.0, 16, 0, 0),
              child: Text(
                'Atalhos',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.home_outlined,
                size: 32,
              ),
              title: const Text(
                'Página Inicial',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _currentPageIndex = 0;
                });
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.shopping_cart_outlined,
                size: 32,
              ),
              title: const Text(
                'Meu carrinho',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _currentPageIndex = 1;
                });
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.content_paste_search,
                size: 32,
              ),
              title: const Text(
                'Meus pedidos',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _currentPageIndex = 2;
                });
              },
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(24.0, 32, 0, 0),
              child: Text(
                'Configurações',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.edit_outlined,
                size: 32,
              ),
              title: const Text(
                'Alterar senha',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _currentPageIndex = 4;
                });
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.account_circle_sharp,
                size: 32,
              ),
              title: const Text(
                'Minha conta',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _currentPageIndex = 5;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 250),
              child: ListTile(
                leading: const Icon(
                  Icons.exit_to_app,
                  size: 32,
                ),
                title: const Text(
                  'Sair',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(context, 'login');
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        enableFeedback: false,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black,
        onTap: (index) {
          setState(() {
            if (index >= 0 && index < _screens.length) {
              _currentPageIndex = index;
            }
          });
        },
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(
              Icons.home,
              color: Colors.black,
            ),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: Colors.black,
            ),
            label: 'Meu carrinho',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(
              Icons.list_alt,
              color: Colors.black,
            ),
            label: 'Meus pedidos',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(
              Icons.account_circle_sharp,
              color: Colors.black,
            ),
            label: 'Minha conta',
          ),
        ],
      ),
      body: _screens[_currentPageIndex],
    );
  }
}

class _MainPageScreen extends StatefulWidget {
  const _MainPageScreen({super.key});

  @override
  State<_MainPageScreen> createState() => _MainPageScreenState();
}

class _MainPageScreenState extends State<_MainPageScreen> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SearchSection(),
          _ItemsSection(),
        ],
      ),
    );
  }
}


class _SearchSection extends StatefulWidget {
  const _SearchSection({super.key});

  @override
  State<_SearchSection> createState() => _SearchSectionState();
}

class _SearchSectionState extends State<_SearchSection> {
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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: TextFormField(
            decoration: InputDecoration(
              hintText: 'Pesquisar produto',
              prefixIcon: const Icon(
                Icons.search,
                size: 30,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                padding: EdgeInsets.symmetric(horizontal: 4.0),
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
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ItemsSection extends StatefulWidget {
  const _ItemsSection({super.key});

  @override
  State<_ItemsSection> createState() => _ItemsSectionState();
}

class _ItemsSectionState extends State<_ItemsSection> {
  final List<Map<String, String>> products = [
    {
      "name": "Banana",
      "price": "7.99",
      "image": "https://rb.gy/2xfabn",
      "description": "Banana madura e doce, ideal para lanches e smoothies."
    },
    {
      "name": "Maçã",
      "price": "6.49",
      "image": "https://rb.gy/8ly4oc",
      "description": "Maçã crocante e suculenta, perfeita para uma alimentação saudável."
    },
    {
      "name": "Couve",
      "price": "5.99",
      "image": "https://rb.gy/s2fpd2",
      "description": "Couve fresca, rica em nutrientes e ideal para sucos verdes."
    },
    {
      "name": "Cenoura",
      "price": "4.99",
      "image": "https://rb.gy/0fiy0z",
      "description": "Cenoura crocante e adocicada, ótima para saladas e petiscos."
    },
    {
      "name": "Batata",
      "price": "3.99",
      "image": "https://rb.gy/2ot2ch",
      "description": "Batata versátil, ideal para fritar, assar ou cozinhar."
    },
    {
      "name": "Batata doce",
      "price": "4.49",
      "image": "https://t.ly/obCYL",
      "description": "Batata doce nutritiva e adocicada, excelente para receitas saudáveis."
    },
    {
      "name": "Beterraba",
      "price": "5.49",
      "image": "https://t.ly/-YCSe",
      "description": "Beterraba rica em ferro, ótima para saladas e sucos."
    },
    {
      "name": "Manga",
      "price": "6.99",
      "image": "https://t.ly/WGNKn",
      "description": "Manga suculenta e doce, perfeita para sobremesas e sucos."
    },
    {
      "name": "Alface",
      "price": "4.49",
      "image": "https://t.ly/kGI0v",
      "description": "Alface fresca e crocante, ideal para saladas."
    },
    {
      "name": "Pêra",
      "price": "7.49",
      "image": "https://t.ly/QM99N",
      "description": "Pêra doce e suculenta, ótima para lanches e sobremesas."
    },
    {
      "name": "Laranja",
      "price": "5.99",
      "image": "https://l1nq.com/nmBNt",
      "description": "Laranja refrescante e rica em vitamina C, perfeita para sucos."
    },
    {
      "name": "Alho",
      "price": "1.99",
      "image": "https://l1nq.com/7cqrk",
      "description": "Alho aromático e saboroso, essencial para temperar pratos."
    },
    {
      "name": "Cebola",
      "price": "6,49",
      "image": "https://l1nq.com/f4Mkz",
      "description": "Cebola versátil e essencial na cozinha, ideal para diversos pratos."
    },
    {
      "name": "Tomate",
      "price": "7.49",
      "image": "https://encurtador.com.br/kAgBR",
      "description": "Tomate maduro e suculento, excelente para saladas e molhos."
    },
    {
      "name": "Salsa",
      "price": "3.99",
      "image": "https://encurtador.com.br/LbyRY",
      "description": "Salsa fresca e aromática, ideal para temperar e enfeitar pratos."
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 3 / 4,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductCard(
            name: product['name']!,
            description: product['description']!,
            price: product['price']!,
            image: product['image']!,
          );
        },
      ),
    );
  }
}
