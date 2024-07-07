import 'package:flutter/material.dart';
import 'package:my_hand/screens/home_screen.dart';
import 'package:my_hand/screens/splash_screen.dart';
import 'package:my_hand/widgets/textbuilder.dart';

class SideNav extends StatefulWidget {
  const SideNav({super.key});

  @override
  State<SideNav> createState() => _SideNavState();
}

class _SideNavState extends State<SideNav> {
  final drawer = DrawersController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 100.0,
                decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5.0,
                        color: Colors.black45,
                        offset: Offset(5.0, 5.0),
                      )
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    color: Colors.white),
                child: const Center(
                  child: ListTile(
                    leading: CircleAvatar(
                      maxRadius: 30.0,
                      backgroundColor: Colors.black,
                      child: TextBuilder(text: 'Logo'),
                    ),
                    title: TextBuilder(
                      text: 'Invoice Management UI',
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                      fontSize: 17.0,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            ListView.builder(
              shrinkWrap: true,
              itemCount: drawer.drawer.length,
              itemBuilder: (BuildContext context, int i) {
                return ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>  const HomeScreen()),
                        (route) => false);
                  },
                  leading: Icon(
                    drawer.drawer[i].icon,
                    color: Colors.black,
                  ),
                  title: TextBuilder(
                    text: drawer.drawer[i].title,
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                );
              },
            ),
            ListTile(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const Splash()),
                      (route) => false);
                },
                leading: const Icon(
                  Icons.power_settings_new,
                  color: Colors.black,
                ),
                title: const TextBuilder(
                  text: 'Log out',
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
          ],
        ),
      )),
    );
  }
}

class DrawersController {
  final drawer = [
    DrawerModel('الرئيسية', Icons.home),
    DrawerModel('موردين', Icons.receipt_long),
    DrawerModel('عملاء', Icons.account_balance),
    DrawerModel('مخزون', Icons.person),
    // DrawerModel('Share App', Icons.share),
  ];
}

class DrawerModel {
  final String? title;
  final IconData? icon;

  DrawerModel(this.title, this.icon);
}
