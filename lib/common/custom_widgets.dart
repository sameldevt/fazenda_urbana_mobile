import 'package:flutter/material.dart';
import 'package:verdeviva/model/user.dart';
import 'package:verdeviva/service/user_service.dart';

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
      automaticallyImplyLeading: false,
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
              height: kToolbarHeight - 16,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Pesquisar produto',
                  prefixIcon: const Icon(
                    Icons.search,
                    size: 24,
                    color: Colors.black,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
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
              onPressed: () {
                Navigator.pushNamed(context, 'cart');
              },
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
      selectedItemColor: barItemsColor,
      // Cor do ícone e texto selecionados
      unselectedItemColor: Colors.black,
      // Cor do ícone e texto não selecionados
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

class LoggedDrawer extends StatefulWidget {
  final Function(int) onItemSelected;
  final User user;

  const LoggedDrawer({super.key, required this.onItemSelected, required this.user});

  @override
  State<LoggedDrawer> createState() => _LoggedDrawerState();
}

class _LoggedDrawerState extends State<LoggedDrawer> {
  final _userService = UserService();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final barColor = theme.colorScheme.primary;
    final barItemsColor = theme.colorScheme.onPrimary;
    return Drawer(
      elevation: 10.0,
      backgroundColor: Colors.white,
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
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, 'account');
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.insert_emoticon_outlined,
                      size: 60,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.user.name,
                    style: TextStyle(
                      fontSize: 22,
                      color: barItemsColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.user.contact.email,
                    style: TextStyle(
                      fontSize: 16,
                      color: barItemsColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(24.0, 16, 0, 0),
            child: Text(
              'Atalhos',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.home_outlined,
              size: 32,
              color: Colors.black,
            ),
            title: const Text(
              'Página Inicial',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, 'home');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.shopping_cart_outlined,
              size: 32,
              color: Colors.black,
            ),
            title: const Text(
              'Meu carrinho',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            onTap: () {
              Navigator.pushNamed(context, 'cart');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.account_circle_outlined,
              size: 32,
              color: Colors.black,
            ),
            title: const Text(
              'Minha conta',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            onTap: () {
              Navigator.pushNamed(context, 'account');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.content_paste_search,
              size: 32,
              color: Colors.black,
            ),
            title: const Text(
              'Meus pedidos',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            onTap: () {
              Navigator.pushNamed(context, 'orders');
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 280),
            child: ListTile(
              leading: const Icon(
                Icons.exit_to_app,
                size: 32,
                color: Colors.black,
              ),
              title: const Text(
                'Sair',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              onTap: () {
                _userService.deleteUserInfo().then((value) {
                  Navigator.pushReplacementNamed(context, 'home');
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class NotLoggedDrawer extends StatefulWidget {
  const NotLoggedDrawer({super.key});

  @override
  State<NotLoggedDrawer> createState() => _NotLoggedDrawerState();
}

class _NotLoggedDrawerState extends State<NotLoggedDrawer> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final barColor = theme.colorScheme.primary;
    final barItemsColor = theme.colorScheme.onPrimary;
    return Drawer(
      elevation: 10.0,
      backgroundColor: Colors.white,
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/missing-user.png',
                  height: 80,
                  width: 80,
                  color: Colors.white,
                ),
                Text(
                  'Você não está conectado',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      color: barItemsColor,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(24.0, 16, 0, 0),
            child: Text(
              'Atalhos',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.home_outlined,
              size: 32,
              color: Colors.black,
            ),
            title: const Text(
              'Página Inicial',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, 'home');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.account_circle_outlined,
              size: 32,
              color: Colors.black,
            ),
            title: const Text(
              'Acessar conta',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            onTap: () {
              Navigator.pushNamed(context, 'login');
            },
          ),
        ],
      ),
    );
  }
}
