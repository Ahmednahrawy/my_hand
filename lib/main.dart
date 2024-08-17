import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_hand/dependency_injection.dart';
import 'package:my_hand/providers/theme_provider.dart';
import 'package:my_hand/features/presentation/pages/splash_screen.dart';

import 'package:my_hand/core/util/theme_constants.dart';

void main() async {
  runApp(const ProviderScope(child: MyApp()));
  DependencyInjection.init();
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeState = ref.watch(appThemeStateNotifier);
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'hand',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode:
          appThemeState.isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light,
      home: const Splash(),
    );
  }
}
