import 'package:flutter/cupertino.dart';
import 'package:verdeviva/model/user.dart';
import 'package:verdeviva/service/user_service.dart';

class UserProvider with ChangeNotifier {
  final userService = UserService();
  User? user;

  Future<void> loadUser() async {
    user = await userService.loadUserInfo();
    notifyListeners();
  }

  Future<void> saveUserInfo(User user) async {
    userService.saveUserInfo(user).then((value){
      loadUser();
    });
    notifyListeners();
  }

  Future<void> deleteUserInfo() async {
    userService.deleteUserInfo().then((value){
      user = null;
    });
    notifyListeners();
  }

  Future<void>  updateAddress(Map<String, String> info) async {
    userService.updateAddress(info);
    notifyListeners();
  }

  Future<void>  deleteAddress(Address address) async {
    userService.deleteAddress(address);
    notifyListeners();
  }

  Future<void> createAddress(Map<String, String> address) async {
    await userService.createAddress(address);
    notifyListeners();
  }
}
