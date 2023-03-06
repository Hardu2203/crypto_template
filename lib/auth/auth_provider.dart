import 'package:flutter/material.dart';

import '../user/user_model.dart';
import 'auth_functions/auth_functions.dart';

class AuthProvider extends ChangeNotifier {

  UserModel? _loggedInUser;
  AuthFunctions authFunctions;

  AuthProvider(this.authFunctions);

  void login([UserModel? user]) {
    _loggedInUser = authFunctions.login(user);
    // _backendApi.
  }

  void logout() {
    _loggedInUser = null;
    notifyListeners();
  }

  bool isLoggedIn() {
    return _loggedInUser != null;
  }

  UserModel? get loggedInUser => _loggedInUser;



}