import 'package:crypto_template/go_router/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../auth/auth_provider.dart';
import '../auth/login/dev/login_screen.dart';
import '../buy/buy.dart';
import '../sell/create_sell_order_screen.dart';
import '../sell/sell_details_screen.dart';
import '../sell/sell_screen.dart';
import '../settings/settings_screen.dart';

const ValueKey<String> bottonNavBar = ValueKey<String>('Bottom Nav');
const ValueKey<String> buyDetails = ValueKey<String>('Buy Details');
const ValueKey<String> sellDetails = ValueKey<String>('Sell Details');

// GoRouter configuration
final router = GoRouter(
  initialLocation: "/buy",
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    ShellRoute(
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return BottomNavBar(child: child);
        },
        routes: <RouteBase>[
          GoRoute(
            path: '/buy',
            pageBuilder: (BuildContext context, GoRouterState state) =>
                FadeTransitionPage(key: bottonNavBar, child: BuyScreen()),
            routes: const <RouteBase>[],
          ),
          GoRoute(
            path: '/sell',
            pageBuilder: (BuildContext context, GoRouterState state) =>
                FadeTransitionPage(key: sellDetails, child: const SellScreen()),
            routes: <RouteBase>[
              /// Same as "/a/details", but displayed on the root Navigator by
              /// specifying [parentNavigatorKey]. This will cover both screen B
              /// and the application shell.
              GoRoute(
                path: 'create',
                pageBuilder: (BuildContext context, GoRouterState state) =>
                    FadeTransitionPage(
                        key: bottonNavBar,
                        child: const CreateSellOrderScreen()),
              ),
              GoRoute(
                path: ':orderId',
                pageBuilder: (BuildContext context, GoRouterState state) =>
                    FadeTransitionPage(
                        key: bottonNavBar,
                        child: SellDetailsScreen(
                          index: int.parse(state.params["orderId"]!),
                        )),
              ),
            ],
          ),
          GoRoute(
            path: '/settings',
            pageBuilder: (BuildContext context, GoRouterState state) =>
                FadeTransitionPage(key: sellDetails, child: const SettingsScreen()),
          ),
        ]),
  ],
  redirect: (BuildContext context, GoRouterState state) {
    if (Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
      return null;
    } else {
      return '/login';
    }
  },
);

/// A page that fades in an out.
class FadeTransitionPage extends CustomTransitionPage<void> {
  /// Creates a [FadeTransitionPage].
  FadeTransitionPage({
    required LocalKey key,
    required Widget child,
  }) : super(
            key: key,
            transitionsBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                    Widget child) =>
                FadeTransition(
                  opacity: animation.drive(_curveTween),
                  child: child,
                ),
            child: child);

  static final CurveTween _curveTween = CurveTween(curve: Curves.easeIn);
}
