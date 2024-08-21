import 'package:flutter/material.dart';

// const Primary_Color = Colors.deepOrange;
// const Primary_ColorDark = Color.fromARGB(255, 3, 7, 25);
// const Accent_Color = Colors.orange;
// const Third_Color = Colors.white;
// const Accent_ColorDark = Color.fromARGB(255, 6, 6, 89);

class AppTheme {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    // scaffoldBackgroundColor: Third_Color,
    appBarTheme: const AppBarTheme(
      // color: Primary_Color,
      iconTheme: IconThemeData(
        // color: Third_Color,
      ),
      // foregroundColor: Third_Color,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        // color: Primary_ColorDark,
      ),
    ),
    // primaryColor: Third_Color,
    // backgroundColor: Primary_Color,
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
          // backgroundColor: MaterialStateProperty.all<Color>(Accent_Color),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          ),
          shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)))),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      // backgroundColor: Accent_Color,
      iconSize: 50,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
        // backgroundColor: MaterialStateProperty.all<Color>(Accent_Color),
      ),
    ),
    colorScheme: const ColorScheme.light(),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    // scaffoldBackgroundColor: Primary_ColorDark,
    appBarTheme: const AppBarTheme(
      // color: Primary_ColorDark,
      iconTheme: IconThemeData(
        // color: Third_Color,
      ),
      // foregroundColor: Third_Color,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        // color: Third_Color,
      ),
    ),
    textButtonTheme: TextButtonThemeData( 
      style: ButtonStyle(
          // backgroundColor: MaterialStateProperty.all<Color>(Accent_ColorDark),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          ),
          shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)))),
    ),
    switchTheme: SwitchThemeData(
      trackColor: MaterialStateProperty.all<Color>(Colors.grey),
      // thumbColor: MaterialStateProperty.all<Color>(Third_Color),
    ),
    colorScheme: const ColorScheme.dark(),
  );
}
