import 'package:flutter/material.dart';
import 'package:verdeviva/common/buttons.dart';
import 'package:verdeviva/common/constants.dart';
import 'package:verdeviva/model/user.dart';
import 'package:verdeviva/screens/account/create_or_modify_address_screen.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  User? user;
  bool isLoading = true;

  void loadUser() async {
    final userData = await User.fromSharedPreferences();
    setState(() {
      user = userData;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appBarColor = theme.colorScheme.primary;
    final background = theme.colorScheme.surface;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: const Text(
          'Seus endereços',
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 30,
        ),
      ),
      backgroundColor: background,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : !(user!.hasAddress())
          ? _AddressList(user: user!)
          : _HasNoAddressScreen(),
    );
  }
}

class _AddressList extends StatefulWidget {
  final User user;

  const _AddressList({super.key, required this.user});

  @override
  State<_AddressList> createState() => _AddressListState();
}

class _AddressListState extends State<_AddressList> {
  final addresses = [];

  Future<void> refresh() async {
    setState(() {
      addresses.clear();
      addresses.addAll(widget.user.addresses);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: RefreshIndicator(
        onRefresh: refresh,
        child: ListView.separated(
          separatorBuilder: (context, index) => const Divider(
            color: Colors.grey,
            thickness: 0.5,
          ),
          itemCount: addresses.length,
          itemBuilder: (context, index) {
            final address = addresses[index];
            return InkWell(
              child: _AddressCard(
                street: address.street,
                number: address.number,
                city: address.city,
                zipCode: address.zipCode,
                complement: address.complement,
                state: address.state,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _AddressCard extends StatefulWidget {
  final String street;
  final String number;
  final String city;
  final String zipCode;
  final String complement;
  final String state;

  const _AddressCard({
    required this.street,
    required this.number,
    required this.city,
    required this.zipCode,
    required this.complement,
    required this.state,
  });

  @override
  State<_AddressCard> createState() => _AddressCardState();
}

class _AddressCardState extends State<_AddressCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.location_on, size: 40, color: Colors.green),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.street,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'bairro',
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${widget.city}, ${widget.zipCode}',
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Brasil',
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.edit, color: Colors.black),
                        label: Text('Alterar',
                            style: TextStyle(color: Colors.black)),
                      ),
                      const SizedBox(width: 8),
                      TextButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.delete, color: Colors.redAccent),
                        label: Text('Excluir',
                            style: TextStyle(color: Colors.redAccent)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HasNoAddressScreen extends StatelessWidget {
  const _HasNoAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final verticalPadding = screenHeight * 0.17;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(appPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: verticalPadding,
            ),
            Container(
              child: Column(
                children: [
                  Image.asset(
                    'assets/missing.png',
                    height: 300,
                    width: 300,
                  ),
                  const Text(
                    textAlign: TextAlign.center,
                    "Parece que você não tem nenhum endereço de entrega cadastrado!",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: verticalPadding,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateAddressScreen(),
                  ),
                );
                Navigator.pushNamed(context, 'create-address');
              },
              child: const ActionPrimaryButton(
                  buttonText: "Cadastrar endereço", buttonTextSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}