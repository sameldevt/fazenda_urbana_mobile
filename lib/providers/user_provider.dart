import 'package:flutter/cupertino.dart';
import 'package:verdeviva/model/order.dart';
import 'package:verdeviva/model/user.dart';
import 'package:verdeviva/service/user_service.dart';

class UserProvider with ChangeNotifier {
  final userService = UserService();
  User? user;
  List<Order>? orders;
  List<Address>? addresses;
  bool isLoading = false;

  Future<void> loadUser() async {
    user = await userService.loadUserInfo();
    notifyListeners();
  }

  Future<void> saveUserInfo(User user) async {
    await userService.saveUserInfo(user);
    loadUser();
  }

  Future<void> deleteUserInfo() async {
    await userService.deleteUserInfo();
    user = null;
    notifyListeners();
  }

  Future<void> updateAddress(Map<String, String> info) async {
    userService.updateAddress(info);
    notifyListeners();
  }

  Future<void> deleteAddress(Address address) async {
    await userService.deleteAddress(address);
    loadUser();
  }

  Future<void> createAddress(Map<String, String> address, BuildContext context) async {
    await userService.createAddress(address, context);
    loadUser();
  }

  Future<void> getAddresses(BuildContext context) async {
    addresses = await userService.getAddresses(context);
    notifyListeners();
  }

  Future<void> getOrders(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    try {
      orders = await userService.getOrders(context);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
