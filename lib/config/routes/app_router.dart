import 'package:flutter/material.dart';
import 'package:my_hand/config/routes/routes.dart';
import 'package:my_hand/features/customerscreen/customer_screen.dart';
import 'package:my_hand/features/drawer/side_nav.dart';
import 'package:my_hand/features/orderscreen/ui/order_screen.dart';

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
      case Routes.customerScreen:
        return MaterialPageRoute(
          builder: (_) => const CustomerScreen(),
        );      
      default:
        return MaterialPageRoute(
          builder: (_) => const Orderscreen(),
        );
    }
  }
}
