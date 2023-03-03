import 'package:crypto_template/login/login_screen.dart';
import 'package:crypto_template/preferences/preference_provider.dart';
import 'package:crypto_template/sell/sell_provider.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    SharedPreferences pref = await prefs;
    if (!pref.containsKey(kProdThemeMode)) {
      pref.setString(kProdThemeMode, ThemeMode.system.name.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => SellProvider())
        ],
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => PreferenceProvider(),
              lazy: false,
            )
          ],
          child: Consumer<PreferenceProvider>(
            builder: (_, prefs, __) => MaterialApp(
              title: 'Flutter Demo',
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
              themeMode: prefs.prefs != null
                  ? ThemeMode.values.firstWhere(
                      (element) => element.name == prefs.getThemeMode())
                  : ThemeMode.system,
              home: const LoginScreen(),
            ),
          ),
        )
        );
  }
}
