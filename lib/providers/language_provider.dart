import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _currentLocale = const Locale('ar'); 

  Locale get currentLocale => _currentLocale;

  void changeLanguage(Locale newLocale) {
    if (_currentLocale == newLocale) return;
    _currentLocale = newLocale;
    notifyListeners(); 
  }
  bool get isArabic => _currentLocale.languageCode == 'ar';
}