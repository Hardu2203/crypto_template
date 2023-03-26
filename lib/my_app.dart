import 'package:crypto_template/auth/auth_functions/prod_web_auth_functions.dart';
import 'package:crypto_template/preferences/preference_provider.dart';
import 'package:crypto_template/sell/sell_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/auth_functions/auth_functions.dart';
import 'auth/auth_functions/dev_auth_functions.dart';
import 'auth/auth_functions/prod_mobile_auth_functions.dart';
import 'auth/auth_provider.dart';
import 'go_router/go_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppConfig config = AppConfig.of(context)!;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (ctx) => AuthProvider(buildAuthFunctions(config))),
        ChangeNotifierProxyProvider<AuthProvider, SellProvider>(
            create: (_) => SellProvider(),
            update: (ctx, auth, previousSellProvider) =>
                SellProvider(auth, previousSellProvider)),
        ChangeNotifierProvider(
          create: (_) => PreferenceProvider(),
          lazy: false,
        ),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: config.theme,
        darkTheme: config.darkTheme,
        themeMode: config.themeMode,
        routerConfig: router,
      ),
    );
  }

  AuthFunctions buildAuthFunctions(AppConfig config) {
    if (config.environment == Environment.prod) {
      if (kIsWeb) {
        return ProdWebAuthFunctions();
      } else {
        return ProdMobileAuthFunctions();
      }
    } else {
      return DevAuthFunctions();
    }
  }
}
