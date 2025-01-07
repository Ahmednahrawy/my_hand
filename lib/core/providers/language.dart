import 'package:flutter/material.dart';

class Language extends ChangeNotifier {
  // Current language of the app
  Locale _currentLocale = const Locale('ar');
  void _updateLocale(String languageCode) {
    _currentLocale = Locale(languageCode);
  }

  // Getter for current language
  Locale get currentLocale => _currentLocale;

  // Switch language function
  void switchLanguage(String languageCode) {
    if (languageCode == 'en' || languageCode == 'ar') {
      _updateLocale(languageCode);
      notifyListeners();
    } else {
      throw ArgumentError('Unsupported language code: $languageCode');
    }
  }

  // Method to check if the current language is Arabic
  bool get isArabic => _currentLocale.languageCode == 'ar';

  List<Map<String, String>> get languageOptions => [
        {
          'code': 'en',
          'assetPath': 'assets/images/english_flag.png',
          'text': 'English'
        },
        {
          'code': 'ar',
          'assetPath': 'assets/images/saudi_flag.png',
          'text': 'العربية'
        },
      ];
}
