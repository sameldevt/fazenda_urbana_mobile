import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verdeviva/common/buttons.dart';
import 'package:verdeviva/common/constants.dart';
import 'package:verdeviva/model/order.dart';
import 'package:verdeviva/model/product.dart';
import 'package:verdeviva/model/user.dart';
import 'package:verdeviva/providers/cart_provider.dart';
import 'package:verdeviva/providers/order_provider.dart';
import 'package:verdeviva/providers/user_provider.dart';
import 'package:verdeviva/screens/account/account_screen.dart';
import 'package:verdeviva/screens/account/address_screen.dart';
import 'package:verdeviva/screens/market/cart_screen.dart';
import 'package:verdeviva/screens/market/home_screen.dart';

import '../../service/access_service.dart';

class ShippingOptionScreen extends StatefulWidget {
  const ShippingOptionScreen({super.key});

  @override
  State<ShippingOptionScreen> createState() => _ShippingOptionScreenState();
}

class _ShippingOptionScreenState extends State<ShippingOptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        final theme = Theme.of(context);
        final appBarColor = theme.colorScheme.primary;
        final background = theme.colorScheme.surface;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: appBarColor,
            title: const Text(
              'Escolha como receber',
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
          body: FutureBuilder<List<Address>>(
            future: userProvider.getAddresses(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text("Erro ao carregar endereços"),
                );
              } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return const Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(appPadding),
                        child: Column(
                          children: [
                            _Header(),
                            SizedBox(height: 8),
                            _ShippingOptions(),
                            _OrderInfo(),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                // Caso a lista de endereços esteja vazia
                return const _HasNoAddressScreen();
              }
            },
          ),
        );
      },
    );
  }

}

class _HasNoAddressScreen extends StatelessWidget {
  const _HasNoAddressScreen({super.key});

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
                    builder: (context) => _CreateAddressScreen(),
                  ),
                );
              },
              child: const ActionPrimaryButton(
                buttonText: "Cadastrar endereço",
                buttonTextSize: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _CreateAddressScreen extends StatefulWidget {
  const _CreateAddressScreen({super.key});

  @override
  State<_CreateAddressScreen> createState() => _CreateAddressScreenState();
}

class _CreateAddressScreenState extends State<_CreateAddressScreen> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, String> addressInfo = {
    "street": "",
    "number": "",
    "complement": "",
    "zipCode": "",
    "city": "",
    "state": "",
    "additionalInfo": ""
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appBarColor = theme.colorScheme.primary;
    final background = theme.colorScheme.surface;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: const Text(
          'Cadastrar endereço',
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 30,
        ),
      ),
      backgroundColor: background,
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Endereço',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          TextFormField(
                            //controller: controller,
                            decoration: const InputDecoration(
                              hintText: 'Rua das Flores',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.text,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, insira seu endereço!';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              addressInfo['street'] = value!;
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Número',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  TextFormField(
                                    decoration: const InputDecoration(
                                      hintText: '1000',
                                      border: OutlineInputBorder(),
                                    ),
                                    keyboardType: TextInputType.number,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Por favor, insira o número do seu endereço!';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      addressInfo['number'] = value!;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Complemento',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  TextFormField(
                                    decoration: const InputDecoration(
                                      hintText: 'Apto 31',
                                      border: OutlineInputBorder(),
                                    ),
                                    keyboardType: TextInputType.text,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Por favor, insira o complemento do seu endereço!';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      addressInfo['complement'] = value!;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'CEP',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  TextFormField(
                                    decoration: const InputDecoration(
                                      hintText: '10101-010',
                                      border: OutlineInputBorder(),
                                    ),
                                    keyboardType: TextInputType.text,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Por favor, insira seu CEP!';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      addressInfo['zipCode'] = value!;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Cidade',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  TextFormField(
                                    decoration: const InputDecoration(
                                      hintText: 'São Paulo',
                                      border: OutlineInputBorder(),
                                    ),
                                    keyboardType: TextInputType.text,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Por favor, insira a sua cidade!';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      addressInfo['city'] = value!;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Estado',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  TextFormField(
                                    decoration: const InputDecoration(
                                      hintText: 'SP',
                                      border: OutlineInputBorder(),
                                    ),
                                    keyboardType: TextInputType.text,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Por favor, insira seu estado!';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      addressInfo['state'] = value!;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Informações adicionais',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Portão branco',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.text,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {},
                            onSaved: (value) {
                              addressInfo['additionalInfo'] = value!;
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          await Provider.of<UserProvider>(context,
                                  listen: false)
                              .createAddress(addressInfo, context)
                              .then((result) {
                            _showDialog();
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ),
                              (Route<dynamic> route) => false,
                            );

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CartScreen(),
                              ),
                            );

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ShippingOptionScreen(),
                              ),
                            );
                          }).catchError((error) {
                            _showErrorDialog(error);
                          });
                        }
                      },
                      child: const ActionPrimaryButton(
                        buttonText: 'Cadastrar',
                        buttonTextSize: 20,
                      ),
                    ),
                    const SizedBox(height: 8),
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
            ],
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(error) async {
    String content = "";
    String image = "";

    switch (error) {
      case ServerErrorException _:
        content = "Ocorreu um erro inesperado";
        image = "assets/server-error.png";
        break;
      case InvalidCredentialsException _:
        content = "A senha digitada está incorreta";
        image = "assets/wrong-password.png";
        break;
      case UserNotFoundException _:
        content = "O e-mail informando não possui cadastro.";
        image = "assets/not-found.png";
        break;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          child: Container(
            height: 500,
            width: 400,
            padding: const EdgeInsets.all(appPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  image,
                  height: 300,
                  width: 300,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    content,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(
                        context, true); // Retorna `true` ao fechar o diálogo
                  },
                  child: const ActionPrimaryButton(
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

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          child: Container(
            height: 500,
            width: 400,
            padding: const EdgeInsets.all(appPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/fixing.png',
                  height: 300,
                  width: 300,
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    'Endereço cadastrado com sucesso!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const ActionPrimaryButton(
                    buttonText: 'Ok',
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

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, child) {
      final address = userProvider.addresses[0];

      return Column(
        children: [
          const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Envios',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                const Icon(
                  Icons.pin_drop_outlined,
                  color: Colors.grey,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  'Envio para ${address.street}, ${address.number}',
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                )
              ],
            ),
          ),
        ],
      );
    });
  }
}

class _ShippingOptions extends StatefulWidget {
  const _ShippingOptions();

  @override
  State<_ShippingOptions> createState() => _ShippingOptionsState();
}

class _ShippingOptionsState extends State<_ShippingOptions> {
  int? _selectedValue = 1;

  Widget _buildShippingOption({
    required int value,
    required String label,
    required String price,
    required String deliveryTime,
  }) {
    return Row(
      children: [
        Radio<int>(
          value: value,
          groupValue: _selectedValue,
          onChanged: (int? newValue) {
            setState(() {
              _selectedValue = newValue;
            });
          },
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label,
                    style: const TextStyle(fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Text(
                      price,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
              Text(
                deliveryTime,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getLabel(int index) {
    switch (index) {
      case 0:
        return 'Envio normal';
      case 1:
        return 'Envio expresso';
      case 2:
        return 'Envio turbo';
      default:
        return '';
    }
  }

  double _getPrice(int index) {
    switch (index) {
      case 0:
        return 5.99;
      case 1:
        return 10.99;
      case 2:
        return 15.99;
      default:
        return 0;
    }
  }

  String _getDeliveryTime(int index) {
    switch (index) {
      case 0:
        return 'Entrega em até 1 semana';
      case 1:
        return 'Entrega em até 3 dias';
      case 2:
        return 'Entrega em 1 dia';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(builder: (context, orderProvider, child) {
      return Expanded(
        child: ListView.separated(
          separatorBuilder: (context, index) => const Divider(
            color: Colors.grey,
            thickness: 0.5,
          ),
          itemCount: 3,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  _selectedValue = index + 1;
                  orderProvider.addShippingCost(_getPrice(index));
                });
              },
              child: _buildShippingOption(
                value: index + 1,
                label: _getLabel(index),
                price: 'R\$ ${_getPrice(index).toStringAsFixed(2)}',
                deliveryTime: _getDeliveryTime(index),
              ),
            );
          },
        ),
      );
    });
  }
}

class _OrderInfo extends StatefulWidget {
  const _OrderInfo();

  @override
  State<_OrderInfo> createState() => _OrderInfoState();
}

class _OrderInfoState extends State<_OrderInfo> {
  String calculateTotalPrice(Set<ProductToCart> products, Order order) {
    final shippingCost = order.shippingCost;

    double total = products.fold(0.0, (total, product) => total + product.totalPrice) + shippingCost;

    return total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(builder: (context, orderProvider, child) {
      final products = Provider.of<CartProvider>(context).products;
      final order = orderProvider.order;

      if (order == null) {
        return const Center(child: Text("Erro: pedido não disponível"));
      }

      return Container(
        height: 180,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Produtos (${products.length})',
                  style: const TextStyle(fontSize: 14),
                ),
                Text(
                  'R\$ ${products.fold(0.0, (total, product) => total + product.totalPrice).toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Frete',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  'R\$ ${order.shippingCost.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  'R\$ ${calculateTotalPrice(products, order)}',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 4.0),
              child: Center(
                child: NavigationPrimaryButton(
                  route: 'payment',
                  buttonText: 'Continuar a compra',
                  buttonTextSize: 20,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
