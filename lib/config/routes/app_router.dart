import 'package:flutter/material.dart';
import 'package:my_hand/config/routes/routes.dart';
import 'package:my_hand/features/orderscreen/order_screen.dart';
import 'package:my_hand/features/presentation/pages/side_nav.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.orderScreen:
        return MaterialPageRoute(
          builder: (_) => const Orderscreen(),
        );
      case Routes.sideNav:
        return MaterialPageRoute(
          builder: (_) => const SideNav(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
