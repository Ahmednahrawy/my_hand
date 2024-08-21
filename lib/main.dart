import 'package:flutter/material.dart';
import 'package:my_hand/features/presentation/pages/splash_screen.dart';

import 'package:my_hand/core/util/theme_constants.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'hand',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const Splash(),
    );
  }
}
