import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class PreferenceProvider extends ChangeNotifier {

  SharedPreferences? _prefs;

  SharedPreferences? get prefs => _prefs;

  PreferenceProvider() {
    initializeSharedPreferenceInstance();
  }

  Future<void> initializeSharedPreferenceInstance() async {
    _prefs = await SharedPreferences.getInstance();
    notifyListeners();
  }

  void setThemeMode(String themeMode) => {
    _prefs!.setString(kProdThemeMode, themeMode),
    notifyListeners()
  };
  
  String? getThemeMode() => _prefs!.getString(kProdThemeMode);
}