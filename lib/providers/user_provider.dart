import 'package:flutter/cupertino.dart';
import 'package:verdeviva/model/user.dart';
import 'package:verdeviva/service/user_service.dart';

class UserProvider with ChangeNotifier{
  int? _id;
  String? _name;
  String? _profilePic;
  Contact? _contact;
  List<Address>? _addresses;

  void loadUser() async {
    final user = await UserService().loadUserInfo();

    if(user != null){
      _id = user.id;
      _name = user.name;
      _profilePic = user.profilePic;
      _contact = user.contact;
      _addresses = user.addresses;
    }

    notifyListeners();
  }
}