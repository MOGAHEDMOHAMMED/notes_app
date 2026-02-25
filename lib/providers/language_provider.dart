import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _currentLocale = const Locale('ar');

  Locale get currentLocale => _currentLocale;
  LanguageProvider() {
    loadLanguage();
  }
  void loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    String? langCode = prefs.getString("LanguageCode");
    if (langCode != null) {
      _currentLocale = Locale(langCode);
      notifyListeners();
    }
  }

  void changeLanguage(Locale newLocale) async {
    if (_currentLocale == newLocale) return;
    _currentLocale = newLocale;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("LanguageCode", newLocale.languageCode);
  }

  bool get isArabic => _currentLocale.languageCode == 'ar';
}
