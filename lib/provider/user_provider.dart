import 'package:amazon_clone/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  String? prefToken;

  User _user = User(
    id: '',
    name: '',
    email: '',
    password: '',
    address: '',
    type: '',
    isAdmin: false,
    token: '',
    cart: [],
  );

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  setToken() async {
    final prefs = await SharedPreferences.getInstance();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}
