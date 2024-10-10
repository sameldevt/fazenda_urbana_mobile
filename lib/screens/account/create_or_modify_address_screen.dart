import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verdeviva/common/buttons.dart';
import 'package:verdeviva/common/constants.dart';
import 'package:verdeviva/model/user.dart';
import 'package:verdeviva/service/access_service.dart';
import 'package:verdeviva/service/user_service.dart';

import '../../providers/user_provider.dart';

class EditAddressScreen extends StatefulWidget {
  final int addressIndex;

  EditAddressScreen({super.key, required this.addressIndex});

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final _userService = UserService();
  bool isEditable = false;

  late Address address;

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
    address = user!.addresses.elementAt(widget.addressIndex);

    final Map<String, String> addressInfo = {
      "street": address.street,
      "number": address.number,
      "complement": address.complement,
      "zipCode": address.zipCode,
      "city": address.city,
      "state": address.state
    };

    final theme = Theme.of(context);
    final appBarColor = theme.colorScheme.primary;
    final background = theme.colorScheme.surface;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: const Text(
          'Editar endereço',
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 30,
        ),
      ),
      backgroundColor: background,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Endereço',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        )),
                  ),
                  TextFormField(
                    enabled: isEditable,
                    //controller: controller,
                    decoration: const InputDecoration(
                      hintText: 'Rua das Flores',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira seu endereço!';
                      }
                      return null;
                    },
                    onSaved: (value) {},
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
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
                            enabled: isEditable,
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
                            onSaved: (value) {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
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
                            enabled: isEditable,
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
                            onSaved: (value) {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
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
                            enabled: isEditable,
                            obscureText: true,
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
                            onSaved: (value) {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
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
                            enabled: isEditable,
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
                            onSaved: (value) {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
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
                            enabled: isEditable,
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
                            onSaved: (value) {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Informações adicionais',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        )),
                  ),
                  TextFormField(
                    enabled: isEditable,
                    //controller: controller,
                    decoration: const InputDecoration(
                      hintText: 'Portão branco',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {},
                    onSaved: (value) {},
                  ),
                ],
              ),
              InkWell(
                  onTap: () {
                    if (isEditable) {
                      _userService.updateAddress(addressInfo);
                    }
                    isEditable = !isEditable;
                  },
                  child: ActionPrimaryButton(
                      buttonText: isEditable ? 'Salvar alterações' : 'Editar',
                      buttonTextSize: 20)),
              const ActionSecondaryButton(
                  buttonText: 'Voltar', buttonTextSize: 16),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: Colors.white)),
                    ),
                    onPressed: () {
                      setState(() {
                        isEditable = !isEditable;
                      });
                    },
                    child: Text(
                      isEditable ? 'Salvar alterações' : 'Editar',
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CreateAddressScreen extends StatefulWidget {
  const CreateAddressScreen({super.key});

  @override
  State<CreateAddressScreen> createState() => _CreateAddressScreenState();
}

class _CreateAddressScreenState extends State<CreateAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final _userService = UserService();

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
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          Provider.of<UserProvider>(context, listen: false)
                              .createAddress(addressInfo)
                              .then((result) {
                            _showDialog();
                            Navigator.pop(context, true);
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

  void _showErrorDialog(error) {
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
                    Navigator.pop(context);
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
                    Navigator.pushReplacementNamed(
                        context, 'address-list');
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
