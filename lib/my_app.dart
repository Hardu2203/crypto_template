import 'package:crypto_template/login/login_screen.dart';
import 'package:crypto_template/preferences/preference_provider.dart';
import 'package:crypto_template/sell/sell_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    AppConfig config = AppConfig.of(context)!;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PreferenceProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider(create: (context) => SellProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: config.theme,
        darkTheme: config.darkTheme,
        themeMode: config.themeMode,
        home: const LoginScreen(),
      ),
    );
  }
}
