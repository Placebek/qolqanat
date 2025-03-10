import 'package:flutter/material.dart';

class User {
  final String name;
  User(this.name);
}

class AuthProvider with ChangeNotifier {
  User? _user;
  bool get isAuthenticated => _user != null;
  User? get user => _user;

  void login(String name) {
    _user = User(name);
    notifyListeners();
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}
