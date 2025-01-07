import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:my_hand/config/routes/app_router.dart';
import 'package:my_hand/config/routes/routes.dart';
import 'package:my_hand/config/theme/colors.dart';
import 'package:my_hand/core/providers/language.dart';
import 'package:my_hand/generated/l10n.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouter});
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    final languageManager = Provider.of<Language>(context);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MaterialApp(
        // to show performance while using app
        // showPerformanceOverlay: true,
        debugShowCheckedModeBanner: false,
        title: 'hand',
        theme: ThemeData(
          primaryColor: ColorsManager.mainBlue,
          scaffoldBackgroundColor: Colors.white,
        ),
        locale: languageManager.currentLocale,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        initialRoute: Routes.orderScreen,
        onGenerateRoute: appRouter.generateRoute,
      ),
    );
  }
}
