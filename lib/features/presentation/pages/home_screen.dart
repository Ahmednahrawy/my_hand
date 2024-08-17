import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_hand/providers/theme_provider.dart';
import 'package:my_hand/features/presentation/pages/order_screen.dart';
import 'package:my_hand/features/presentation/pages/side_nav.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeState = ref.watch(appThemeStateNotifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('سَاعٍدْ'),
        centerTitle: true,
        actions: [
          Switch(
            // activeColor: Colors.black,
            value: appThemeState.isDarkModeEnabled,
            onChanged: (enabled) {
              if (enabled) {
                appThemeState.setDarkTheme();
              } else {
                appThemeState.setLightTheme();
              }
            },
          ),
        ],
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
