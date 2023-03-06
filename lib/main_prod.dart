import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_config.dart';
import 'constants.dart';
import 'my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var prefs = await SharedPreferences.getInstance();

  if (!prefs.containsKey(kProdThemeMode)) {
    prefs.setString(kProdThemeMode, ThemeMode.system.name.toString());
  }

  var configuredApp = AppConfig(
    environment: Environment.prod,
    appTitle: '[PROD]',
    theme: FlexThemeData.light(
      scheme: FlexScheme.deepPurple,
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 23,
      subThemesData: const FlexSubThemesData(),
      keyColors: const FlexKeyColors(
        useSecondary: true,
        useTertiary: true,
        keepPrimary: true,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
    ),
    darkTheme: FlexThemeData.dark(
      scheme: FlexScheme.deepPurple,
      surfaceMode: FlexSurfaceMode.highSurfaceLowScaffold,
      blendLevel: 20,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 20,
      ),
      keyColors: const FlexKeyColors(
        useSecondary: true,
        useTertiary: true,
        keepPrimary: true,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
    ),
    themeMode: ThemeMode.values.firstWhere((element) => element.name == prefs.getString(kProdThemeMode)),
    child: const MyApp(),
  );
  runApp(configuredApp);
}
