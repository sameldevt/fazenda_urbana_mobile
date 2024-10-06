import 'package:flutter/material.dart';
import 'package:verdeviva/common/buttons.dart';
import 'package:verdeviva/common/constants.dart';
import 'package:verdeviva/model/user.dart';
import 'package:verdeviva/service/user_service.dart';

class CreateOrModifyAddressScreen extends StatefulWidget {
  final addressIndex;
  const CreateOrModifyAddressScreen({super.key, required this.addressIndex});

  @override
  State<CreateOrModifyAddressScreen> createState() => _CreateOrModifyAddressScreenState();
}

class _CreateOrModifyAddressScreenState extends State<CreateOrModifyAddressScreen> {
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
    final theme = Theme.of(context);
    final appBarColor = theme.colorScheme.primary;
    final background = theme.colorScheme.surface;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text(
          user!.hasAddress() ? 'Editar endereço' : 'Criar endereço',
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 30,
        ),
      ),
      backgroundColor: background,
      body: _EditAddressDataForm(user: user!, addressIndex: widget.addressIndex,),
    );
  }
}

class _EditAddressDataForm extends StatefulWidget {
  final User user;
  final int addressIndex;
  _EditAddressDataForm({super.key, required this.user, required this.addressIndex});

  @override
  State<_EditAddressDataForm> createState() => _EditAddressDataFormState();
}

class _EditAddressDataFormState extends State<_EditAddressDataForm> {
  final _formKey = GlobalKey<FormState>();
  final _userService = UserService();
  bool isEditable = false;

  late Address address;

  final Map<String, String> addressInfo = {
    "street": address.street,
    "number": address.number,
    "complement": address.complement,
    "zipCode": address.zipCode,
    "city": address.city,
    "state": address.state
  };

  @override
  Widget build(BuildContext context) {
    address = widget.user.addresses.elementAt(widget.addressIndex);
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Endereço',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14,)),
                ),
                TextFormField(
                  enabled: isEditable,
                  //controller: controller,
                  decoration: InputDecoration(
                    hintText: 'Rua das Flores',
                    border: const OutlineInputBorder(),
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
                          decoration: InputDecoration(
                            hintText: '1000',
                            border: const OutlineInputBorder(),
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
                          decoration: InputDecoration(
                            hintText: 'Apto 31',
                            border: const OutlineInputBorder(),
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
                          decoration: InputDecoration(
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
                          decoration: InputDecoration(
                            hintText: 'São Paulo',
                            border: const OutlineInputBorder(),
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
                          decoration: InputDecoration(
                            hintText: 'SP',
                            border: const OutlineInputBorder(),
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
                        fontWeight: FontWeight.bold, fontSize: 14,)),
                ),
                TextFormField(
                  enabled: isEditable,
                  //controller: controller,
                  decoration: InputDecoration(
                    hintText: 'Portão branco',
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {

                  },
                  onSaved: (value) {},
                ),
              ],
            ),
            InkWell(onTap: (){
              if(isEditable){
                _userService.updateAddress(addressInfo);
              }
              isEditable = !isEditable;
            },child: ActionPrimaryButton(buttonText: isEditable ? 'Salvar alterações' : 'Editar', buttonTextSize: 20)),
            ActionSecondaryButton(buttonText: 'Voltar', buttonTextSize: 16),
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
                        side: BorderSide(color: Colors.white)),
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
    );
  }
}
