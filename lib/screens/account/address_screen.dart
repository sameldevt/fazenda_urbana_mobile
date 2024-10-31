import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verdeviva/common/buttons.dart';
import 'package:verdeviva/common/constants.dart';
import 'package:verdeviva/model/user.dart';
import 'package:verdeviva/screens/account/create_or_modify_address_screen.dart';

import '../../providers/user_provider.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
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
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 30,
        ),
      ),
      backgroundColor: background,
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          return FutureBuilder<List<Address>>(
            future: userProvider.getAddresses(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                    color: background, // Define a cor de fundo enquanto carrega
                    child: const Center(
                      child: CircularProgressIndicator(),
                    )
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: const Text("Erro ao carregar endereços"),
                );
              } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                final addresses = snapshot.data!;
                return _AddressList(addresses: addresses); // Passa a lista de endereços
              } else {
                return HasNoAddressScreen();
              }
            },
          );
        },
      ),
    );
  }
}


class _AddressList extends StatefulWidget {
  final List<Address>
      addresses; // Adiciona um parâmetro para a lista de endereços

  const _AddressList({required this.addresses}); // Construtor atualizado

  @override
  State<_AddressList> createState() => _AddressListState();
}

class _AddressListState extends State<_AddressList> {
  Future<void> refresh() async {
    setState(
        () {}); // Este método pode ser utilizado para atualizar a lista, se necessário
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(appPadding),
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => const Divider(
                color: Colors.grey,
                thickness: 0.5,
              ),
              itemCount: widget.addresses.length, // Acessa a lista de endereços
              itemBuilder: (context, index) {
                final address = widget.addresses[index];
                return _AddressCard(
                  address: address,
                  onDelete: (address) {
// Obtém o provider novamente
                    final userProvider =
                        Provider.of<UserProvider>(context, listen: false);
                    userProvider.deleteAddress(address);
                    refresh(); // Chama o método refresh após deletar
                  },
                );
              },
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateAddressScreen(),
                ),
              );
            },
            child: const ActionPrimaryButton(
              buttonText: "Cadastrar endereço",
              buttonTextSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}

class _AddressCard extends StatefulWidget {
  final Address address;
  final Function(Address) onDelete;

  const _AddressCard({required this.address, required this.onDelete});

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
            const Icon(Icons.location_on, size: 40, color: Colors.green),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.address.street}, ${widget.address.number}',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${widget.address.city}, ${widget.address.state}',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${widget.address.zipCode}',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showDialog(address) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          child: Container(
            height: 530,
            width: 400,
            padding: const EdgeInsets.all(appPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/something-wrong.png',
                  height: 300,
                  width: 300,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    'Você tem certeza que deseja excluir esse endereço?',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Provider.of<UserProvider>(context).deleteAddress(address);
                  },
                  child: const ActionPrimaryButton(
                    buttonText: 'Confirmar',
                    buttonTextSize: 16,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const ActionSecondaryButton(
                    buttonText: 'Voltar',
                    buttonTextSize: 16,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class HasNoAddressScreen extends StatelessWidget {
  const HasNoAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final verticalPadding = screenHeight * 0.05;

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
              },
              child: const ActionPrimaryButton(
                  buttonText: "Cadastrar endereço", buttonTextSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
