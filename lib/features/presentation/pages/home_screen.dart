import 'package:flutter/material.dart';
import 'package:my_hand/features/presentation/pages/order_screen.dart';
import 'package:my_hand/features/presentation/pages/side_nav.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('سَاعٍدْ'),
        centerTitle: true,
      ),
      drawer: const Drawer(
        child: SideNav(),
        backgroundColor: Color.fromARGB(221, 134, 119, 119),
        width: 150,
      ),
      body: const Orderscreen(),
    );
  }
}
