import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {

  String? _loggedInUser;
  AuthProvider();

  void login([String? user]) {
    _loggedInUser = user;
  }

  void logout() {
    _loggedInUser = null;
    notifyListeners();
  }

  bool isLoggedIn() {
    return _loggedInUser != null;
  }

  String? get loggedInUser => _loggedInUser;

}