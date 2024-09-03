import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final barColor = theme.colorScheme.primary;
    final barItemsColor = theme.colorScheme.onPrimary;

    return AppBar(
      shadowColor: Colors.black,
      automaticallyImplyLeading: false, // Adicione esta linha para remover o ícone do drawer
      title: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: Icon(
                Icons.menu,
                color: barItemsColor,
                size: 30,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
          Expanded(
            child: SizedBox(
              height: kToolbarHeight - 16, // Ajuste a altura do TextField
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Pesquisar produto',
                  prefixIcon: const Icon(
                    Icons.search,
                    size: 24,
                    color: Colors.black,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: barItemsColor,
                size: 30,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      backgroundColor: barColor,
      elevation: 10.0,
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final barColor = theme.colorScheme.primary;
    final barItemsColor = theme.colorScheme.onPrimary;

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: barColor,
      enableFeedback: false,
      showUnselectedLabels: true,
      currentIndex: currentIndex,
      selectedItemColor: barItemsColor, // Cor do ícone e texto selecionados
      unselectedItemColor: Colors.black, // Cor do ícone e texto não selecionados
      selectedLabelStyle: TextStyle(color: barItemsColor),
      unselectedLabelStyle: const TextStyle(color: Colors.black),
      selectedIconTheme: IconThemeData(color: barItemsColor, size: 30),
      unselectedIconTheme: const IconThemeData(color: Colors.black),
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
          label: 'Início',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.shopping_cart_outlined,
          ),
          label: 'Meu carrinho',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.list_alt,
          ),
          label: 'Meus pedidos',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.account_circle_sharp,
          ),
          label: 'Minha conta',
        ),
      ],
    );
  }
}

class CustomDrawer extends StatelessWidget {
  final Function(int) onItemSelected;

  const CustomDrawer({super.key, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final barColor = theme.colorScheme.primary;
    final barItemsColor = theme.colorScheme.onPrimary;

    return Drawer(
      elevation: 10.0,
      backgroundColor: barColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: barColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.account_circle_outlined,
                    size: 60,
                    color: barItemsColor,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Nome do Usuário',
                  style: TextStyle(
                    fontSize: 22,
                    color: barItemsColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'email@exemplo.com',
                  style: TextStyle(
                    fontSize: 16,
                    color: barItemsColor,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(24.0, 16, 0, 0),
            child: Text(
              'Atalhos',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: barItemsColor),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home_outlined,
              size: 32,
              color: barItemsColor,
            ),
            title: Text(
              'Página Inicial',
              style: TextStyle(fontSize: 20, color: barItemsColor),
            ),
            onTap: () {
              Navigator.pop(context);
              onItemSelected(0);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.shopping_cart_outlined,
              size: 32,
              color: barItemsColor,
            ),
            title: Text(
              'Meu carrinho',
              style: TextStyle(fontSize: 20, color: barItemsColor),
            ),
            onTap: () {
              Navigator.pop(context);
              onItemSelected(1);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.content_paste_search,
              size: 32,
              color: barItemsColor,
            ),
            title: Text(
              'Meus pedidos',
              style: TextStyle(fontSize: 20, color: barItemsColor),
            ),
            onTap: () {
              Navigator.pop(context);
              onItemSelected(2);
            },
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(24.0, 32, 0, 0),
            child: Text(
              'Configurações',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: barItemsColor),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.edit_outlined,
              size: 32,
              color: barItemsColor,
            ),
            title: Text(
              'Alterar senha',
              style: TextStyle(fontSize: 20, color: barItemsColor),
            ),
            onTap: () {
              Navigator.pop(context);
              onItemSelected(4);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.account_circle_sharp,
              size: 32,
              color: barItemsColor,
            ),
            title: Text(
              'Minha conta',
              style: TextStyle(fontSize: 20, color: barItemsColor),
            ),
            onTap: () {
              Navigator.pop(context);
              onItemSelected(5);
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: 150),
            child: ListTile(
              leading: Icon(
                Icons.exit_to_app,
                size: 32,
                color: barItemsColor,
              ),
              title: Text(
                'Sair',
                style: TextStyle(fontSize: 20, color: barItemsColor),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, 'login');
              },
            ),
          ),
        ],
      ),
    );
  }
}
